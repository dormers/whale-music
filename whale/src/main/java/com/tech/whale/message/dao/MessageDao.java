package com.tech.whale.message.dao;

import java.util.List;

import com.tech.whale.message.dto.FollowListDto;
import org.apache.ibatis.annotations.Mapper;

import com.tech.whale.message.dto.MessageDto;

@Mapper
public interface MessageDao {

	MessageDto getAllRoom(String now_id, String userId);

	void createMessageRoom(String roomId);

	void addUserMessageRoom(String roomId, String userId);

	String getNextRoomId();
	
	void saveMessage(MessageDto messageDto);
	
    List<MessageDto> getMessagesByRoomId(String roomId);

	List<FollowListDto> getFollowList(String now_id);
}
