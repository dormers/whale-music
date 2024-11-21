package com.tech.whale.admin.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;

@Service
public class AdminUserImgDeleteService implements AdminServiceInter{

	@Autowired
	private AdminIDao adminIDao;
	
	
	@Override
	@Transactional
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		
		String userId = request.getParameter("userId");
		String userImgUrl = request.getParameter("userImgUrl");
		
		adminIDao.userImgDelete(userId,userImgUrl);

	}

}
