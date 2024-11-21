package com.tech.whale.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tech.whale.admin.dto.AdminBoardDelLogDto;
import com.tech.whale.admin.dto.AdminCommunityDto;
import com.tech.whale.admin.dto.AdminMainCntDto;
import com.tech.whale.admin.dto.AdminMainRankDto;
import com.tech.whale.admin.dto.AdminMemoDto;
import com.tech.whale.admin.dto.AdminPFCDto;
import com.tech.whale.admin.dto.AdminUserInfoDto;
import com.tech.whale.admin.dto.AdminUserStatusLogDto;
import com.tech.whale.admin.dto.AdminWhaleNotiDto;
import com.tech.whale.community.dto.PostDto;

@Mapper
public interface AdminIDao {
	
	public int selectUserCnt(String sk, String selNum);
	public int selectAdvertiserCnt(String sk, String selNum);
	public int selectOfficialCnt(String sk, String selNum);
	public ArrayList<AdminUserInfoDto> adminUserList(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("sk") String sk,
			@Param("selNum") String selNum,
			@Param("searchOrderBy") String searchOrderBy);
	public AdminUserInfoDto userAccountInfoSelect(String userId);
	
	public ArrayList<AdminPFCDto> userAccountFeedSelect(
			int start, int end, String userId);
	public ArrayList<AdminPFCDto> userAccountPostSelect(
			int start, int end, String userId);
	public ArrayList<AdminPFCDto> userAccountCommentsSelect(
			int start, int end, String userId);
	
	public int selectPostCnt(String userId);
	public int selectFeedCnt(String userId);
	public int selectCommentsCnt(String userId);
	
	public void userNicknameModyfy(String userId, String userNickname);
	public void userImgDelete(String userId, String userImgUrl);
	
	public void userInfoAccessModify(String userId, int userAccess);
	public void accessInfoAdd(
			String userId, int userAccess, String companyName);
	public void userAccessLog(
			String userId, int userAccess, String accessReason, String adminId);
	public void userAccessDrop(String userId, int userAccessNow);
	
	public void userStatusModify(String userId, int userStatus);
	public void userStatusLog(
			String userId, int userStatus, String statusReason, String adminId);
	/////////////////////////////////////////////
	public ArrayList<AdminPFCDto> adminBoardList(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("sk") String sk,
			@Param("selNum") String selNum);
	public int selectBoardCnt(String sk, String selNum);
	
	public ArrayList<AdminPFCDto> adminBoardCommentsList(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("sk") String sk,
			@Param("selNum") String selNum);
	public int selectBoardCommentsCnt(String sk, String selNum);
	
	public void postDelLog(
			@Param("post_id") int post_id,
			@Param("user_id") String user_id,
			@Param("del_reason") String del_reason);
	public void postCommentsDelLog(
			@Param("post_id") int post_id,
			@Param("user_id") String user_id,
			@Param("comments_del_reason") String comments_del_reason);
	public void postDel(int post_id);
	public void postLikeDel(int post_id);
	public void postCommentsLikeDel(int post_id);
	public void postCommentsDel(int post_id);
	
	public void feedDelLog(
			@Param("feed_id") int feed_id,
			@Param("user_id") String user_id,
			@Param("del_reason") String del_reason);
	public void feedCommentsDelLog(
			@Param("feed_id") int feed_id,
			@Param("user_id") String user_id,
			@Param("comments_del_reason") String comments_del_reason);
	public void feedDel(int feed_id);
	public void feedLikeDel(int feed_id);
	public void feedCommentsLikeDel(int feed_id);
	public void feedCommentsDel(int feed_id);
	public void feedCommentsOneDelLog(
			@Param("feed_comments_id") int feed_comments_id,
			@Param("feed_id") int feed_id,
			@Param("user_id") String user_id,
			@Param("comments_del_reason") String comments_del_reason);
	public void feedCommentsLikeOneDel(int feed_comments_id);
	public void feedCommentsOneDel(int feed_comments_id);
	public void postCommentsOneDelLog(
			@Param("post_comments_id") int post_comments_id,
			@Param("post_id") int post_id,
			@Param("user_id") String user_id,
			@Param("comments_del_reason") String comments_del_reason);
	public void postCommentsParentDelLog(
			@Param("post_comments_id") int post_comments_id,
			@Param("post_id") int post_id,
			@Param("user_id") String user_id,
			@Param("comments_del_reason") String comments_del_reason);
	public void feedCommentsParentDelLog(
			@Param("feed_comments_id") int feed_comments_id,
			@Param("feed_id") int feed_id,
			@Param("user_id") String user_id,
			@Param("comments_del_reason") String comments_del_reason);
	public void postCommentsLikeOneDel(int post_comments_id);
	public void postCommentsOneDel(int post_comments_id);
	public String comName(String postId);
	public Integer pfIdFind(
			@Param("type") String type, 
			@Param("commentId") int commentId);
	public int myAdminId(String myId);
	
	public void postCommentsParentDel(int post_comments_id);
	public void postCommentsLikeParentDel(int post_comments_id);
	public void feedCommentsParentDel(int feed_comments_id);
	public void feedCommentsLikeParentDel(int feed_comments_id);
	public void updateUserStatus(String userId);
	public String myImg(String userId);
	public void endActionUpdate(String userId);
	
	public ArrayList<AdminBoardDelLogDto> adminDelLogList(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("sk") String sk,
			@Param("selNum") String selNum);
	public int selectDelLogCnt(String sk, String selNum);
	
	////////////////
	public ArrayList<AdminPFCDto> adminNoticeList(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("sk") String sk,
			@Param("selNum") String selNum);
	public int selectNoticeCnt(String sk, String selNum);
	public ArrayList<AdminCommunityDto> communitySelect();
	public AdminCommunityDto comIdName(String postId);
	public PostDto getAdminPost(String postId);
	
	public ArrayList<AdminWhaleNotiDto> adminWhaleNotiList(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("sk") String sk,
			@Param("selNum") String selNum);
	public int selectWhaleNotiCnt(String sk, String selNum);
	public void whaleNotiRegDo(String user_id, String whale_text);
	//////////////
	public int reportCnt();
	public int reportResultCnt();
	public int writingCnt();
	public ArrayList<AdminWhaleNotiDto> mainNotice();
	public AdminMemoDto adminMemo(String myId);
	public int memoCheck(String myId);
	public void memoCreate(String myId);
	public void memoUpdate(String memoUpdateStr, String myId);
	public int musigToday();
	public int tagToday();
	public List<AdminMainRankDto> rankToday();
	
	public void insertReport(String userId, String adminId);
	public int reportGetSeq();
	public ArrayList<AdminUserStatusLogDto> adminUserStatusLogList(
			@Param("start") int start,
			@Param("end") int end, 
			@Param("sk") String sk,
			@Param("selNum") String selNum);
	public int selectUserStatusLogCnt(String sk, String selNum);
	
	public List<Integer> notice_list(int postId);
	
}
