package com.tech.whale.community.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class MemberDto {
	private String user_id;
	private String user_email;
	private String user_image_url;
	private String user_gender;
	private String user_nickname;
	private String user_spotify_url;
	private String user_country;
	private String user_access_token;
	private String user_refresh_token;
	private String user_password;
}
