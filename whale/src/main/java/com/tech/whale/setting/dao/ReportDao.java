package com.tech.whale.setting.dao;

import org.apache.ibatis.annotations.Mapper;

import com.tech.whale.setting.dto.ReportDto;

@Mapper
public interface ReportDao {

	public void reportPost(String report_type_id, String now_id, String report_why, String report_tag, String reportText, String userId);

	public void reportFeed(String report_type_id, String now_id, String report_why, String report_tag, String reportText, String reportImg, String userId);

	public ReportDto getReportPost(String report_type_id);

	public ReportDto getReportFeed(String report_type_id);

	public ReportDto getReportFeedComments(String report_type_id);

	public void reportFeedComments(String report_type_id, String now_id, String report_why, String report_tag,
			String reportText, String userId);

	public String getPostUser(String post_id);

	public String getFeedUser(String feed_id);

	public String getFeedCommentsUser(String feed_comments_id);

	public String getPostCommentsUser(String post_comments_id);

	public String getMessageUser(String message_id);

	public ReportDto getReportPostComments(String report_type_id);

	public ReportDto getReportMessage(String report_type_id);

	public void reportPostComments(String report_type_id, String now_id, String report_why, String report_tag,
			String reportText, String userId);

	public void reportMessage(String report_type_id, String now_id, String report_why, String report_tag,
			String reportText, String userId);

}
