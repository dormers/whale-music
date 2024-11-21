package com.tech.whale.admin.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminAccessDto;
import com.tech.whale.admin.dto.AdminUserInfoDto;
import com.tech.whale.admin.service.AdminServiceInter;

@Service
public class AdminBoardFeedDelete implements AdminServiceInter{

	@Autowired
	private AdminIDao adminIDao;
	
	
	@Override
	@Transactional
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		
		int feed_id = Integer.parseInt(request.getParameter("feedId"));
		String user_id = (String)model.getAttribute("user_id");
		String feed_del_reason = "글작성 규칙 위반";
		String comments_del_reason = "부모글 삭제";
		
		adminIDao.feedDelLog(feed_id,user_id,feed_del_reason);
		adminIDao.feedCommentsDelLog(feed_id,user_id,comments_del_reason);
		adminIDao.feedLikeDel(feed_id);
		adminIDao.feedCommentsLikeDel(feed_id);
		adminIDao.feedCommentsDel(feed_id);
		adminIDao.feedDel(feed_id);
		
	}
	
	@Transactional
	public void commentsDelete(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		
		int feed_id = Integer.parseInt(request.getParameter("feedId"));
		int feed_comments_id = Integer.parseInt(request.getParameter("commentId"));
		String user_id = (String)model.getAttribute("user_id");
		String comments_del_reason = "글작성 규칙 위반";
		String comments_del_parent_reason = "부모글 삭제";
		adminIDao.feedCommentsOneDelLog(feed_comments_id,feed_id,user_id,comments_del_reason);
		adminIDao.feedCommentsDelLog(feed_comments_id,user_id,comments_del_parent_reason);
		adminIDao.feedCommentsLikeParentDel(feed_comments_id);
		adminIDao.feedCommentsLikeOneDel(feed_comments_id);
		adminIDao.feedCommentsParentDel(feed_comments_id);
		adminIDao.feedCommentsOneDel(feed_comments_id);
		
	}

}
