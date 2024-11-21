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
import com.tech.whale.admin.service.AdminServiceInter;
import com.tech.whale.admin.util.AdminSearchVO;
import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.PostDto;

@Service
public class AdminNoticeListService implements AdminServiceInter{
	
	@Autowired
	private AdminIDao adminIDao;
	@Autowired
    private ComDao comDao;
	
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
			}
		}
		String searchKeyword = request.getParameter("sk");
		if(searchKeyword == null || searchKeyword.trim().isEmpty()) {
			searchKeyword = "";
		}

		int total = 0;
		if(user_id.equals("user_id")) {
			total = adminIDao.selectNoticeCnt(searchKeyword,"1");
		}else if(post_title.equals("post_title")) {
			total = adminIDao.selectNoticeCnt(searchKeyword,"2");
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
			list = adminIDao.adminNoticeList(rowStart,rowEnd, searchKeyword,"1");
		}
		else if(post_title.equals("post_title")) {
			list = adminIDao.adminNoticeList(rowStart,rowEnd,searchKeyword,"2");
		}
		
		
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchType", brdTitle);
		model.addAttribute("list", list);
		model.addAttribute("ultotRowcnt", total);
		model.addAttribute("ulsearchVO", searchVO);
		
	}
	
	public void communitySelect(Model model) {
		
		ArrayList<AdminCommunityDto> communityList = adminIDao.communitySelect();
		model.addAttribute("communityList", communityList);
	}
	
	public void registerNotice(PostDto postDto, Model model) throws IOException {
       
		// 1. 게시물 등록
		if(postDto.getCommunity_id()==99999) {
			this.communitySelect(model);
			Map<String, Object> map = model.asMap();
			ArrayList<AdminCommunityDto> communityList =
					(ArrayList<AdminCommunityDto>) map.get("communityList");
			for(AdminCommunityDto var : communityList) {
				postDto.setCommunity_id(var.getCommunity_id());
				int postId = comDao.getNextPostId();
		    	postDto.setPost_id(postId);
		    	comDao.insertPost(postDto);
		    	if (postDto.getTrack_id() != null) {
					int postMusicId = comDao.getNextPostMusicId();
					postDto.setPost_music_id(postMusicId);
					comDao.insertPostMusic(postDto);
				}
			}
		} else {
			int postId = comDao.getNextPostId();
	    	postDto.setPost_id(postId);
	    	comDao.insertPost(postDto);
	    	if (postDto.getTrack_id() != null) {
				int postMusicId = comDao.getNextPostMusicId();
				postDto.setPost_music_id(postMusicId);
				comDao.insertPostMusic(postDto);
			}
		}
    	


    }
	
	public List<Integer> noticeList(int postId){
		List<Integer> notice_list = adminIDao.notice_list(postId);
		
		return notice_list;
	}
	
}
