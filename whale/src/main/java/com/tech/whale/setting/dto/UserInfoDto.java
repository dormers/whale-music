package com.tech.whale.setting.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class UserInfoDto {
	private String user_id;
	private String user_password;
	private String user_nickname;
	private String user_email;
	private String user_image_url;
	private int user_access_id;
	private String user_spotify_id;
	private String user_track_id;
	private String track_artist;
	private String track_name;
}
