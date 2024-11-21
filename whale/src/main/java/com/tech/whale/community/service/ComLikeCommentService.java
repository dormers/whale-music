package com.tech.whale.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.CommentDto;
import com.tech.whale.main.models.MainDao;

@Service
public class ComLikeCommentService {

    @Autowired
    private ComDao comDao;
    
    // [ 메인 알람 기능]
    @Autowired
    private MainDao mainDao;

    public int toggleLike(String postId, String userId) {
        // 사용자가 이미 좋아요를 눌렀는지 확인
        int userLiked = comDao.checkUserLikedPost(postId, userId);
        
        if (userLiked > 0) {
            // 이미 좋아요를 눌렀다면 좋아요 취소
            comDao.deleteLike(postId, userId);
        } else {
            // 좋아요를 누르지 않았다면 좋아요 추가
            comDao.insertLike(postId, userId);
            // [ 메인 알람 기능: 알람의 좋아요 기능이 켜져 있고 자신의 게시물이 아니라면 알람 테이블 추가 ]
            Integer likeNoti = mainDao.selectLikeNotiPostId(postId);
            String postUserId = mainDao.selectPostUserId(postId);
            if (likeNoti == 1 && !postUserId.equals(userId)) {
                mainDao.insertPostLikeNoti(postId, userId);
            }
        }

        // 최종적으로 게시글의 최신 좋아요 수를 반환
        return comDao.getLikeCount(postId);
    }
    
    public int toggleCommentLike(String commentId, String userId) {
        int userLiked = comDao.checkUserLikedComment(commentId, userId);

        if (userLiked > 0) {
            // 이미 좋아요를 눌렀다면 좋아요 취소
            comDao.deleteCommentLike(commentId, userId);
        } else {
            // 좋아요 추가
            comDao.insertCommentLike(commentId, userId);
            // [ 메인 알람 기능: 알람의 좋아요 기능이 켜져 있고 자신의 게시물 댓글이 아니라면 알람 테이블 추가 ]
            Integer likeNoti = mainDao.selectCommentsNotiPostCommentId(commentId);
            String postCommentUserId = mainDao.selectPostCommentUserId(commentId);
            if (likeNoti == 1 && !postCommentUserId.equals(userId)) {
                mainDao.insertPostCommentLikeNoti(commentId, userId);
            }
        }

        // 최종적으로 댓글의 최신 좋아요 수를 반환
        return comDao.getCommentLikeCount(commentId);
    }
    
    // 코멘트 삽입 메소드
	/*
	 * public void insertComment(String postId, String userId, String commentText) {
	 * comDao.insertComments(postId, userId, commentText); // [ 메인 알람 기능: 알람의 좋아요
	 * 기능이 켜져 있고 자신의 게시물이 아니라면 알람 테이블 추가 ] Integer commentNoti =
	 * mainDao.selectCommentsNotiPostId(postId); String postUserId =
	 * mainDao.selectPostUserId(postId); if (commentNoti == 1 &&
	 * !postUserId.equals(userId)) { mainDao.insertPostCommentsNoti(postId, userId,
	 * commentText); } }
	 */
    
    public void insertComment(String postId, String userId, String commentText, String parentCommentId) {
        comDao.insertComments(postId, userId, commentText, parentCommentId);
        // 알림 기능 등 추가 구현 가능
        // [ 메인 알람 기능: 알람의 댓글 기능이 켜져 있고 자신의 게시물이 아니라면 알람 테이블 추가 ]
        if (parentCommentId == null) {
        	Integer commentNoti = mainDao.selectCommentsNotiPostId(postId);
            String postUserId = mainDao.selectPostUserId(postId);
            if (commentNoti == 1 && !postUserId.equals(userId)) {
            	mainDao.insertPostCommentsNoti("게시글", postId, userId, commentText);
            }
    	} else {
    		Integer commentNoti = mainDao.selectCommentsNotiPostCommentId(parentCommentId);
            String postUserId = mainDao.selectPostCommentUserId(parentCommentId);
            if (commentNoti == 1 && !postUserId.equals(userId)) {
            	mainDao.insertPostCCNoti("게시글 댓글", parentCommentId, postId, userId, commentText);
            }
    	}
    }
    
    
    public void deleteComments(String postCommentsId) {
    	comDao.deleteComments(postCommentsId);
    }

    // 게시글에 달린 코멘트 리스트 조회
    public List<CommentDto> getCommentsForPost(String postId) {
        List<CommentDto> comments = comDao.getComments(postId);

        for (CommentDto comment : comments) {
            // 각 댓글의 답글 목록을 가져옵니다.
            List<CommentDto> replies = comDao.getReplies(comment.getPost_comments_id());
            comment.setReplies(replies);
        }

        return comments;
    }
}