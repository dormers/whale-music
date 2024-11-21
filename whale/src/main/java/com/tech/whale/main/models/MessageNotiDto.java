package com.tech.whale.main.models;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class MessageNotiDto {
	private int message_id;
	private Date message_create_date;
	private String message_text;
	private String target_user_id;
	private int message_room_id;
	private int message_read;
	private String message_type;
}
