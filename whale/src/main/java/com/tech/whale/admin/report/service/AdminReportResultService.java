package com.tech.whale.admin.report.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dao.AdminReportIDao;
import com.tech.whale.admin.dto.AdminReportOverlapDto;
import com.tech.whale.admin.service.AdminServiceInter;
import com.tech.whale.main.models.MainDao;

@Service
public class AdminReportResultService implements AdminServiceInter{

	@Autowired
	private AdminReportIDao adminReportIDao;
	@Autowired
	private AdminIDao adminIDao;
	
	// [ 메인 알람 기능]
    @Autowired
    private MainDao mainDao;
	
	@Override
	@Transactional
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		
		int report_id = Integer.parseInt(request.getParameter("report_id"));
		String writingType = request.getParameter("writingType");
		int writingId = Integer.parseInt(request.getParameter("writingId"));
		String userStatus = request.getParameter("userStatus");
		String writingStatus = request.getParameter("writingStatus");
		String myId = (String)model.getAttribute("myId");
		String statusReason = request.getParameter("statusReason");
		String userId = request.getParameter("userId");
		
		if(writingStatus.equals("0")) {
			writingStatus="-";
		}else if(writingStatus.equals("1")) {
			writingStatus="작성글 삭제";
		}
		List<AdminReportOverlapDto> total_report = new ArrayList<>();
		total_report = adminReportIDao.totalReport(writingType,report_id);
		
		String userStatusStr = null;
		for(AdminReportOverlapDto var : total_report) {
			if(userStatus.equals("0")) {
				userStatusStr="-";
				adminReportIDao.reportResult(
						var.getReport_id(),writingType,writingId,myId,writingStatus,statusReason,userId,userStatusStr,0);
			}else if(userStatus.equals("1")) {
				userStatusStr="1일 정지";
				adminReportIDao.reportResult(
						var.getReport_id(),writingType,writingId,myId,writingStatus,statusReason,userId,userStatusStr,1);
			}else if(userStatus.equals("2")) {
				userStatusStr="영구 정지";
				adminReportIDao.reportResult(
						var.getReport_id(),writingType,writingId,myId,writingStatus,statusReason,userId,userStatusStr,2);
			}
			// [ 메인 알람 기능: 해당 유저의 알람 테이블 추가 ]
			mainDao.insertWhaleNoti(0, var.getUser_id());
			adminReportIDao.reportAdminCh(var.getReport_id());
		}
	}
	
	@Transactional
	public void userBan(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		
		int userStatus = Integer.parseInt(request.getParameter("userStatus"));
		String myId = (String)model.getAttribute("myId");
		String statusReason = request.getParameter("statusReason");
		String userId = request.getParameter("userId");
		
		
		if(userStatus >= 1) {
			userStatus = 1;
			adminIDao.userStatusModify(userId, userStatus);
			adminIDao.userStatusLog(userId, userStatus,statusReason,myId);
		}
	}
	
	@Transactional
	public void writingDel(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		String writingStatus = request.getParameter("writingStatus");
		
		if(writingStatus.equals("1")){
			String writingType = request.getParameter("writingType");
			int writingId = Integer.parseInt(request.getParameter("writingId"));
			String myId = (String)model.getAttribute("myId");
			String statusReason = request.getParameter("statusReason");
			String comments_del_reason = "부모글 삭제";

			if(writingType.equals("feed")) {
				adminIDao.feedDelLog(writingId,myId,statusReason);
				adminIDao.feedCommentsDelLog(writingId,myId,comments_del_reason);
				adminIDao.feedLikeDel(writingId);
				adminIDao.feedCommentsLikeDel(writingId);
				adminIDao.feedCommentsDel(writingId);
				adminIDao.feedDel(writingId);
			} else if(writingType.equals("feed_comments")) {
				Integer feed_id = adminIDao.pfIdFind(writingType,writingId);
				if(feed_id != null) {
					adminIDao.feedCommentsOneDelLog(writingId,feed_id,myId,statusReason);
					adminIDao.feedCommentsParentDelLog(writingId,feed_id,myId,comments_del_reason);
					adminIDao.feedCommentsLikeOneDel(writingId);
					adminIDao.feedCommentsLikeParentDel(writingId);
					adminIDao.feedCommentsParentDel(writingId);
					adminIDao.feedCommentsOneDel(writingId);
				}
			} else if(writingType.equals("post")) {
				adminIDao.postDelLog(writingId,myId,statusReason);
				adminIDao.postCommentsDelLog(writingId,myId,comments_del_reason);
				adminIDao.postLikeDel(writingId);
				adminIDao.postCommentsLikeDel(writingId);
				adminIDao.postCommentsDel(writingId);
				adminIDao.postDel(writingId);
			} else if(writingType.equals("post_comments")) {
				Integer post_id = adminIDao.pfIdFind(writingType,writingId);
				if(post_id != null) {
					adminIDao.postCommentsOneDelLog(writingId,post_id,myId,statusReason);
					adminIDao.postCommentsParentDelLog(writingId,post_id,myId,comments_del_reason);
					adminIDao.postCommentsLikeOneDel(writingId);
					adminIDao.postCommentsLikeParentDel(writingId);
					adminIDao.postCommentsParentDel(writingId);
					adminIDao.postCommentsOneDel(writingId);
				}
			}
		}
	}
	

}
