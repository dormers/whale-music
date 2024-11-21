package com.tech.whale.main.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.tech.whale.main.models.ComNotiDto;
import com.tech.whale.main.models.FollowNotiDto;
import com.tech.whale.main.models.LikeNotiDto;
import com.tech.whale.main.models.MainDao;
import com.tech.whale.main.models.MessageNotiDto;
import com.tech.whale.main.models.WhaleNotiDto;
import com.tech.whale.profile.dao.ProDao;
import com.tech.whale.setting.dao.SettingDao;
import com.tech.whale.setting.dto.PageAccessDto;
import com.tech.whale.setting.dto.StartpageDto;
import com.tech.whale.setting.dto.UserInfoDto;
import com.tech.whale.setting.dto.UserSettingDto;

@Service
public class MainService {
	private MainDao mainDao;
	private SettingDao settingDao;
	private ProDao proDao;
	
	public MainService(MainDao mainDao, SettingDao settingDao, ProDao proDao) {
		this.mainDao = mainDao;
		this.settingDao = settingDao;
		this.proDao = proDao;
	}
	
	// [ 유저 정보 설정 서비스 ]
	public String[] userInfoMainService(HttpSession session) {
		UserInfoDto userInfoDto = settingDao.getProfile((String) session.getAttribute("user_id"));
		return new String[] {userInfoDto.getUser_nickname(),userInfoDto.getUser_image_url()};
	}
	
	// [ 시작 페이지 설정 서비스 ]
	public int[] checkStartPageMain(HttpSession session) {
		StartpageDto startpageDto = settingDao.getStartpageSetting((String) session.getAttribute("user_id"));
		return new int[] {searchStartPageMain(startpageDto,1),searchStartPageMain(startpageDto,2)};
	}
	private int searchStartPageMain(StartpageDto startpageDto, int x) {
		if (startpageDto.getStartpage_music_setting() == x) {return 0;}
		else if (startpageDto.getStartpage_feed_setting() == x) {return 3;}
		else if (startpageDto.getStartpage_community_setting() == x) {return 2;}
		else if (startpageDto.getStartpage_message_setting() == x) {return 1;}
		else {return 4;}
	}
	
	// [ 페이지 접근 설정 서비스 ]
	public PageAccessDto checkPageAccessMain(HttpSession session) {
		PageAccessDto pageAccessDto = settingDao.getPageAccessSetting((String) session.getAttribute("user_id"));
		return pageAccessDto;
	}
	
	// [ 메세지 알림 서비스 ]
	public List<WhaleNotiDto> getWhaleNotiMainService(HttpSession session) {
		List<WhaleNotiDto> whaleNotis = mainDao.getWhaleNoti((String) session.getAttribute("user_id"));
		return whaleNotis;
	}
	
	// [ 메세지 알림 서비스 ]
	public List<MessageNotiDto> getMessageNotiMainService(HttpSession session) {
		List<MessageNotiDto> messageNotis = mainDao.getMessageNoti((String) session.getAttribute("user_id"));
		return messageNotis;
	}
	
	// [ 좋아요 알림 서비스 ]
	public List<LikeNotiDto> getLikeNotiMainService(HttpSession session) {
		List<LikeNotiDto> likeNotis = mainDao.getLikeNoti((String) session.getAttribute("user_id"));
		return likeNotis;
	}
	
	// [ 댓글 알림 서비스 ]
	public List<ComNotiDto> getCommentsNotiMainService(HttpSession session) {
		List<ComNotiDto> commentsNotis = mainDao.getCommentsNoti((String) session.getAttribute("user_id"));
		return commentsNotis;
	}
	// [ 팔로우 알림 서비스 ]
	public List<FollowNotiDto> getFollowNotiMainService(HttpSession session) {
		List<FollowNotiDto> followNotis = mainDao.getFollowNoti((String) session.getAttribute("user_id"));
		return followNotis;
	}
	
	// [ 좋아요 알림 읽음 처리 ]
	public void updateWhaleNotiMainService(String whaleNotiId) {
		mainDao.updateWhaleNoti(whaleNotiId);
	}
	
	// [ 좋아요 알림 읽음 처리 ]
	public void updateLikeNotiMainService(String likeNotiId) {
		mainDao.updateLikeNoti(likeNotiId);
	}
	
	// [ 댓글 알림 읽음 처리 ]
	public void updateCommentsNotiMainService(String commentsNotiId) {
		mainDao.updateCommentsNoti(commentsNotiId);
	}
	
	// [ 팔로우 알림 읽음 처리 ]
	public void updateFollowNotiMainService(String followNotiId) {
		mainDao.updateFollowNoti(followNotiId);
	}
	
	// [ 웨일 알림 삭제 처리 ]
	public void deleteWhaleNotiMainService(String whaleNotiId) {
		mainDao.deleteWhaleNoti(whaleNotiId);
	}
	
	// [ 좋아요 알림 삭제 처리 ]
	public void deleteLikeNotiMainService(String likeNotiId) {
		mainDao.deleteLikeNoti(likeNotiId);
	}
	
	// [ 댓글 알림 삭제 처리 ]
	public void deleteCommentsNotiMainService(String commentsNotiId) {
		mainDao.deleteCommentsNoti(commentsNotiId);
	}
	
	// [ 팔로우 알림 삭제 처리 ]
	public void deleteFollowNotiMainService(String userId, String targetId) {
		mainDao.deleteFollowNoti(userId, targetId);
	}
	
	// [ 팔로우 알림 삭제 처리 ]
	public void deleteFollowNotiIdMainService(String followNotiId) {
		mainDao.deleteFollowNotiId(followNotiId);
	}
	
	// [ 비공개 팔로우 알림 수락 처리 ]
	public void privateFollowNotiMainService(String userId, String targetId) {
		proDao.doFollowing(userId, targetId);
		mainDao.deleteFollowNoti(userId, targetId);
		mainDao.insertFollowNoti(2, targetId, userId);
		// 상대방의 팔로우 목록에 내가 있는지 확인
		Integer followNoti = mainDao.selectFollowed(targetId, userId);
		if (followNoti == 0) {
			mainDao.insertFollowNoti(3, userId, targetId);
        }
	}
	
	// [ 맞팔로우 알림 수락 처리 ]
	public void followBackNotiMainService(String userId, String targetId) {
		Integer privacy = mainDao.selectAccountPrivacy(targetId);
		if (privacy == 0) {
			proDao.doFollowing(targetId, userId);
			mainDao.deleteFollowNoti(userId, targetId);
			mainDao.insertFollowNoti(0, targetId, userId);
		} else {
			mainDao.deleteFollowNoti(userId, targetId);
			mainDao.insertFollowNoti(1, targetId, userId);
		}
	}
	
	// [ 노드용 다크 모드 정보 출력 ]
	public int getDarkModeMainService(String userId) {
		UserSettingDto userSettingDto = settingDao.getDarkmode(userId);
		return userSettingDto.getDarkmode_setting_onoff();
	}
}
