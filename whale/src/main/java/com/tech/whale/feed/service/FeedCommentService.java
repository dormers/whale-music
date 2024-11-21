package com.tech.whale.feed.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tech.whale.feed.dao.FeedCommentDao;
import com.tech.whale.feed.dao.FeedDao;
import com.tech.whale.feed.dto.FeedCommentDto;
import com.tech.whale.main.models.MainDao;

@Service
public class FeedCommentService {

	@Autowired
	private FeedDao feedDao;
	
	@Autowired
	private FeedCommentDao feedCommentDao;
	
	// [ 메인 알람 기능]
    @Autowired
    private MainDao mainDao;

    public void insertComment(String feedId, String now_id, String comments) {
        feedDao.insertComments(feedId, now_id, comments);
        // [ 메인 알람 기능: 알람의 좋아요 기능이 켜져 있고 자신의 게시물이 아니라면 알람 테이블 추가 ]
        Integer commentNoti = mainDao.selectCommentsNotiFeedId(feedId);
        String feedUserId = mainDao.selectFeedUserId(feedId);
        if (commentNoti == 1 && !feedUserId.equals(now_id)) {
            mainDao.insertFeedCommentsNoti("피드", feedId, now_id, comments);
        }
    }
    
    public void deleteComments(String postCommentsId) {
    	feedDao.deleteComments(postCommentsId);
    }
	
	public List<FeedCommentDto> getCommentsForFeed(String feedId) {
		// TODO Auto-generated method stub
		return feedDao.getComments(feedId);
	}

    public int toggleCommentLike(String commentId, String userId) throws Exception {
        int likeCount = feedCommentDao.isCommentLikedByUser(commentId, userId);
        boolean isLiked = likeCount > 0;
        if (isLiked) {
            // 이미 좋아요를 누른 경우 좋아요 취소
            feedCommentDao.deleteCommentLike(commentId, userId);
        } else {
            // 좋아요 추가
            feedCommentDao.insertCommentLike(commentId, userId);
            // [ 메인 알람 기능: 알람의 좋아요 기능이 켜져 있고 자신의 피드 댓글이 아니라면 알람 테이블 추가 ]
            Integer likeNoti = mainDao.selectCommentsNotiFeedCommentId(commentId);
            String feedCommentUserId = mainDao.selectFeedCommentUserId(commentId);
            if (likeNoti == 1 && !feedCommentUserId.equals(userId)) {
                mainDao.insertFeedCommentLikeNoti(commentId, userId);
            }
        }
        // 새로운 좋아요 수 반환
        return feedCommentDao.getCommentLikeCount(commentId);
    }

    public void addReply(int feedId, String parentCommentId, String userId, String replyText) {
        FeedCommentDto reply = new FeedCommentDto();
        reply.setFeed_id(feedId);
        reply.setParent_comments_id(parentCommentId);
        reply.setUser_id(userId);
        reply.setFeed_comments_text(replyText);
        // 현재 날짜 설정 등 필요한 추가 설정

        feedCommentDao.insertReply(reply);
        // [ 메인 알람 기능: 알람의 좋아요 기능이 켜져 있고 자신의 게시물이 아니라면 알람 테이블 추가 ]
        Integer commentNoti = mainDao.selectCommentsNotiFeedCommentId(parentCommentId);
        String feedUserId = mainDao.selectFeedCommentUserId(parentCommentId);
        if (commentNoti == 1 && !feedUserId.equals(userId)) {
            mainDao.insertFeedCCNoti("피드 댓글", parentCommentId, feedId+"", userId, replyText);
        }
    }
    
    public List<FeedCommentDto> getRepliesForComment(int commentId) {
        return feedCommentDao.getRepliesForComment(commentId);
    }
	
}
