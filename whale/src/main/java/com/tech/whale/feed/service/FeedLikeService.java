package com.tech.whale.feed.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tech.whale.feed.dao.FeedDao;
import com.tech.whale.main.models.MainDao;

@Service
public class FeedLikeService {

	@Autowired
	private FeedDao feedDao;
	
	// [ 메인 알람 기능]
    @Autowired
    private MainDao mainDao;
	
	public int toggleLike(String feedId, String now_id) {
		// TODO Auto-generated method stub
		
		int userLiked = feedDao.checkUserLikedFeed(feedId, now_id);
		
        if (userLiked > 0) {
            // 이미 좋아요를 눌렀다면 좋아요 취소
            feedDao.deleteLike(feedId, now_id);
        } else {
            // 좋아요를 누르지 않았다면 좋아요 추가
            feedDao.insertLike(feedId, now_id);
            // [ 메인 알람 기능: 알람의 좋아요 기능이 켜져 있고 자신의 게시물이 아니라면 알람 테이블 추가 ]
            Integer likeNoti = mainDao.selectLikeNotiFeedId(feedId);
            String feedUserId = mainDao.selectFeedUserId(feedId);
            if (likeNoti == 1 && !feedUserId.equals(now_id)) {
                mainDao.insertFeedLikeNoti(feedId, now_id);
            }
        }

        // 최종적으로 게시글의 최신 좋아요 수를 반환
        return feedDao.getLikeCount(feedId);
	}

}
