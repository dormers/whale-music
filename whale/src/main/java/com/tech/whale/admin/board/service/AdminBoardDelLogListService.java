package com.tech.whale.admin.board.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminBoardDelLogDto;
import com.tech.whale.admin.service.AdminServiceInter;
import com.tech.whale.admin.util.AdminSearchVO;

@Service
public class AdminBoardDelLogListService implements AdminServiceInter{
	
	@Autowired
	private AdminIDao adminIDao;
	
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
		
		String admin_id = "";
	    String writing_id = "";
	 	
		String brdTitle = request.getParameter("searchType");
		
		if (brdTitle == null || brdTitle.trim().isEmpty()) {
			admin_id = "admin_id";
	        model.addAttribute("admin_id", "true");
	    } else if(brdTitle != null) {
			if(brdTitle.equals("admin_id")) {
				model.addAttribute("admin_id", "true");
				admin_id="admin_id";
			}else if(brdTitle.equals("writing_id")) {
				model.addAttribute("writing_id", "true");
				writing_id="writing_id";
			}
		}
		String searchKeyword = request.getParameter("sk");
		if(searchKeyword == null || searchKeyword.trim().isEmpty()) {
			searchKeyword = "";
		}

		int total = 0;
		if(admin_id.equals("admin_id")) {
			total = adminIDao.selectDelLogCnt(searchKeyword,"1");
		}else if(writing_id.equals("writing_id")) {
			total = adminIDao.selectDelLogCnt(searchKeyword,"2");
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
		
		ArrayList<AdminBoardDelLogDto> list = null;
		if(admin_id.equals("admin_id")) {
			list = adminIDao.adminDelLogList(rowStart,rowEnd, searchKeyword,"1");
		}
		else if(writing_id.equals("writing_id")) {
			list = adminIDao.adminDelLogList(rowStart,rowEnd,searchKeyword,"2");
		}
		
		
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchType", brdTitle);
		model.addAttribute("list", list);
		model.addAttribute("ultotRowcnt", total);
		model.addAttribute("ulsearchVO", searchVO);
		
	}
	
	
}
