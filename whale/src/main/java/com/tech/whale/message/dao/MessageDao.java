package com.tech.whale.message.dao;

import java.util.List;
import java.util.Map;

import com.tech.whale.message.dto.AllChatListDto;
import com.tech.whale.message.dto.FollowListDto;
import com.tech.whale.message.dto.LinkMessageDto;
import com.tech.whale.message.dto.ReadChatDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.tech.whale.message.dto.MessageDto;

@Mapper
@Repository
public interface MessageDao {

	MessageDto getAllRoom(String now_id, String userId);

	void createMessageRoom(String roomId);

	void addUserMessageRoom(String roomId, String userId);

	String getNextRoomId();

	void saveMessage(MessageDto messageDto);

	List<MessageDto> getMessagesByRoomId(String roomId, int userTypeInt);

	List<FollowListDto> getFollowList(String now_id);

	List<AllChatListDto> getAllChatList(String now_id);

	List<ReadChatDto> getReadChatList(String now_id);

	List<Integer> getUnreadMessageIds(String roomId, String userId);
	
	void updateMessageReadStatus(String roomId, String userId);

	String getOtherUserInRoom2(String roomId, String userId);

	String getUserImage(String userId);

	String findPostUser(String post_id);

	String findFeedUser(String feed_id);

	List<LinkMessageDto> getLinkUser(String user_id);
	
	MessageDto getMessageById(int messageId);
	
	void deleteMessage(int messageId);

	int getNextMessageId();

	String getUserType(String now_id, String currentMessageRoomId);

    void updateUserType(
            @Param("message_room_id") String messageRoomId, 
            @Param("userTypeInt") int userTypeInt
        );

	void addUserMessageRoom(String roomId, String userId, String string);

	String getUserNickname(String userId);

	void readMessage(String message_room_id, String otherId);

	Map<String, String> getTrackInfo(String messageContent);
}

