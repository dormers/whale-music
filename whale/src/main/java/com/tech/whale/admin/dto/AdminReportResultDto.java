package com.tech.whale.admin.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminReportResultDto extends AdminReportListDto{
	
	private int report_log_id;
	private String target_type;
	private int target_id;
	private int admin_id;
	private Date report_result_date;
	private String report_result_action;
	private String report_result_reason ;
	
}