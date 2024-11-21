package com.tech.whale.setting.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class LikeListDto {

	private int post_id;
	private int community_id;
	private String user_id;
	private String post_title;
	private String post_text;
	private String post_tag_text;
	private String post_date;
	private int post_cnt;
	private int total_like_count;
	private int total_comment_count;

	private int feed_id;
	private String feed_img_url;
}
