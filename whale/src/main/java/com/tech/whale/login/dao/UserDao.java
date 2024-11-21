package com.tech.whale.login.dao;

import com.tech.whale.login.dto.UserDto;
import org.apache.catalina.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface UserDao {
    public void insertUserInfo(UserDto user);
    public void insertUserNotification(String user_id);
    public void insertPageAccessSetting(String user_id);
    public void insertStartPageSetting(String user_id);
    public void insertUserSetting(String user_id);
    public void insertFollow(String user_id);
    public Integer selectFollowId(String user_id);
    public void insertProfile(String user_id, Integer followId);
    public Integer checkAccessId(String user_id);
    public String getPasswordByUsername(String user_id);
    public void saveUser(String user_id, String password, String email);
    Integer existsByUsername(String user_id);
    Integer existsByNickname(String user_nickname);
    Integer existsByEmail(String user_email);
    public void saveResetToken(String user_id, String token);
    public Integer isValidToken(String token);
    public void updatePasswordByToken(String hashedPassword, String token);
    public String getUserIdByEmail(String email);
    List<UserDto> getUsersByEmail(String email);
    public void deleteUserById(@Param("user_id") String userId);
    public Integer getUserStatus(String userId);
    public Date getUserEndDate(String userId);
    List<String> selectFollowingUsers(@Param("user_id") String userId);
    public void doUnfollowing(@Param("user_id") String userId, @Param("unfollow_user_id") String unfollowUserId);
    public void deleteFeedsByUserId(@Param("user_id") String userId);

    // 데이터 무결성 제약 회피용 임시삭제 메서드들
    void changeUserInfoByUserId(@Param("user_id") String userId, @Param("new_user_id") String newUserId);

    // USER_NOTIFICATION_ONOFF 테이블 관련 메서드
    void deleteUserNotiOnoffByUserId(@Param("user_id") String userId);
    void insertUserNotiOnoffWithNewUserId(@Param("user_id") String newUserId);

    // PAGE_ACCESS_SETTING 테이블 관련 메서드
    void deleteUserPageAccessSettingByUserId(@Param("user_id") String userId);
    void insertUserPageAccessSettingWithNewUserId(@Param("user_id") String newUserId);

    // STARTPAGE_SETTING 테이블 관련 메서드
    void deleteUserStartpageSettingByUserId(@Param("user_id") String userId);
    void insertUserStartpageSettingWithNewUserId(@Param("user_id") String newUserId);

    // USER_SETTING 테이블 관련 메서드
    void deleteUserSettingByUserId(@Param("user_id") String userId);
    void insertUserSettingByUserId(@Param("user_id") String newUserId);

    // PROFILE 테이블 관련 메서드
    void deleteUserProfileByUserId(@Param("user_id") String userId);
    void insertUserProfileWithNewUserId(@Param("user_id") String newUserId);

    //  FOLLOW 테이블 관련 메서드
    void deleteUserFollowByUserId(@Param("user_id") String userId);
    void insertUserFollowWithNewUserId(@Param("user_id") String newUserId);

    // MASSAGE 테이블 관련 메서드
    void deleteUserIdInMessageByUserId(@Param("user_id") String userId);
    void insertUserIdInMessageWithNewUserId(@Param("user_id") String newUserId);
    void changeUserIdInMessage(@Param("userId") String userId, @Param("newUserId") String newUserId);

    // MASSAGE_ROOM 테이블 관련 메서드
    void deleteUserIdInMessageRoomUserByUserId(@Param("user_id") String userId);
    void insertUserIdInMessageRoomUserWithNewUserId(@Param("user_id") String newUserId);
    void changeUserIdInMessageRoomUser(@Param("userId") String userId, @Param("newUserId") String newUserId);

    // 어드민 계정 팔로우 관련 메서드
    void followAdmin(String followerId, String followeeId);
    void followUser(String followerId, String followeeId);

}
