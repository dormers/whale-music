package com.tech.whale.community.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tech.whale.community.dto.CommentDto;
import com.tech.whale.community.dto.CommunityDto;
import com.tech.whale.community.dto.PostDto;
import com.tech.whale.community.dto.PostImgDto;

@Mapper
public interface ComDao {
	public void deleteComments(String postCommentsId);
	public void insertComments(String postId, String userId, String comments);
	public List<CommentDto> getComments(String postId);
	public List<CommunityDto> getComAll();
	public List<PostDto> getPostAll(int start, int end, String sk, int selNum, int comId, int tagId);
	public List<PostDto> chooseTag();
	public void regPost(String commid, String user, String text, String title, int postnum, String tagid);
	public PostDto getPostNum(String commid);
	public PostDto getPost(String post_id);
	public void cntUpdate(PostDto p);
	public int selectBoardCount(String sk, int selNum, int comId, int tagId);
	public String getCommunityName(int communityId);
	public void upCnt(String post_id);
	public void deletePost(String post_id);
	
	public String getPostNumById(String post_id);
	public void updatePostNumsAfterDeletion(int communityId, String postNum);
	
    public int checkUserLikedPost(String postId, String userId);

    // 좋아요 추가
    public void insertLike(String postId, String userId);

    // 좋아요 취소
    public void deleteLike(String postId, String userId);

    // 게시글의 총 좋아요 수 가져오기
    public int getLikeCount(String postId);
    
    public void insertPost(PostDto postDto);
    
    public void insertImage(PostImgDto postImgDto);
	public int getNextPostId();
	public int deletePostImage(int imageId);
	public void updatePost(PostDto post);
}
