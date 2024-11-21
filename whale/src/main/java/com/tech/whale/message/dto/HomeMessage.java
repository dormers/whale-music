package com.tech.whale.message.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class HomeMessage {
    private String receiverId;
    private String senderId;
    private String messageType;
    private String messageText;
    private String timeDifference;
    private String userImageUrl;
    private String messageRoomId;
    private String senderNickname;

}
