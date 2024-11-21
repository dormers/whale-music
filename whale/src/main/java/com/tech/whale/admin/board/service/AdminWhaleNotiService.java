package com.tech.whale.admin.board.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminCommunityDto;
import com.tech.whale.admin.dto.AdminPFCDto;
import com.tech.whale.admin.dto.AdminWhaleNotiDto;
import com.tech.whale.admin.service.AdminServiceInter;
import com.tech.whale.admin.util.AdminSearchVO;
import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.PostDto;
import com.tech.whale.main.models.MainDao;

@Service
public class AdminWhaleNotiService implements AdminServiceInter{
	
	@Autowired
	private AdminIDao adminIDao;
	@Autowired
    private ComDao comDao;
	
	// [ 메인 알람 기능]
    @Autowired
    private MainDao mainDao;
	
	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		AdminSearchVO searchVO = (AdminSearchVO) map.get("searchVO");
		
		if (searchVO == null) {
		    searchVO = new AdminSearchVO();
		    model.addAttribute("searchVO", searchVO);
		}
		
		String user_id = "";
	    String whale_text = "";
	 	
		String brdTitle = request.getParameter("searchType");
		
		if (brdTitle == null || brdTitle.trim().isEmpty()) {
	        user_id = "user_id";
	        model.addAttribute("user_id", "true");
	    } else if(brdTitle != null) {
			if(brdTitle.equals("user_id")) {
				model.addAttribute("user_id", "true");
				user_id="user_id";
			}else if(brdTitle.equals("whale_text")) {
				model.addAttribute("whale_text", "true");
				whale_text="whale_text";
			}
		}
		String searchKeyword = request.getParameter("sk");
		if(searchKeyword == null || searchKeyword.trim().isEmpty()) {
			searchKeyword = "";
		}

		int total = 0;
		if(user_id.equals("user_id")) {
			total = adminIDao.selectWhaleNotiCnt(searchKeyword,"1");
		}else if(whale_text.equals("whale_text")) {
			total = adminIDao.selectWhaleNotiCnt(searchKeyword,"2");
		}
		
		String strPage = request.getParameter("page");
		
 		if(strPage == null || strPage.isEmpty()) {
 			strPage="1";
 		}
		
		int page = Integer.parseInt(strPage);
		searchVO.setPage(page);
		
		searchVO.pageCalculate(total);
		
		int rowStart = searchVO.getRowStart();
		int rowEnd = searchVO.getRowEnd();
		
		ArrayList<AdminWhaleNotiDto> list = null;
		if(user_id.equals("user_id")) {
			list = adminIDao.adminWhaleNotiList(rowStart,rowEnd, searchKeyword,"1");
		}
		else if(whale_text.equals("whale_text")) {
			list = adminIDao.adminWhaleNotiList(rowStart,rowEnd,searchKeyword,"2");
		}
		
		
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchType", brdTitle);
		model.addAttribute("list", list);
		model.addAttribute("ultotRowcnt", total);
		model.addAttribute("ulsearchVO", searchVO);
		
	}
	
	public void whaleNotiRegDo(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		
		String user_id = (String)model.getAttribute("myId");
		String whale_text = request.getParameter("whale_text");
		
		adminIDao.whaleNotiRegDo(user_id,whale_text);
		
		// [ 메인 알람 기능: 모든 유저의 알람 테이블 추가 ]
		List<String> allUser = mainDao.selectAllUserId();
		
		for (String userId : allUser) {
			mainDao.insertWhaleNotiText(1, userId, whale_text);
		}
	}
	
	
}
