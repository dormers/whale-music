package com.tech.whale.admin.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminCommunityDto;
import com.tech.whale.admin.service.AdminServiceInter;
import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.CommentDto;
import com.tech.whale.community.dto.PostDto;
import com.tech.whale.community.service.ComLikeCommentService;

@Service
public class AdminBoardPostContentService implements AdminServiceInter {
	@Autowired
	private AdminIDao adminIDao;
	private final ComDao comDao;
    private final ComLikeCommentService comLikeCommentService;
    @Autowired
    public AdminBoardPostContentService(ComDao comDao, ComLikeCommentService comLikeCommentService) {
        this.comDao = comDao;
        this.comLikeCommentService = comLikeCommentService;
    }
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String postId = request.getParameter("postId");
		PostDto postDetail = adminIDao.getAdminPost(postId);
		AdminCommunityDto comIdName = adminIDao.comIdName(postId);
		
		
		if (postDetail == null) {
            // 게시글이 없을 경우 처리 (예: 에러 페이지로 이동)
            model.addAttribute("errorMessage", "해당 게시글을 찾을 수 없습니다.");
            return;
        }

        // 좋아요 수 설정
        int likeCount = comDao.getLikeCount(postId);
        postDetail.setLikeCount(likeCount);

        // 댓글 수 설정
        int commentsCount = comDao.getCommentsCount(postId);
        postDetail.setCommentsCount(commentsCount);

        // 댓글 목록 가져오기
        List<CommentDto> commentsList = comLikeCommentService.getCommentsForPost(postId);
        postDetail.setComments(commentsList);

        // 모델에 게시글 상세 정보 추가
        model.addAttribute("comIdName", comIdName);
        model.addAttribute("postDetail", postDetail);
		
	}

}
