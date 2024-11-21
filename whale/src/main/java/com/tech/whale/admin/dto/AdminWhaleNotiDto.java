package com.tech.whale.admin.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminWhaleNotiDto {
	
	private int notice_id;
	private String user_id;
	private String notice_text;
	private Date notice_date;
	
	
}
