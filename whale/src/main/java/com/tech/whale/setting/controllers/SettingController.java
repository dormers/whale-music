package com.tech.whale.setting.controllers;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tech.whale.setting.dao.SettingDao;
import com.tech.whale.setting.dto.BlockDto;
import com.tech.whale.setting.dto.StartpageDto;
import com.tech.whale.setting.dto.UserInfoDto;
import com.tech.whale.setting.dto.UserNotificationDto;
import com.tech.whale.setting.dto.UserSettingDto;

@Controller
public class SettingController {
	
	UserInfoDto userinfoDto;
	StartpageDto startpageDto;
	UserSettingDto userSettingDto;
	UserNotificationDto userNotificationDto;
	BlockDto blockDto;
	
    // 매 페이지 요청마다 세션에 user_id 값을 저장하는 메서드
    private void ensureUserIdInSession(HttpSession session) {
        if (session.getAttribute("user_id") == null) {
            // 세션에 user_id가 없을 경우 설정. 부모 창에 메세지를 보내 부모 창을 로그인 화면으로 리다이렉트 하는 방식 등.
//        	session.setAttribute("user_id", "김민지");
        }
    }

    @RequestMapping("/settingHome")
    public String settingHome(HttpServletRequest request, HttpSession session, Model model) {
        System.out.println("settingHome");

        // 세션에 user_id 저장
        ensureUserIdInSession(session);

        return "setting/settingHome";
    }

    @Autowired
    private SettingDao settingDao;

    @RequestMapping("/profileEdit")
    public String profileEdit(HttpServletRequest request, HttpSession session, Model model) {
        System.out.println("profileEdit() ctr");
        
        // 세션에서 user_id 가져오기
        String session_user_id = (String) session.getAttribute("user_id");
        System.out.println(session_user_id);

        userinfoDto = settingDao.getProfile(session_user_id);
        
        model.addAttribute("profile", userinfoDto);
        System.out.println(userinfoDto.getUser_image_url()); // debug

        return "setting/profileEdit";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@RequestParam("user_nickname") String nickname, 
                                @RequestParam("user_password") String password, 
                                @RequestParam("user_email") String email, 
                                HttpSession session) {
    	
    	String session_user_id = (String) session.getAttribute("user_id");
    	
    	if(session.getAttribute("user_profile_image") == null) { // session에 이미지가 저장 안 되어 있으면 
    		session.setAttribute("user_profile_image", userinfoDto.getUser_image_url());
    		System.out.println("session에 이미지 저장 안 되어 있어서 새로 저장: " + userinfoDto.getUser_image_url()); // debug
    	}
    	
    	// 세션에 저장된 새로운 프로필 이미지 가져오기
    	System.out.println("update image name: " + session.getAttribute("user_profile_image")); // debug
        String newProfileImage = (String) session.getAttribute("user_profile_image");

        // DB에 새로운 프로필 정보 저장
        settingDao.updateProfile(nickname, password, email, newProfileImage, session_user_id);
        

        return "redirect:/profileEdit";
    }

    @PostMapping("/uploadProfileImage")
    @ResponseBody
    public Map<String, String> uploadProfileImage(MultipartHttpServletRequest mtfRequest, HttpSession session) {
        Map<String, String> response = new HashMap<>();
        
        String session_user_id = (String) session.getAttribute("user_id");

        String workPath = System.getProperty("user.dir");
        System.out.println(workPath);
        String root = workPath + "/src/main/resources/static/images/setting";
        MultipartFile mf = mtfRequest.getFile("file");

        if (mf != null && !mf.isEmpty()) {
            String originalFileName = mf.getOriginalFilename();
            long currentTime = System.currentTimeMillis();
            String newFileName = currentTime + "_" + originalFileName;

            String savePath = root + "/" + newFileName;

            try {
                File saveFile = new File(savePath);
                mf.transferTo(saveFile);

                // 세션에 이미지 파일명 저장
                session.setAttribute("user_profile_image", newFileName);
                System.out.println(session.getAttribute("user_profile_image")); // debug
                response.put("fileName", newFileName);
                response.put("status", "success");

            } catch (Exception e) {
                e.printStackTrace();
                response.put("status", "error");
            }
        } else {
            response.put("status", "no_file");
        }

        return response;
    }

    @RequestMapping("/representiveSong")
    public String representiveSong(HttpSession session, Model model) {
        System.out.println("representiceSong() ctr");
        
        return "setting/representiveSong";
    }

    @RequestMapping("/account")
    public String account(HttpSession session, Model model) {
        System.out.println("account() ctr");

        return "setting/account";
    }

    @RequestMapping("/connectAccount")
    public String connectAccount(HttpSession session, Model model) {
        System.out.println("connectAccount() ctr");

        return "setting/connectAccount";
    }

