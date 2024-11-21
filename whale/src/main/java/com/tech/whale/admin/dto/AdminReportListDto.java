package com.tech.whale.admin.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminReportListDto {
	
	private int report_id;
	private String user_id;
	private String report_user_id;
	private Integer feed_id;
	private Integer feed_comment_id;
	private Integer post_id;
	private Integer post_comment_id;
	private Integer message_id;
	private int writing_id;
	private String tag_name;
	private String report_why;
	private Date report_date;
	private String report_tag;
	private String report_text;
	private String report_img_url;
	private Integer report_admin_check;
	private Integer same_content_count;
	
	private String reportStatus;
}
