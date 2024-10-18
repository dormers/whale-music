package com.tech.whale.community.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.PostDto;
import com.tech.whale.community.vo.SearchVO;

public class ComPostService implements ComServiceInter {
	private ComDao comDao;
	
	public ComPostService(ComDao comDao) {
		this.comDao = comDao;
	}
	
	@Override
	public void execute(Model model) {
	    System.out.println(">>> CommunityPostService");
	    
	    Map<String, Object> map = model.asMap();
	    HttpServletRequest request = (HttpServletRequest) map.get("request");
	    SearchVO searchVO = (SearchVO) map.get("searchVO");
	    
	    ModelMap modelMap = (ModelMap) model;
	    
	    Integer communityId = (Integer) modelMap.get("communityId");
	    Integer tagId = (Integer) modelMap.get("tagId");
	    
	    int comId = communityId.intValue();
	    System.out.println("Community ID in model: " + model.getAttribute("communityId"));
	    
	    List<PostDto> tList = comDao.chooseTag();
	    model.addAttribute("tlist", tList);
	    
	    if (tagId == null) {
	        tagId = -1; // -1을 기본값으로 설정해 MyBatis 쿼리에서 처리할 수 있도록 함
	    }
	    
	    String title = "";
	    String content = "";

	    String[] brdTitle = request.getParameterValues("searchType");
	    if (brdTitle != null) {
	        for (String val : brdTitle) {
	            if (val.equals("title")) {
	                model.addAttribute("title", "true");
	                title = "title";
	            }
	            if (val.equals("content")) {
	                model.addAttribute("content", "true");
	                content = "content";
	            }
	        }
	    }

	    String searchKeyword = request.getParameter("sk");
	    System.out.println(searchKeyword);
	    if (searchKeyword == null) {
	        searchKeyword = "";
	    }
	    
	    model.addAttribute("searchKeyword", searchKeyword);

	    int total = 0;
	    if (title.equals("title") && content.equals("")) {
	        total = comDao.selectBoardCount(searchKeyword, 1, comId, tagId);
	    } else if (title.equals("") && content.equals("content")) {
	        total = comDao.selectBoardCount(searchKeyword, 2, comId, tagId);
	    } else if (title.equals("title") && content.equals("content")) {
	        total = comDao.selectBoardCount(searchKeyword, 3, comId, tagId);
	    } else if (title.equals("") && content.equals("")) {
	        total = comDao.selectBoardCount(searchKeyword, 4, comId, tagId);
	    }

	    String strPage = request.getParameter("page");
	    if (strPage == null) {
	        strPage = "1";
	    }
	    int page = Integer.parseInt(strPage);
	    searchVO.setPage(page);
	    
	    searchVO.pageCalculate(total);

	    int rowStart = searchVO.getRowStart();
	    int rowEnd = searchVO.getRowEnd();
	    
	    System.out.println(title);
	    System.out.println(content);
	    
	    if (title.equals("title") && content.equals("")) {
	        model.addAttribute("list", comDao.getPostAll(rowStart, rowEnd, searchKeyword, 1, comId, tagId)); 
	    } else if (title.equals("") && content.equals("content")) {
	        model.addAttribute("list", comDao.getPostAll(rowStart, rowEnd, searchKeyword, 2, comId, tagId)); 
	    } else if (title.equals("title") && content.equals("content")) {
	        model.addAttribute("list", comDao.getPostAll(rowStart, rowEnd, searchKeyword, 3, comId, tagId)); 
	    } else if (title.equals("") && content.equals("")) {
	        model.addAttribute("list", comDao.getPostAll(rowStart, rowEnd, searchKeyword, 4, comId, tagId)); 
	    }
	    
	    model.addAttribute("totRowcnt", total);
	    model.addAttribute("searchVO", searchVO);
	}

}
