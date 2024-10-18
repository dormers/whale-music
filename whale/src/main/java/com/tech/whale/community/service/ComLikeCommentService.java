package com.tech.whale.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.CommentDto;

@Service
public class ComLikeCommentService {

    @Autowired
    private ComDao comDao;

    public int toggleLike(String postId, String userId) {
        // 사용자가 이미 좋아요를 눌렀는지 확인
        int userLiked = comDao.checkUserLikedPost(postId, userId);
        
        if (userLiked > 0) {
            // 이미 좋아요를 눌렀다면 좋아요 취소
            comDao.deleteLike(postId, userId);
        } else {
            // 좋아요를 누르지 않았다면 좋아요 추가
            comDao.insertLike(postId, userId);
        }

        // 최종적으로 게시글의 최신 좋아요 수를 반환
        return comDao.getLikeCount(postId);
    }
    
    // 코멘트 삽입 메소드
    public void insertComment(String postId, String userId, String commentText) {
        comDao.insertComments(postId, userId, commentText);
    }
    
    public void deleteComments(String postCommentsId) {
    	comDao.deleteComments(postCommentsId);
    }

    // 게시글에 달린 코멘트 리스트 조회
    public List<CommentDto> getCommentsForPost(String postId) {
        return comDao.getComments(postId);
    }
}