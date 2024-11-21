package com.tech.whale.admin.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminAccessDto {
	private String USER_ID;
	
	private int ACCESS_ID;
	private String ACCESS_NAME;
	private String ACCESS_COMMENT;
	
	private int ACCESS_LOG_ID;
	private int OFFICIAL_ID;
	private int ADVERTISER_ID;
	private String ADMIN_ID;
	private String ACCESS_REASON;
	private Date ACCESS_LOG_DATE;
	
	private String ADVERTISER_NAME;
	private String OFFICIAL_NAME;
}
