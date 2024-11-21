package com.tech.whale.admin.board.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminPFCDto;
import com.tech.whale.admin.service.AdminServiceInter;
import com.tech.whale.admin.util.AdminSearchVO;

@Service
public class AdminBoardListService implements AdminServiceInter{
	
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
		
		String user_id = "";
	    String post_title = "";
	    String all_text = "";
	    String idPostFeed = "";
	 	
		String brdTitle = request.getParameter("searchType");
		
		if (brdTitle == null || brdTitle.trim().isEmpty()) {
	        user_id = "user_id";
	        model.addAttribute("user_id", "true");
	    } else if(brdTitle != null) {
			if(brdTitle.equals("user_id")) {
				model.addAttribute("user_id", "true");
				user_id="user_id";
			}else if(brdTitle.equals("post_title")) {
				model.addAttribute("post_title", "true");
				post_title="post_title";
			}else if(brdTitle.equals("all_text")) {
				model.addAttribute("all_text", "true");
				all_text="all_text";
			}else if(brdTitle.equals("idPostFeed")) {
				model.addAttribute("idPostFeed", "true");
				idPostFeed="idPostFeed";
			}
		}
		String searchKeyword = request.getParameter("sk");
		if(searchKeyword == null || searchKeyword.trim().isEmpty()) {
			searchKeyword = "";
		}

		int total = 0;
		if(user_id.equals("user_id")) {
			total = adminIDao.selectBoardCnt(searchKeyword,"1");
		}else if(post_title.equals("post_title")) {
			total = adminIDao.selectBoardCnt(searchKeyword,"2");
		}else if(all_text.equals("all_text")) {
			total = adminIDao.selectBoardCnt(searchKeyword,"3");
		}else if(idPostFeed.equals("idPostFeed")) {
			total = adminIDao.selectBoardCnt(searchKeyword,"4");
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
		
		ArrayList<AdminPFCDto> list = null;
		if(user_id.equals("user_id")) {
			list = adminIDao.adminBoardList(rowStart,rowEnd, searchKeyword,"1");
		}
		else if(post_title.equals("post_title")) {
			list = adminIDao.adminBoardList(rowStart,rowEnd,searchKeyword,"2");
		}else if(all_text.equals("all_text")) {
			list = adminIDao.adminBoardList(rowStart,rowEnd,searchKeyword,"3");
		}else if(idPostFeed.equals("idPostFeed")) {
			list = adminIDao.adminBoardList(rowStart,rowEnd,searchKeyword,"4");
		}
		
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchType", brdTitle);
		model.addAttribute("list", list);
		model.addAttribute("ultotRowcnt", total);
		model.addAttribute("ulsearchVO", searchVO);
		
	}
	
	public void comments(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request =
				(HttpServletRequest) map.get("request");
		AdminSearchVO searchVO = (AdminSearchVO) map.get("searchVO");
		
		if (searchVO == null) {
			searchVO = new AdminSearchVO();
			model.addAttribute("searchVO", searchVO);
		}
		
		String user_id = "";
		String all_text = "";
		
		String brdTitle = request.getParameter("searchType");
		
		if (brdTitle == null || brdTitle.trim().isEmpty()) {
			user_id = "user_id";
			model.addAttribute("user_id", "true");
		} else if(brdTitle != null) {
			if(brdTitle.equals("user_id")) {
				model.addAttribute("user_id", "true");
				user_id="user_id";
			}else if(brdTitle.equals("all_text")) {
				model.addAttribute("all_text", "true");
				all_text="all_text";
			}
		}
		String searchKeyword = request.getParameter("sk");
		if(searchKeyword == null || searchKeyword.trim().isEmpty()) {
			searchKeyword = "";
		}
		
		int total = 0;
		if(user_id.equals("user_id")) {
			total = adminIDao.selectBoardCommentsCnt(searchKeyword,"1");
		}else if(all_text.equals("all_text")) {
			total = adminIDao.selectBoardCommentsCnt(searchKeyword,"2");
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
		
		ArrayList<AdminPFCDto> list = null;
		if(user_id.equals("user_id")) {
			list = adminIDao.adminBoardCommentsList(rowStart,rowEnd, searchKeyword,"1");
		}
		else if(all_text.equals("all_text")) {
			list = adminIDao.adminBoardCommentsList(rowStart,rowEnd,searchKeyword,"2");
		}
		
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchType", brdTitle);
		model.addAttribute("list", list);
		model.addAttribute("ultotRowcnt", total);
		model.addAttribute("ulsearchVO", searchVO);
		
	}
	
	
}