    @RequestMapping("/accountPrivacy")
    public String accountPrivacy(HttpSession session, Model model) {
        System.out.println("accountPrivacy() ctr");
        
        String session_user_id = (String) session.getAttribute("user_id");
    	
//      비공개 계정 설정 값 가져오기  
        userSettingDto = settingDao.getAccountPrivacyByUserId(session_user_id);
        System.out.println("accountPrivacy value : " + userSettingDto.getAccount_privacy());
        
//      JSP로 데이터 전달
        model.addAttribute("accountPrivacyOn", userSettingDto.getAccount_privacy());
        
        return "setting/accountPrivacy";
    }
    
//  슬라이드 버튼에 의해서 on이면 0(비공개 계정 설정), off면 1(공개 계정 설정)
    @PostMapping("/updatePrivacy")
    @ResponseBody
    public String updatePrivacy(@RequestParam("account_privacy") int accountPrivacy, HttpSession session) {
    	System.out.println("updatePrivacy() ctr");
    	
    	String session_user_id = (String) session.getAttribute("user_id");
    	
//    	DB 업데이트
    	settingDao.updateAccountPrivacy(session_user_id, accountPrivacy);
    	
    	return "success";
    }
    
    @RequestMapping("/hiddenFeed")
    public String hiddenFeed(HttpSession session, Model model) {
        System.out.println("hiddenFeed() ctr");

        return "setting/hiddenFeed";
    }

    @RequestMapping("/activity")
    public String activity(HttpSession session, Model model) {
        System.out.println("activity() ctr");

        return "setting/activity";
    }

    @RequestMapping("/likeList")
    public String likeList(HttpSession session, Model model) {
        System.out.println("likeList() ctr");

        return "setting/likeList";
    }

    @RequestMapping("/commentList")
    public String commentList(HttpSession session, Model model) {
        System.out.println("commentList() ctr");

        return "setting/commentList";
    }

    @RequestMapping("/notification")
    public String notification(HttpSession session, Model model) {
        System.out.println("notification() ctr");
        
        String session_user_id = (String) session.getAttribute("user_id");
        
//      알림 설정 값 가져오기 + Dto에 저장
        userNotificationDto = settingDao.getNotificationSettingsByUserId(session_user_id);
        
//      debug
        System.out.println("1: " + userNotificationDto.getAll_notification_off());
        System.out.println("2: " + userNotificationDto.getLike_notification_onoff());
        System.out.println("3: " + userNotificationDto.getComment_notification_onoff());
        System.out.println("4: " + userNotificationDto.getMessage_notification_onoff());
        
//      JSP로 데이터 전달
        model.addAttribute("allNotificationOff", userNotificationDto.getAll_notification_off());
        model.addAttribute("likeNotificationOn", userNotificationDto.getLike_notification_onoff());
        model.addAttribute("commentNotificationOn", userNotificationDto.getComment_notification_onoff());
        model.addAttribute("messageNotificationOn", userNotificationDto.getMessage_notification_onoff());

        return "setting/notification";
    }
    
    @PostMapping("/updateNotifications")
    @ResponseBody
    public String updateNotifications(
            @RequestParam("all_notification_off") int allNotificationOff, 
            @RequestParam("like_notification_onoff") int likeNotificationOnoff, 
            @RequestParam("comment_notification_onoff") int commentNotificationOnoff, 
            @RequestParam("message_notification_onoff") int messageNotificationOnoff, 
            HttpSession session) {

        System.out.println("updateNotifications() ctr");
        
//      debug
        System.out.println("all_notification_off: " + allNotificationOff);
        System.out.println("like_notification_onoff: " + likeNotificationOnoff);
        System.out.println("comment_notification_onoff: " + commentNotificationOnoff);
        System.out.println("message_notification_onoff: " + messageNotificationOnoff);

        String session_user_id = (String) session.getAttribute("user_id");
        System.out.println("session_user_id: " + session_user_id); // debug

        if (session_user_id == null) {
            System.out.println("session_user_id is null");
            return "failed";
        }

        try {
            // DB 업데이트 호출
        	settingDao.updateNotificationSettings(session_user_id, allNotificationOff, likeNotificationOnoff, commentNotificationOnoff, messageNotificationOnoff);
            System.out.println("DB 업데이트 성공");
        } catch (Exception e) {
            System.err.println("DB 업데이트 중 오류 발생");
            e.printStackTrace();
            return "failed";
        }

        return "success";
    }

    @PostMapping("/updateIndividualNotification")
    @ResponseBody
    public String updateIndividualNotification( @RequestParam("like_notification_onoff") Optional<Integer> likeNotificationOnOff,
            @RequestParam("comment_notification_onoff") Optional<Integer> commentNotificationOnOff,
            @RequestParam("message_notification_onoff") Optional<Integer> messageNotificationOnOff,
            HttpSession session) {
    	
    	String session_user_id = (String) session.getAttribute("user_id");
    	
    	// 각 알림 상태에 따라 DB 업데이트 처리
        if (likeNotificationOnOff.isPresent()) {
        	settingDao.updateLikeNotification(session_user_id, likeNotificationOnOff.get());
        }
        if (commentNotificationOnOff.isPresent()) {
        	settingDao.updateCommentNotification(session_user_id, commentNotificationOnOff.get());
        }
        if (messageNotificationOnOff.isPresent()) {
        	settingDao.updateMessageNotification(session_user_id, messageNotificationOnOff.get());
        }
    	
    	return "success";
    }
    
