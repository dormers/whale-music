package com.tech.whale.feed.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tech.whale.feed.dto.FeedCommentDto;
import com.tech.whale.feed.dto.FeedDto;
import com.tech.whale.feed.dto.FeedImgDto;

@Mapper
public interface FeedDao {

	int getNextFeedId();

	void insertFeed(FeedDto feedDto);

	void insertImage(FeedImgDto feedImgDto);

	List<FeedDto> getFeeds(String now_id, int offset, int size);

	List<FeedDto> getFeedsProfile(String userId);

	FeedDto getFeedOne(String feedId);

	int checkUserLikedFeed(String feedId, String now_id);

	void deleteLike(String feedId, String now_id);

	void insertLike(String feedId, String now_id);

	int getLikeCount(String feedId);
	
	

	void insertComments(String feedId, String now_id, String comments);

	void deleteComments(String postCommentsId);

	List<FeedCommentDto> getComments(String feedId);

	void deleteFeed(String feed_id);

	void hideFeed(String feed_id);

	void insertFeedMusic(FeedDto feedDto);

	int getNextFeedMusicId();

	void openFeed(String feed_id);

}
