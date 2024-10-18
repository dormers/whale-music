package com.tech.whale.community.dto;

public class CommentDto {
	private String post_comments_id;

	private String user_id;
    private String post_comments_text;
    private String post_comments_date;
    
    
    
	public String getPost_comments_id() {
		return post_comments_id;
	}
	public void setPost_comments_id(String post_comments_id) {
		this.post_comments_id = post_comments_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPost_comments_text() {
		return post_comments_text;
	}
	public void setPost_comments_text(String post_comments_text) {
		this.post_comments_text = post_comments_text;
	}
	public String getPost_comments_date() {
		return post_comments_date;
	}
	public void setPost_comments_date(String post_comments_date) {
		this.post_comments_date = post_comments_date;
	}
    
    
}
