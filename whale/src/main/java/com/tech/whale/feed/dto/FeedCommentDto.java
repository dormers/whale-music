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
public class FeedCommentDto {
	
    private int feed_comments_id;
    private String user_id;
    private int feed_id;
    private String feed_comments_text;
    private String feed_comments_date;
    private String parent_comments_id;

    private String user_nickname;
    private String user_image_url;
    
    private int likeCount;
    private int replyCount;
    private boolean likedByCurrentUser;
    
    private List<FeedCommentDto> replies;
}
