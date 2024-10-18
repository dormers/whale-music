package com.tech.whale.community.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class PostDto {
	private int post_id;
	private int community_id;
	private String user_id;
	private String post_title;
	private String post_text;
	private String post_date;
	private String post_url;
	private int post_cnt;
	private int post_num;
	
	private int post_tag_id;
	private String post_tag_text;
	private int likeCount;
	private String post_comments_text;
	
	private List<CommentDto> comments;
	
	private String post_img_url;
	private List<PostImgDto> images;
	
	private String user_nickname;
	private String user_image_url;
}
