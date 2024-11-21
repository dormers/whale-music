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
public class AdminUserInfoPostService implements AdminServiceInter{

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
		
		int total = adminIDao.selectPostCnt(userId);
		
		String strPage = request.getParameter("plpage");
		if(strPage == null || strPage.isEmpty()) {
 			strPage="1";
 		}
		
		int page = Integer.parseInt(strPage);
		searchVO.setPage(page);
		searchVO.pageCalculate(total);
		int rowStart = searchVO.getRowStart();
		int rowEnd = searchVO.getRowEnd();
		
		ArrayList<AdminPFCDto> pldto =
				adminIDao.userAccountPostSelect(rowStart,rowEnd,userId);
		model.addAttribute("AccountUserPostList", pldto);
		model.addAttribute("pltotRowcnt", total);
		model.addAttribute("plsearchVO", searchVO);
	}

}
