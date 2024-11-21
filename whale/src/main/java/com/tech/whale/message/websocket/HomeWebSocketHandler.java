// src/main/java/com/tech/whale/message/websocket/HomeWebSocketHandler.java

package com.tech.whale.message.websocket;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

@Component
public class HomeWebSocketHandler extends TextWebSocketHandler {

    // 사용자 ID와 세션을 매핑
    private ConcurrentMap<String, WebSocketSession> userSessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 사용자 ID는 쿼리 파라미터로 전달된다고 가정 (예: ws://localhost:8080/home?userId=kim)
        String userId = getUserIdFromSession(session);
        if (userId != null) {
            userSessions.put(userId, session);
            System.out.println("Home WebSocket 연결: " + userId);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String userId = getUserIdFromSession(session);
        if (userId != null) {
            userSessions.remove(userId);
            System.out.println("Home WebSocket 연결 해제: " + userId);
        }
    }

    // 메시지를 특정 사용자에게 전송하는 메서드
    public void sendMessageToUser(String userId, String message) {
        WebSocketSession session = userSessions.get(userId);
        if (session != null && session.isOpen()) {
            try {
                session.sendMessage(new TextMessage(message));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // 세션에서 사용자 ID 추출 (쿼리 파라미터 사용)
    private String getUserIdFromSession(WebSocketSession session) {
        String query = session.getUri().getQuery(); // 예: userId=kim
        if (query != null) {
            for (String param : query.split("&")) {
                String[] pair = param.split("=");
                if (pair.length == 2 && pair[0].equals("userId")) {
                    return pair[1];
                }
            }
        }
        return null;
    }
}
