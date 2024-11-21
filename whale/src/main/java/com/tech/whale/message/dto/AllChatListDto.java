package com.tech.whale.message.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class AllChatListDto {
    private String user_id;
    private int message_room_id;
    private String user_nickname;
    private String user_image_url;
    private int unread_message_count;
    private String time_difference;
    private String last_message_read;
    private String last_message_text;
    private Timestamp last_message_create_date;
    private String last_message_sender_id;
    private String last_message_type;

}
