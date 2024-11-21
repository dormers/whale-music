package com.tech.whale.admin.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminUserInfoDto;

@Service
public class AdminAccountUserInfoService implements AdminServiceInter{

	@Autowired
	private AdminIDao adminIDao;
	
	
	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		String userId = request.getParameter("userId");
		if(userId == null||userId.trim().isEmpty()) {
			userId = (String) map.get("userId");
		}
		AdminUserInfoDto dto = adminIDao.userAccountInfoSelect(userId);
		
		// 추후에 access_id를 언어로 바꾸는 class파일 만들어야함?
		if(dto.getUser_access_id() == 0) {
			dto.setUser_access_str("일반유저");
		}else if(dto.getUser_access_id() == 1) {
			dto.setUser_access_str("관리자");
		}else if(dto.getUser_access_id() == 2) {
			dto.setUser_access_str("광고주");
		}else if(dto.getUser_access_id() == 3) {
			dto.setUser_access_str("오피셜");
		}else {
			dto.setUser_access_str("오류");
		}
		
		if(dto.getUser_status() == 0) {
			dto.setUser_status_str("활동");
		}else if(dto.getUser_status() == 1) {
			dto.setUser_status_str("정지");
		}
		
		model.addAttribute("AccountUserInfo", dto);
		
	}
	
	public void excuteArray(Model model) {
		
		// Model에서 DTO 리스트 가져오기
		List<AdminUserInfoDto> list = (List<AdminUserInfoDto>) model.getAttribute("list");

		// 각 DTO 객체의 상태 값을 설정
		if (list != null) {
		    for (AdminUserInfoDto dto : list) {
		        if (dto.getUser_status() == 0) {
		            dto.setUser_status_str("활동");
		        } else if (dto.getUser_status() == 1) {
		            dto.setUser_status_str("정지");
		        } else if (dto.getUser_status() == 2) {
		            dto.setUser_status_str("탈퇴");
		        }
		    }
		}

		model.addAttribute("list", list);

	}

}