    @RequestMapping("/blockList")
    public String blockList(HttpSession session, Model model) {
        System.out.println("blockList() ctr");

        String session_user_id = (String) session.getAttribute("user_id");
        
//      DB의 block_user_id에 데이터가 콤마 형식으로 들어올 경우 DB 상에서 콤마를 구분자로 이름을 추출하고, 그 이름의 아이디, 이미지 사진을 가져올 수 있도록 수정해야 함
        
//      차단된 회원의 아이디, 닉네임, 프로필 사진을 가져와서 blocklist에 저장하기
        blockDto = settingDao.getBlockList(session_user_id);
        model.addAttribute("blockList", blockDto);
        
        return "setting/blockList";
    }
    
    @PostMapping("/unblockUser")
    @ResponseBody
    public ResponseEntity<Map<String, String>> unblockUser(@RequestParam("user_id") String block_userId, HttpSession session) {
    	System.out.println("unblockUser() ctr");
    	System.out.println("차단 해제 요청 수신됨. 차단 당할 사용자 ID: " + block_userId); // debug
    	
    	String session_user_id = (String) session.getAttribute("user_id");
    	System.out.println("세션 사용자 ID: " + session_user_id); // debug
    	
    	// 차단 해제 
    	settingDao.unblockUser(session_user_id, block_userId);
    	System.out.println("차단 해제 성공"); // debug
    	
    	Map<String, String> response = new HashMap<>();
    	response.put("message", "차단 해제 성공");
    	
    	return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @RequestMapping("/accessibility")
    public String accessibility(HttpSession session, Model model) {
        System.out.println("accessibility() ctr");
        
        String session_user_id = (String) session.getAttribute("user_id");
        
        userSettingDto = settingDao.getDarkmode(session_user_id);
        System.out.println("darkmodeOn: " + userSettingDto.getDarkmode_setting_onoff());
        
        model.addAttribute("darkmodeOn", userSettingDto.getDarkmode_setting_onoff());

        return "setting/accessibility";
    }
    
    @PostMapping("/updateDarkmode")
    @ResponseBody
    public String updateDarkmode(@RequestParam("darkmode_setting_onoff") int darkmodeOn, HttpSession session) {
    	System.out.println("updateDarkmode() ctr");
    	System.out.println("darkmode_setting_onoff: " + darkmodeOn);
    	
    	String session_user_id = (String) session.getAttribute("user_id");
    	System.out.println("session_user_id: " + session_user_id); // debug
    	
    	if(session_user_id == null) {
    		System.out.println("session_user_id is null");
    		return "failed";
    	}
 
    	try {
    		settingDao.updateDarkmode(session_user_id, darkmodeOn);
    		System.out.println("DB 업데이트 성공");
    	} catch(Exception e) {
    		System.out.println("DB 업데이트 중 오류 발생");
    		e.printStackTrace();
    		return "failed";
    	}
    	
    	return "success";
    }

    @RequestMapping("/startpageSetting")
    public String startpageSetting(HttpSession session, Model model) {
        System.out.println("startpageSetting() ctr");
        
        String session_user_id = (String) session.getAttribute("user_id");
        System.out.println("session_user_id: " + session_user_id); // debug

        startpageDto = settingDao.getStartpageSetting(session_user_id);
        
//      debug
        System.out.println(startpageDto.getStartpage_music_setting());
        System.out.println(startpageDto.getStartpage_feed_setting());
        System.out.println(startpageDto.getStartpage_community_setting());
        System.out.println(startpageDto.getStartpage_message_setting());
        
        // jsp로 전달
        model.addAttribute("music", startpageDto.getStartpage_music_setting());
        model.addAttribute("feed", startpageDto.getStartpage_feed_setting());
        model.addAttribute("community", startpageDto.getStartpage_community_setting());
        model.addAttribute("message", startpageDto.getStartpage_message_setting());

        return "setting/startpageSetting";
    }
    
    @PostMapping("/updateStartpageSetting")
    @ResponseBody
    public ResponseEntity<Map<String, String>> updateStartpageSetting(@RequestBody Map<String, String> request, @SessionAttribute("user_id") String userId) {
    	String left = request.get("left");
    	String right = request.get("right");
    	
    	try {
    		// 선택된 값에 따라 DB 업데이트
    		settingDao.updateStartpageSetting(userId, left, right);
    		
    		Map<String, String> response = new HashMap<>();
    		response.put("message", "업데이트 성공");
    		return new ResponseEntity<>(response, HttpStatus.OK);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		Map<String, String> response = new HashMap<>();
    		response.put("message", "업데이트 실패");
    		return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    	}
    }

    @RequestMapping("/pageAccessSetting")
    public String pageAccessSetting(HttpSession session, Model model) {
        System.out.println("pageAccessSetting() ctr");

        return "setting/pageAccessSetting";
    }

    @RequestMapping("/reportList")
    public String reportList(HttpSession session, Model model) {
        System.out.println("reportList() ctr");

        return "setting/reportList";
    }
}
