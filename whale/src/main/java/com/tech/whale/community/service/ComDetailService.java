package com.tech.whale.community.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.CommentDto;
import com.tech.whale.community.dto.PostDto;

public class ComDetailService implements ComServiceInter {

    private ComDao comDao;
    private ComLikeCommentService comLikeCommentService;

    public ComDetailService(ComDao comDao, ComLikeCommentService comLikeCommentService) {
        this.comDao = comDao;
        this.comLikeCommentService = comLikeCommentService;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        String postId = (String) map.get("postId"); // 모델에서 postId 가져오기

        // 조회수 증가
        comDao.upCnt(postId);

        // 게시글 상세 정보 가져오기
        PostDto postDetail = comDao.getPost(postId);

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
        model.addAttribute("postDetail", postDetail);
    }
}
