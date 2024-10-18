package com.tech.whale.community.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.PostDto;

public class ComDetailService implements ComServiceInter {
	
	private ComDao comDao;
	
	public ComDetailService(ComDao comDao) {
		this.comDao = comDao;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String postId = request.getParameter("p");
		
		comDao.upCnt(postId);
		
        PostDto postDetail = (PostDto) model.getAttribute("postDetail");

        if (postDetail == null) {
            // postDetail이 없으면 새로 조회
            postDetail = comDao.getPost(postId);
        }
		
		int likeCount = comDao.getLikeCount(postId);
		postDetail.setLikeCount(likeCount);
		
		model.addAttribute("postDetail", postDetail);
		
	}

}
