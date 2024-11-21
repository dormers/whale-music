package com.tech.whale.message.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tech.whale.Image.controller.LinkPreviewUtils;
import com.tech.whale.message.dao.MessageDao;
import com.tech.whale.message.dto.FollowListDto;
import com.tech.whale.message.dto.LinkMessageDto;
import com.tech.whale.message.dto.MessageDto;
import com.tech.whale.message.websocket.ChatWebSocketHandler;

@Controller
public class MessageController {

	@Autowired
	private MessageDao messageDao;
	
    @Autowired
    private ChatWebSocketHandler chatWebSocketHandler;
    
    @Autowired
    private LinkPreviewUtils linkPreviewUtils;

    private MessageDto getOrCreateRoom(String nowId, String userId) {
        MessageDto messageDto = messageDao.getAllRoom(nowId, userId);
        String roomId = "";
        if (messageDto == null || messageDto.getMessage_room_id() == null) {
            roomId = messageDao.getNextRoomId();
            messageDao.createMessageRoom(roomId);
            messageDao.addUserMessageRoom(roomId, userId, "A");
            messageDao.addUserMessageRoom(roomId, nowId, "B");
            messageDto = messageDao.getAllRoom(nowId, userId);
        } else {
            roomId = messageDto.getMessage_room_id();
        }
        return messageDto;
    }
    
	@RequestMapping("/messageGo")
	public String messageGo(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam("u") String userId) {
		String now_id = (String) session.getAttribute("user_id");
		System.out.println(userId);
		MessageDto messageDto = getOrCreateRoom(now_id, userId);
		String roomId = messageDto.getMessage_room_id();
		
		model.addAttribute("roomId", roomId);
		return "redirect:/messageRoom?r=" + roomId + "&u=" + userId;			
	}
	
	
	@RequestMapping("/messageLinkGo")
	public String messageLinkGo(HttpServletRequest request, HttpSession session, Model model,
	                            @RequestParam("u") String userId,
	                            @RequestParam("l") String link_id) throws IOException {
	    String now_id = (String) session.getAttribute("user_id");
	    MessageDto messageDto = getOrCreateRoom(now_id, userId);
	    String roomId = messageDto.getMessage_room_id();

	    // 상대방이 해당 채팅방에 접속해 있는지 확인
	    boolean isRecipientInRoom = chatWebSocketHandler.isUserInRoom(roomId, userId);

	    // 링크 메시지 생성 및 저장
	    MessageDto newMessage = new MessageDto();
	    newMessage.setMessage_room_id(roomId);
	    newMessage.setUser_id(now_id);
	    newMessage.setMessage_create_date(new Date());
	    newMessage.setMessage_type("LINK");

	    // 링크에서 미리보기 데이터 생성
	    Map<String, String> previewData = linkPreviewUtils.fetchOpenGraphData(link_id);
	    ObjectMapper objectMapper = new ObjectMapper();
	    String messageText = link_id;

	    if (previewData != null && !previewData.isEmpty()) {
	        String previewJson = objectMapper.writeValueAsString(previewData);
	        messageText = link_id + "#preview=" + previewJson;
	    }

	    newMessage.setMessage_text(messageText);

	    if (isRecipientInRoom) {
	        newMessage.setMessage_read(0); // 상대방이 채팅방에 있으므로 읽음 처리
	    } else {
	        newMessage.setMessage_read(1); // 상대방이 채팅방에 없으므로 읽지 않음으로 표시
	    }

	    int messageId = messageDao.getNextMessageId();
	    newMessage.setMessage_id(messageId);
	    messageDao.saveMessage(newMessage);

	    // 메시지 전송을 위해 날짜 포맷팅
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String formattedDate = dateFormat.format(new Date());

	    String formattedMessage = String.format("%s#%s#%s#%s#%d#%s",
	            roomId, now_id, "LINK", messageText, newMessage.getMessage_read(), formattedDate);

	    // 채팅방에 메시지 브로드캐스트
	    chatWebSocketHandler.broadcastMessageToRoom(roomId, formattedMessage);

	    return "redirect:/messageRoom?r=" + roomId + "&u=" + userId;
	}
			
	
	@RequestMapping("/linkMessage")
	public String linkMessage(HttpServletRequest request, HttpSession session, Model model,
            @RequestParam(value = "p", required = false) String post_id,
            @RequestParam(value = "f", required = false) String feed_id,
            @RequestParam(value = "c", required = false) String comm_id) {
		String now_id = (String) session.getAttribute("user_id");
		String ip = "http://25.5.112.217:9002/whale/";
		String link_id = "";
		String user_id = "";
		if (post_id != null) {
			user_id = messageDao.findPostUser(post_id);
			link_id = ip + "communityDetail?c=" + comm_id + "&p=" + post_id;
		} else if (feed_id != null) {
			user_id = messageDao.findFeedUser(feed_id);
			link_id = ip + "feedDetail?f=" + feed_id;			
		}
		List<FollowListDto> followList = messageDao.getFollowList(now_id);
		List<LinkMessageDto> linkMessageUser = messageDao.getLinkUser(user_id);
		System.out.println(link_id);
		
		model.addAttribute("now_id", now_id);
		model.addAttribute("followList", followList);
		model.addAttribute("linkMessageUser",linkMessageUser);
		model.addAttribute("link_id", link_id);
		return "message/newLinkChat";
	}


