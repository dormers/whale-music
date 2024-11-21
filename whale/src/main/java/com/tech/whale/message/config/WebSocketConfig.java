package com.tech.whale.message.config;

import com.tech.whale.message.websocket.HomeWebSocketHandler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import com.tech.whale.message.websocket.ChatWebSocketHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    private final ChatWebSocketHandler chatWebSocketHandler;
    private final HomeWebSocketHandler homeWebSocketHandler;
    
    @Autowired
    public WebSocketConfig(ChatWebSocketHandler chatWebSocketHandler,
    		HomeWebSocketHandler homeWebSocketHandler
    		) {
        this.chatWebSocketHandler = chatWebSocketHandler;
        this.homeWebSocketHandler = homeWebSocketHandler;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(chatWebSocketHandler, "/chat").setAllowedOrigins("*");
        // 새로운 홈 WebSocket 핸들러 등록
        registry.addHandler(homeWebSocketHandler, "/home").setAllowedOrigins("*");
    }
}