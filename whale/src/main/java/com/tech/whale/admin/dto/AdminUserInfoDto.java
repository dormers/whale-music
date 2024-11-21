package com.tech.whale.admin.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminUserInfoDto{
	private String user_id;
	private String user_password;
	private String user_nickname;
	private String user_email;
	private String user_image_url;
	private String user_access_str;
	private String user_status_str;
	private String user_spotify_id;
	private int user_access_id;
	private int user_status;
	private int post_count;
	private int comments_count;
	private int feed_count;
	private Date user_date;
	
	private int follow;
	private int follower;
}
