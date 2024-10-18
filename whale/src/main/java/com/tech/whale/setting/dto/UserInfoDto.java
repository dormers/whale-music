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
	public UserInfoDto(String user_id, String user_email, String user_image_url, String user_password) {
		this.user_id = user_id;
		this.user_password = user_password;
		this.user_email = user_email;
		this.user_image_url = user_image_url;
	}
	private String user_id;
	private String user_password;
	private String user_nickname;
	private String user_email;
	private String user_image_url;
	private int user_access_id;
	private String user_spotify_id;

}
