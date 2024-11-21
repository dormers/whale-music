package com.tech.whale.profile.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tech.whale.feed.dao.FeedDao;
import com.tech.whale.feed.dto.FeedDto;
import com.tech.whale.main.models.FollowNotiDto;
import com.tech.whale.main.models.MainDao;
import com.tech.whale.profile.dao.ProDao;
import com.tech.whale.profile.dto.ProfileDto;

@Controller
public class ProfileController {

	
	@Autowired
	private ProDao proDao;
	
	@Autowired
	private FeedDao feedDao;
	
	// [ 메인 알람 기능]
    @Autowired
    private MainDao mainDao;
	
	@RequestMapping("/profile")
	public String profile(HttpSession session) {
		return "redirect:/profileHome?u="+(String) session.getAttribute("user_id");
	}
	
	@RequestMapping("/profileHome")
	public String profileHome(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		
		ProfileDto profile = proDao.getUserProfile(userId);
		Integer followerCount = proDao.followerCount(userId);
		int frcount = (followerCount != null) ? followerCount : 0;
		Integer followingCount = proDao.followingCount(userId);
		int fncount = (followingCount != null) ? followingCount : 0;
		Integer feedCount = proDao.feedCount(userId);
		int fdcount = (feedCount != null) ? feedCount : 0;
		String now_id = (String) session.getAttribute("user_id");
		String adminId = "WHALE";
		List<ProfileDto> followerList = proDao.getFollowerList(userId);
		FollowNotiDto profile2 = proDao.getNotiId(userId, now_id);
		List<FeedDto> feedList = feedDao.getFeedsProfile(userId);
		
		model.addAttribute("WHALE", adminId);
		model.addAttribute("now_id", now_id);
		model.addAttribute("followerList", followerList);
		model.addAttribute("frCount", frcount);
		model.addAttribute("fnCount", fncount);
		model.addAttribute("fdCount", fdcount);
		model.addAttribute("profile", profile);
		model.addAttribute("profile2", profile2);
		model.addAttribute("userId", userId);
		model.addAttribute("feedList", feedList);
		return "profile/profileHome";
	}
	
	@RequestMapping("/followers")
	public String followers(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		
		String now_id = (String) session.getAttribute("user_id");
		List<ProfileDto> followerList = proDao.getFollowerList(userId);
		model.addAttribute("now_id", now_id);
		model.addAttribute("followerList", followerList);
		model.addAttribute("userId", userId);
		return "profile/followers";
	}
	
	@RequestMapping("/following")
	public String following(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		
		String now_id = (String) session.getAttribute("user_id");
		List<ProfileDto> followingList = proDao.getFollowingList(userId);
		
		model.addAttribute("now_id", now_id);
		model.addAttribute("followingList", followingList);
		model.addAttribute("userId", userId);
		return "profile/following";
	}
	
	@RequestMapping("/DoUnfollowing")
	public String doUnfollowing(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		String now_id = (String) session.getAttribute("user_id");
		System.out.println("now_id : " + now_id);
		System.out.println("userId : " + userId);
		proDao.doUnfollowing(userId, now_id);
		// [ 메인 알람 기능: 기존 테이블에 포함되지 않는다면 팔로우 알람 테이블 삭제 ]
		Integer followNoti = mainDao.selectFollowNotiId(userId, now_id);
		if (followNoti != null) {
			mainDao.deleteFollowNoti(userId, now_id);
        }
		
		return "redirect:/profileHome?u=" + userId;
	}
	
	@RequestMapping("/DoFollowing")
	public String doFollowing(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		String now_id = (String) session.getAttribute("user_id");
		proDao.doFollowing(userId, now_id);
		// [ 메인 알람 기능: 기존 테이블에 포함되지 않는다면 팔로우 알람 테이블 추가 ]
		Integer followNoti = mainDao.selectFollowNotiId(userId, now_id);
		if (followNoti == null) {
			mainDao.insertFollowNoti(0, userId, now_id);
        }
		
		return "redirect:/profileHome?u=" + userId;
	}

	@RequestMapping("/DelFollowing")
	public String delFollowing(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		String now_id = (String) session.getAttribute("user_id");
		System.out.println("now_id : " + now_id);
		System.out.println("userId : " + userId);
		proDao.doUnfollowing(userId, now_id);
		// [ 메인 알람 기능: 기존 테이블에 포함되지 않는다면 팔로우 알람 테이블 삭제 ]
		Integer followNoti = mainDao.selectFollowNotiId(userId, now_id);
		if (followNoti != null) {
			mainDao.deleteFollowNoti(userId, now_id);
        }
		
		return "redirect:/following?u=" + now_id;
	}
	
	@RequestMapping("/DelFollower")
	public String delFollower(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		String now_id = (String) session.getAttribute("user_id");
		System.out.println("now_id : " + now_id);
		System.out.println("userId : " + userId);
		proDao.doUnfollowing(now_id, userId);
		// [ 메인 알람 기능: 기존 테이블에 포함되지 않는다면 팔로우 알람 테이블 삭제 ]
		Integer followNoti = mainDao.selectFollowNotiId(now_id, userId);
		if (followNoti != null) {
			mainDao.deleteFollowNoti(now_id, userId);
        }
		
		return "redirect:/followers?u=" + now_id;
	}
	
	@RequestMapping("/DosecretFollowing")
	public String dosecretFollowing(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		String now_id = (String) session.getAttribute("user_id");
		//비공개계정 팔로우 요청
		// [ 메인 알람 기능: 기존 테이블에 포함되지 않는다면 팔로우 알람 테이블 추가 ]
		Integer followNoti = mainDao.selectFollowed(userId, now_id);
		if (followNoti == 0) {
			mainDao.insertFollowNoti(1, userId, now_id);
        }
		
		return "redirect:/profileHome?u=" +userId;
	}
	
	@RequestMapping("/CancelFollowingPlease")
	public String cancelFollowingPlease(HttpServletRequest request, HttpSession session, @RequestParam("u") String userId, Model model) {
		String now_id = (String) session.getAttribute("user_id");
		Integer followNoti = mainDao.selectFollowNotiId(userId, now_id);
		if (followNoti != null) {
			mainDao.deleteFollowNoti(userId, now_id);
        }
		
		return "redirect:/profileHome?u=" +userId;
	}
}
