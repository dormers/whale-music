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
public class CommentDto {
	private String post_comments_id;

	private String user_id;
    private String post_comments_text;
    private String post_comments_date;
    
    private String parent_comments_id; // 부모 댓글 ID (null이면 최상위 댓글)
    private String user_image_url;    // 유저 프로필 이미지 URL
    private int likeCount;            // 좋아요 수
    private int replyCount;           // 답글 수
    private List<CommentDto> replies;

    
}
