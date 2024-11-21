package com.tech.whale.feed.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tech.whale.feed.dto.FeedCommentDto;

@Mapper
public interface FeedCommentDao {

	int isCommentLikedByUser(String commentId, String userId);

	void deleteCommentLike(String commentId, String userId);

	void insertCommentLike(String commentId, String userId);

	int getCommentLikeCount(String commentId);

	void insertReply(FeedCommentDto reply);
	
	List<FeedCommentDto> getRepliesForComment(@Param("commentId") int commentId);

}
