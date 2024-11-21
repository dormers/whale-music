package com.tech.whale.message.dto;

import java.util.Date;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class MessageDto {
	private int message_id;
	private Date message_create_date;
	private String message_text;
	private String message_room_id;
	private int message_read;
	private String user_id;
	private String user_image_url;
	
	private int message_image_id;
	private String message_image_url;
	
	private int message_music_id;
	private String track_id;

	private String message_type;
	private Map<String, String> previewData;
	
	private String receiver_id;
	
	private String track_artist;
	private String track_name;
	private String track_cover;
	
}