	@RequestMapping("/messageRoom")
	public String messageRoom(HttpServletRequest request, HttpSession session, Model model,
	                          @RequestParam("r") String roomId,
	                          @RequestParam("u") String userId) {
	    String now_id = (String) session.getAttribute("user_id");
	    
	    String userType = messageDao.getUserType(now_id, roomId);
	    
	    int userTypeInt = 0;
	    
	    if (userType.equals("A")) {
			userTypeInt = 0;
		} else {
			userTypeInt = 1;
		}
	    
	    List<MessageDto> messages = messageDao.getMessagesByRoomId(roomId, userTypeInt);

	    ObjectMapper objectMapper = new ObjectMapper();
	    for (MessageDto msg : messages) {
	        if ("LINK".equals(msg.getMessage_type())) {
	            String messageText = msg.getMessage_text();
	            String textContent = messageText.contains("#preview=") ?
	                    messageText.split("#preview=")[0] : messageText;
	            msg.setMessage_text(textContent);

	            // JSON 데이터 파싱하여 previewData 설정
	            if (messageText.contains("#preview=")) {
	                String previewJson = messageText.split("#preview=")[1];
	                try {
	                    Map<String, String> previewData = objectMapper.readValue(previewJson, HashMap.class);
	                    msg.setPreviewData(previewData); // MessageDto에 previewData 추가 필요
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }

	    String userImage = messageDao.getUserImage(userId);
	    
	    model.addAttribute("userImage", userImage);
	    model.addAttribute("messages", messages);
	    model.addAttribute("now_id", now_id);
	    model.addAttribute("userId", userId);
	    model.addAttribute("roomId", roomId);
	    return "message/messageRoom";
	}
	
	@PostMapping("/deleteMessage")
	@ResponseBody
	public Map<String, String> deleteMessage(@RequestParam("messageId") int messageId, HttpSession session) {
	    Map<String, String> response = new HashMap<>();
	    String now_id = (String) session.getAttribute("user_id");

	    // 메시지 소유자 확인
	    MessageDto message = messageDao.getMessageById(messageId);
	    
	    if (message != null && message.getUser_id().equals(now_id)) {
	        // 메시지 삭제
	        messageDao.deleteMessage(messageId);
	        response.put("status", "success");
	    } else {
	        response.put("status", "error");
	        response.put("message", "권한이 없습니다.");
	    }

	    return response;
	}
	
}
