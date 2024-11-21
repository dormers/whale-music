package com.tech.whale.setting.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ReportDto {
	private int report_id;
	private String user_id;
	private String feed_id;
	private String feed_comments_id;
	private String post_id;
	private String post_comments_id;
	private String message_id;
	private String report_why;
	private Date report_date;
	private String report_tag;
	
	private String report_text;
	private String report_img_url;
}
