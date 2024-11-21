package com.tech.whale.profile.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class ProfileDto {

	private String user_id;
	private String user_nickname;
	private String user_image_url;
	private int account_privacy;
	private int profile_id;
	private int follow_id;
	private String track_id;
	private String track_artist;
	private String track_name;
	private String track_cover;

}
