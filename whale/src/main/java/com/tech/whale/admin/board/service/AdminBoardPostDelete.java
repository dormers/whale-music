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
import com.tech.whale.community.dao.ComDao;

@Service
public class AdminBoardPostDelete implements AdminServiceInter{

	@Autowired
	private AdminIDao adminIDao;
	@Autowired
	private ComDao comDao;
	
	
	@Override
	@Transactional
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		
		int post_id = Integer.parseInt(request.getParameter("postId"));
		String post_num = (String)request.getParameter("post_num");
		int community_id = Integer.parseInt(request.getParameter("community_id"));
		String user_id = (String)model.getAttribute("user_id");
		String post_del_reason = "게시판 규칙 위반";
		String comments_del_reason = "부모글 삭제";
		
		adminIDao.postDelLog(post_id,user_id,post_del_reason);
		adminIDao.postCommentsDelLog(post_id,user_id,comments_del_reason);
		adminIDao.postLikeDel(post_id);
		adminIDao.postCommentsLikeDel(post_id);
		adminIDao.postCommentsDel(post_id);
		adminIDao.postDel(post_id);
		comDao.updatePostNumsAfterDeletion(community_id,post_num);
	}
	
	@Transactional
	public void commentsDelete(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		
		int post_id = Integer.parseInt(request.getParameter("postId"));
		int post_comments_id = Integer.parseInt(request.getParameter("commentId"));
		String user_id = (String)model.getAttribute("user_id");
		String comments_del_reason = "글작성 규칙 위반";
		String comments_del_parent_reason = "부모글 삭제";
		System.out.println("서비스 댓글번호 : " +post_comments_id);
		adminIDao.postCommentsOneDelLog(post_comments_id,post_id,user_id,comments_del_reason);
		adminIDao.postCommentsParentDelLog(post_comments_id,post_id,user_id,comments_del_parent_reason);
		adminIDao.postCommentsLikeOneDel(post_comments_id);
		adminIDao.postCommentsLikeParentDel(post_comments_id);
		adminIDao.postCommentsOneDel(post_comments_id);
		adminIDao.postCommentsParentDel(post_comments_id);
	}
	
	@Transactional
	public void noticeDel(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = 
				(HttpServletRequest) map.get("request");
		
		int post_id = Integer.parseInt(request.getParameter("postId"));
		
		
		adminIDao.postLikeDel(post_id);
		adminIDao.postCommentsLikeDel(post_id);
		adminIDao.postCommentsDel(post_id);
		adminIDao.postDel(post_id);
	}
	
}
