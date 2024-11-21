package com.tech.whale.admin.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dao.AdminReportIDao;
import com.tech.whale.admin.dto.AdminAccessDto;
import com.tech.whale.admin.dto.AdminUserInfoDto;
import com.tech.whale.main.models.MainDao;

@Service
public class AdminAccountUserModifyService implements AdminServiceInter{

	@Autowired
	private AdminIDao adminIDao;
	@Autowired
	private AdminReportIDao adminReportIDao;
	
	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		String userId = request.getParameter("userId");
		
		AdminUserInfoDto dto = adminIDao.userAccountInfoSelect(userId);
		
		model.addAttribute("AccountUserInfo", dto);
		
	}
	
	@Transactional
	public void modifyAccess(Model model,
			HttpSession session) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		String userId = request.getParameter("userId");
		int userAccess = Integer.parseInt(request.getParameter("userAccess"));
		int userAccessNow = Integer.parseInt(request.getParameter("userAccessNow"));
		
		if(userAccessNow == 0) {
			if(userAccess!= 0) {
				adminIDao.userInfoAccessModify(userId, userAccess);
			}
		}else {
			adminIDao.userInfoAccessModify(userId, userAccess);
		}
		
	}
	
	
	@Transactional
	public void modifyStatus(Model model,
			HttpSession session) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		String userId = request.getParameter("userId");
		String statusReason = request.getParameter("statusReason");
		int userStatus = Integer.parseInt(request.getParameter("userStatus"));
		String adminId = (String) session.getAttribute("user_id");
		
		if(userStatus == 0) {
			adminIDao.endActionUpdate(userId);
			adminIDao.userStatusModify(userId, userStatus);
			adminIDao.userStatusLog(userId, userStatus,statusReason,adminId);
		} else if(userStatus == 1) {
			adminIDao.insertReport(userId,adminId);
			int report_seq = adminIDao.reportGetSeq();
			String writingStatus="작성글 삭제";
			adminReportIDao.reportResult(
					report_seq,"feed",0,adminId,writingStatus,statusReason,userId,"영구 정지",2);
			adminIDao.userStatusModify(userId, userStatus);
			adminIDao.userStatusLog(userId, userStatus,statusReason,adminId);
			
			adminReportIDao.reportAdminCh(report_seq);
		}
		
	}

}
