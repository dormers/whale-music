package com.tech.whale.admin.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminPFCDto;
import com.tech.whale.admin.util.AdminSearchVO;

@Service
public class AdminUserInfoFeedService implements AdminServiceInter{

	@Autowired
	private AdminIDao adminIDao;
	
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		AdminSearchVO searchVO = (AdminSearchVO) map.get("searchVO");
		String userId = request.getParameter("userId");

		if (searchVO == null) {
		    searchVO = new AdminSearchVO();
		    model.addAttribute("searchVO", searchVO);
		}
		
		int total = adminIDao.selectFeedCnt(userId);
		
		String strPage = request.getParameter("flpage");
		if(strPage == null || strPage.isEmpty()) {
 			strPage="1";
 		}
		
		int page = Integer.parseInt(strPage);
		searchVO.setPage(page);
		searchVO.pageCalculate(total);
		int rowStart = searchVO.getRowStart();
		int rowEnd = searchVO.getRowEnd();
		
		ArrayList<AdminPFCDto> fldto =
				adminIDao.userAccountFeedSelect(rowStart,rowEnd,userId);
		model.addAttribute("AccountUserFeedList", fldto);
		model.addAttribute("fltotRowcnt", total);
		model.addAttribute("flsearchVO", searchVO);
	}

}
