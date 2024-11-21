package com.tech.whale.admin.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminUserStatusLogDto {
	private int user_status_log_id;
	private String user_id;
	private int user_status;
	private String user_status_reason;
	private Date user_status_date;
	private String status_admin_id;
}
