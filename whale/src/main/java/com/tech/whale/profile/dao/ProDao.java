package com.tech.whale.profile.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tech.whale.main.models.FollowNotiDto;
import com.tech.whale.profile.dto.ProfileDto;

@Mapper
public interface ProDao {

	public ProfileDto getUserProfile(String user_id);
	public List<ProfileDto> getFollowerList(String user_id);
	public List<ProfileDto> getFollowingList(String user_id);
	
	public Integer followerCount(String user_id);
	public Integer followingCount(String user_id);
	public Integer feedCount(String userId);
	
	public FollowNotiDto getNotiId(String user_id, String now_id);
	public void doUnfollowing(String user_id, String now_id);
	public void doFollowing(String user_id, String now_id);
}
