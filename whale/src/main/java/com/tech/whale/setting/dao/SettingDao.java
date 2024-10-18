package com.tech.whale.setting.dao;

import org.apache.ibatis.annotations.Mapper;

import com.tech.whale.setting.dto.BlockDto;
import com.tech.whale.setting.dto.StartpageDto;
import com.tech.whale.setting.dto.UserInfoDto;
import com.tech.whale.setting.dto.UserNotificationDto;
import com.tech.whale.setting.dto.UserSettingDto;

@Mapper
public interface SettingDao {

	public UserInfoDto getProfile(String session_user_id);
	public void updateProfile(String nickname, String  password, String email, String newProfileImage, String session_user_id);
	public void updateAccountPrivacy(String session_user_id, int accountPrivacy);
	public void updateNotificationSettings(String session_user_id, int allNotificationOff, int likeNotificationOnoff, int commentNotificationOnoff, int messageNotificationOnoff);
	public UserNotificationDto getNotificationSettingsByUserId(String session_user_id);
	public void updateLikeNotification(String session_user_id, int likeNotificationOnOff);
	public void updateCommentNotification(String session_user_id, int commentNotificationOnOff);
	public void updateMessageNotification(String session_user_id, int messageNotificationOnOff);
	public UserSettingDto getAccountPrivacyByUserId(String session_user_id);
	public BlockDto getBlockList(String session_user_id);
	public void unblockUser(String session_user_id, String block_userId);
	public UserSettingDto getDarkmode(String session_user_id);
	public void updateDarkmode(String session_user_id, int darkmodeOn);
	public StartpageDto getStartpageSetting(String session_user_id);
	public void updateStartpageSetting(String userId, String left, String right);
}
