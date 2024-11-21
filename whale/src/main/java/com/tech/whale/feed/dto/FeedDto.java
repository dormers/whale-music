package com.tech.whale.feed.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class FeedDto {

	private int feed_id;
	private String user_id;
	private String feed_text;
	private String feed_date;
	private String feed_url;
	private int feed_open;
	
	private String feed_img_name;
	private String user_image_url;
	private String user_nickname;
	private String feed_tag_text;
	private String feed_img_url;
	private String feed_comments_text;
	
    private List<FeedCommentDto> feedComments; // 피드에 달린 댓글 리스트
    private int likeCount;
    private int commentsCount;
    
    private int feed_music_id;
    private String track_id;
    private String track_artist;
    private String track_name;
    private String track_album;
    private String track_cover;
}
