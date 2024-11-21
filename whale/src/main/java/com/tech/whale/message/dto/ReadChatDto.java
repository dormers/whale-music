package com.tech.whale.message.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class ReadChatDto {
    private String user_id;
    private Integer minutes_since_last_message;
    private Integer unread_message_count;
    private String last_message_text;
    private String time_difference;

}
