package com.tech.whale.admin.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminPFCDto {
	private int post_comments_id;
	private int post_id;
	private String user_id;
	private String post_comments_text;
	private Date post_comments_date;
	
	private int community_id;
	private String community_name;
	private String post_text;
	private Date post_date;
	private String post_url;
	private int post_cnt;
	private String post_title;
	private int post_num;
	private int post_tag_id;
	private String post_tag_text;
	
	private int feed_id;
	private String feed_text;
	private Date feed_date;
	private String feed_url;
	private int feed_open;
	
	private int feed_comments_id;
	private String feed_comments_text;
	private Date feed_comments_date;
	
	private Date comments_date;
	
	private int follow;
	private int follower;
	
	private int report_feed_count;
	private int report_post_count;
	private int report_feed_comments_count;
	private int report_post_comments_count;
	private String text;
	private Date date_field;
	
	
}
