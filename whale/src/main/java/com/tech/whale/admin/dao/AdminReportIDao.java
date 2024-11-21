package com.tech.whale.admin.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tech.whale.admin.dto.AdminReportListDto;
import com.tech.whale.admin.dto.AdminReportOverlapDto;
import com.tech.whale.admin.dto.AdminReportResultDto;

@Mapper
public interface AdminReportIDao {
	
	public ArrayList<AdminReportListDto> adminReportList(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("sk") String sk,
			@Param("selNum") String selNum);
	public int selectReportCnt(String sk, String selNum);
	
	public AdminReportResultDto reportContent(String report_id);
	public String selectUserId(int writingId, int writingNum);
	public void reportResult(
			@Param("report_id") int report_id, 
			@Param("target_type") String target_type, 
			@Param("target_id") int target_id, 
			@Param("myId") String myId, 
			@Param("action") String action,
			@Param("actionReason") String actionReason,
			@Param("userId") String userId,
			@Param("userStatus") String userStatus,
			@Param("endDate") int endDate
			);
	public void reportAdminCh(int report_id);
	public ArrayList<AdminReportOverlapDto> totalReport(
			@Param("writingType") String writingType,
			@Param("report_id") int report_id);
}
