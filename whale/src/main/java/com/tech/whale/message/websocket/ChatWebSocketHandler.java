// src/main/java/com/tech/whale/message/websocket/ChatWebSocketHandler.java

package com.tech.whale.message.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tech.whale.Image.controller.LinkPreviewUtils;
import com.tech.whale.message.dao.MessageDao;
import com.tech.whale.message.dto.MessageDto;
import com.tech.whale.message.dto.HomeMessage;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    // roomId별로 WebSocketSession 목록을 관리
    private final Map<String, List<WebSocketSession>> roomSessions = new ConcurrentHashMap<>();
    private final Map<String, List<WebSocketSession>> userSessions = new ConcurrentHashMap<>();
    private final MessageDao messageDao;
    private final LinkPreviewUtils linkPreviewUtils;

    @Autowired
    private HomeWebSocketHandler homeWebSocketHandler;


    private ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    public ChatWebSocketHandler(MessageDao messageDao, LinkPreviewUtils linkPreviewUtils) {
        this.messageDao = messageDao;
        this.linkPreviewUtils = linkPreviewUtils;
        
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // roomId를 세션 URL에서 가져옵니다.
        String roomId = getRoomIdFromSession(session);
        String userId = getUserIdFromSession(session);
        if (roomId != null) {
            session.getAttributes().put("roomId", roomId); // session에 roomId 저장
            session.getAttributes().put("userId", userId);

            // roomId에 해당하는 세션 목록에 추가
            roomSessions.computeIfAbsent(roomId, k -> new CopyOnWriteArrayList<>()).add(session);
            userSessions.computeIfAbsent(userId, k -> new CopyOnWriteArrayList<>()).add(session);
            System.out.println("WebSocket 연결 성공: " + userId + " | Room ID: " + roomId);
            System.out.println(roomId);

			String otherUserId = messageDao.getOtherUserInRoom2(roomId, userId);
			System.out.println(userId);
			System.out.println(otherUserId);
			
			
			
			List<Integer> updatedMessageIds = messageDao.getUnreadMessageIds(roomId, otherUserId);
			
			 if (!updatedMessageIds.isEmpty() || updatedMessageIds != null) {
		            // 메시지의 읽음 상태 업데이트
		        messageDao.updateMessageReadStatus(roomId, otherUserId);

	                String messageIdsStr = updatedMessageIds.stream()
	                        .map(String::valueOf)
	                        .collect(Collectors.joining(","));
	                System.out.println(messageIdsStr);
	                String readNotification = String.format("READ:%s:%s", roomId, messageIdsStr);
	                TextMessage readMessage = new TextMessage(readNotification);
	                System.out.println(readMessage);

	                sendToUser(otherUserId, readMessage);
	                sendToUser(userId, readMessage);
	                }
        } else {
            System.out.println("Room ID 없음으로 세션 거부: " + session.getId());
            session.close(CloseStatus.BAD_DATA);
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        try {
            String payload = message.getPayload();
            String[] parts = payload.split(":", 4);
            if (parts.length < 4) {
                System.err.println("Invalid message format: " + payload);
                return;
            }

            String roomId = parts[0];
            String userId = parts[1];
            String messageType = parts[2];
            String messageContent = parts[3];

            MessageDto messageDto = new MessageDto();
            messageDto.setMessage_room_id(roomId);
            messageDto.setUser_id(userId);
            messageDto.setMessage_create_date(new Date());
            messageDto.setMessage_type(messageType);
            
            List<WebSocketSession> sessions = roomSessions.get(roomId);
            boolean isUserInRoom = sessions != null && sessions.stream().anyMatch(s -> !s.getId().equals(session.getId()));

            if (isUserInRoom) {
                messageDto.setMessage_read(0);  // 상대방이 현재 방에 있으므로 읽음 처리
            } else {
                messageDto.setMessage_read(1);  // 상대방이 방에 없으므로 읽지 않음으로 표시
            }
            
            if ("TEXT".equals(messageType) && containsUrl(messageContent)) {
                messageType = "LINK";
                String url = extractUrl(messageContent);
                messageDto.setMessage_type(messageType);

                if (url.contains("youtube.com") || url.contains("youtu.be")) {
                    String embedHtml = fetchYouTubeEmbedHtml(url);
                    messageDto.setMessage_text(embedHtml);
                    System.out.println("YouTube embed HTML created: " + embedHtml);
                } else {
                    Map<String, String> previewData = linkPreviewUtils.fetchOpenGraphData(url);

                    // 미리보기 데이터 확인
                    if (previewData != null && !previewData.isEmpty()) {
                        String previewJson = objectMapper.writeValueAsString(previewData);
                        messageDto.setMessage_text(messageContent + "#preview=" + previewJson);
                        System.out.println("Preview data created for URL " + url + ": " + previewJson);
                    } else {
                        System.out.println("No preview data available for URL: " + url);
                    }
                }
            } else if ("IMAGE".equals(messageType)) {
                messageDto.setMessage_text(messageContent);
            } else if ("MUSIC".equals(messageType)) {
                // track_id에 기반해 track 정보 조회
                Map<String, String> trackInfo = messageDao.getTrackInfo(messageContent);
                if (trackInfo != null) {
                    String trackJson = objectMapper.writeValueAsString(trackInfo);
                    messageDto.setMessage_text(trackJson);  // JSON으로 직렬화된 트랙 정보를 저장
                }
            } else {
                messageDto.setMessage_text(messageContent);
            }
            
            int messageId = messageDao.getNextMessageId();
            
            messageDto.setMessage_id(messageId);

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String formattedDate = dateFormat.format(new Date());

            String formattedMessage = String.format("%s#%s#%s#%d#%s#%d#%s",
                    roomId, userId, messageType, messageId, messageDto.getMessage_text(), messageDto.getMessage_read(), formattedDate);

            // 채팅방에 메시지 브로드캐스트
            broadcastToRoom(roomId, new TextMessage(formattedMessage));

            if ("MUSIC".equals(messageType)) {
				messageDto.setMessage_text(messageContent);
			}
            // DB에 메시지 저장
            messageDao.saveMessage(messageDto);
            


            String otherUserId = messageDao.getOtherUserInRoom2(roomId, userId);
            
            String userImgUrl = messageDao.getUserImage(userId);
           
            String senderNickname = messageDao.getUserNickname(userId);
            
            String messageT = "";
            
            // Home 페이지에 메시지 알림 전송
            HomeMessage homeMessage = new HomeMessage();
            homeMessage.setReceiverId(otherUserId); // receiver_id는 추가로 설정 필요
            homeMessage.setSenderId(userId);
            homeMessage.setMessageType(messageType);
            if (messageType.equals("TEXT")) {
            	homeMessage.setMessageText(messageDto.getMessage_text());				
			} else if (messageType.equals("IMAGE")) {
				messageT = "이미지를 보냈습니다.";
				homeMessage.setMessageText(messageT);								
			} else if (messageType.equals("LINK")) {
				messageT = "링크를 보냈습니다.";
				homeMessage.setMessageText(messageT);
			} else if (messageType.equals("MUSIC")) {
				messageT = "음악을 보냈습니다.";
				homeMessage.setMessageText(messageT);
			}
            homeMessage.setTimeDifference(calculateTimeDifference());
            homeMessage.setUserImageUrl(userImgUrl);
            homeMessage.setMessageRoomId(roomId);
            homeMessage.setSenderNickname(senderNickname);
            
            System.out.println(homeMessage.getReceiverId());

            String homeMessageJson = objectMapper.writeValueAsString(homeMessage);
            homeWebSocketHandler.sendMessageToUser(homeMessage.getReceiverId(), homeMessageJson);
            
        } catch (Exception e) {
            e.printStackTrace();
            session.sendMessage(new TextMessage("Error: " + e.getMessage()));
            session.close(CloseStatus.SERVER_ERROR);
        }
    }

    private boolean containsUrl(String text) {
        return text.contains("http://") || text.contains("https://");
    }

    private String extractUrl(String text) {
        String urlRegex = "(https?://[\\w\\-]+(\\.[\\w\\-]+)+[/#?]?.*)";
        Pattern pattern = Pattern.compile(urlRegex);
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    private String fetchYouTubeEmbedHtml(String url) {
        return "<iframe src=\"https://www.youtube.com/embed/" + extractYouTubeId(url) +
                "\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>";
    }

    private String extractYouTubeId(String url) {
        String pattern = "(?<=watch\\?v=|/videos/|embed/|youtu.be/|/v/|/e/|watch\\?v%3D|watch\\?feature=player_embedded&v=|%2Fvideos%2F|embed%2F|youtu.be%2F|%2Fv%2F)[^#&?\\n]*";
        Pattern compiledPattern = Pattern.compile(pattern);
        Matcher matcher = compiledPattern.matcher(url);
        return matcher.find() ? matcher.group() : "";
    }

    protected void broadcastToRoom(String roomId, TextMessage message) throws IOException {
        List<WebSocketSession> sessions = roomSessions.get(roomId);
        if (sessions != null) {
            for (WebSocketSession sess : sessions) {
                if (sess.isOpen()) {
                    sess.sendMessage(message);
                }
            }
        }
    }
    
    public boolean isUserInRoom(String roomId, String userId) {
    	System.out.println("roomId : " + roomId);
        List<WebSocketSession> sessions = roomSessions.get(roomId);
        System.out.println("sessions : " + sessions);
        System.out.println("userId : " + userId);
        if (sessions != null) {
            for (WebSocketSession session : sessions) {
                String sessionUserId = (String) session.getAttributes().get("userId");
                if (userId.equals(sessionUserId)) {
                    return true;
                }
            }
        }
        return false;
    }
    
    public void broadcastMessageToRoom(String roomId, String formattedMessage) throws IOException {
        broadcastToRoom(roomId, new TextMessage(formattedMessage));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // 세션을 종료할 때 roomId에 해당하는 세션 목록에서 제거
        String roomId = (String) session.getAttributes().get("roomId");
        if (roomId != null) {
            List<WebSocketSession> sessions = roomSessions.get(roomId);
            if (sessions != null) {
                sessions.remove(session);
                if (sessions.isEmpty()) {
                    roomSessions.remove(roomId);
                }
            }
        }
        System.out.println("WebSocket 연결 종료: " + session.getId() + " | Room ID: " + roomId);
    }

    private String getRoomIdFromSession(WebSocketSession session) {
        String query = session.getUri().getQuery();
        if (query != null && query.contains("roomId=")) {
            String[] params = query.split("&");
            for (String param : params) {
                if (param.startsWith("roomId=")) {
                    return param.split("=")[1];
                }
            }
        }
        return null;
    }
    
    private String getUserIdFromSession(WebSocketSession session) {
        String query = session.getUri().getQuery();
        if (query != null && query.contains("userId=")) {
            String[] params = query.split("&");
            for (String param : params) {
                if (param.startsWith("userId=")) {
                    return param.split("=")[1];
                }
            }
        }
        return null;
    }

    private String calculateTimeDifference() {
        // 실제 시간 차이 계산 로직 구현
        return "방금 전"; // 예시
    }
    
    private void sendToUser(String userId, TextMessage message) throws IOException {
        List<WebSocketSession> sessions = userSessions.get(userId);
        if (sessions != null) {
            for (WebSocketSession session : sessions) {
                if (session.isOpen()) {
                    session.sendMessage(message);
                }
            }
        }
    }
}
