package com.tech.whale.main.models;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainDao {
	public Integer selectLikeNotiPostId(String postId);
	public Integer selectLikeNotiFeedId(String feedId);
	public Integer selectCommentsNotiPostId(String postId);
	public Integer selectCommentsNotiFeedId(String feedId);
	public Integer selectCommentsNotiPostCommentId(String commentId);
	public Integer selectCommentsNotiFeedCommentId(String commentId);
	public String selectPostUserId(String postId);
	public String selectFeedUserId(String feedId);
	public String selectPostCommentUserId(String commentId);
	public String selectFeedCommentUserId(String commentId);
	public Integer selectFollowNotiId(String userId, String targetId);
	public Integer selectAccountPrivacy(String userId);
	public Integer selectFollowed(String userId, String targetId);
	public String selectReportId(int reportId);
	public List<String> selectAllUserId();
	public List<WhaleNotiDto> getWhaleNoti(String userId);
	public List<MessageNotiDto> getMessageNoti(String userId);
	public List<LikeNotiDto> getLikeNoti(String userId);
	public List<ComNotiDto> getCommentsNoti(String userId);
	public List<FollowNotiDto> getFollowNoti(String userId);
	public void insertPostLikeNoti(String postId, String userId);
	public void insertFeedLikeNoti(String feedId, String userId);
	public void insertPostCommentLikeNoti(String commentId, String userId);
	public void insertFeedCommentLikeNoti(String commentId, String userId);
	public void insertPostCommentsNoti(String commentType, String postId, String userId, String commentText);
	public void insertFeedCommentsNoti(String commentType, String feedId, String userId, String commentText);
	public void insertPostCCNoti(String commentType, String parentCommentId, String postId, String userId, String commentText);
	public void insertFeedCCNoti(String commentType, String parentCommentId, String feedId, String userId, String commentText);
	public void insertFollowNoti(int followNotiType, String userId, String targetId);
	public void insertWhaleNoti(int whaleNotiType, String userId);
	public void insertWhaleNotiText(int whaleNotiType, String userId, String whaleNotiText);
	public void updateLikeNoti(String like_noti_id);
	public void updateCommentsNoti(String comments_noti_id);
	public void updateFollowNoti(String followNotiId);
	public void updateWhaleNoti(String whaleNotiId);
	public void deleteLikeNoti(String like_noti_id);
	public void deleteCommentsNoti(String comments_noti_id);
	public void deleteFollowNoti(String userId, String targetId);
	public void deleteFollowNotiId(String followNotiId);
	public void deleteFollowNotiUserId(String userId);
	public void deleteFollowNotiTargetId(String targetId);
	public void deleteFollowNotiSetting(String userId);
	public void deleteWhaleNoti(String whaleNotiId);
}
