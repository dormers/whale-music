package com.tech.whale.admin.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.util.SearchVO;

public class AdminAccountUserService implements AdminServiceInter{
	
	private AdminIDao adminIDao;
	
	public AdminAccountUserService(AdminIDao daminIDao) {
		this.adminIDao = adminIDao;
	}
	
	@Override
	public void execute(Model model) {
		System.out.println("AdminAccountUserService");
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		SearchVO searchVO = (SearchVO) map.get("searchVO");
		
//		String user_id = "";
//		String user_password_id = "";
//		String user_nickname_id = "";
//		String user_email_id = "";
//		String user_image_url_id = "";
//		int user_access_id_id = 0;
//		String user_spotify_id_id = "";
		String user_id = "";
		String user_access_id_id = "";
		
		
		
		
		String[] brdTitle = request.getParameterValues("searchType");
		if(brdTitle != null) {
			for (int i = 0; i < brdTitle.length; i++) {
				System.out.println("brdTitle: " + brdTitle);
			}
		}
		if(brdTitle != null) {
			for (String val : brdTitle) {
				if(val.equals("user_id")) {
					model.addAttribute("user_id", "true");
					user_id="user_id";
				}
				if(val.equals("user_access_id_id")) {
					model.addAttribute("user_access_id_id", "true");
					user_access_id_id="user_access_id_id";
				}
			}
		}
		String searchKeyword = request.getParameter("page");
		if(searchKeyword == null) {
			searchKeyword = "";
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}
