package com.tech.whale.admin.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminBoardDelLogDto {
	private Integer feed_del_log_id;
	private Integer post_del_log_id;
	private String del_reason;
	private Date del_date;
	private String admin_id;
	private Integer writing_id;
	private Integer comments_id;
}
