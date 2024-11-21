package com.tech.whale.login.controller;

import com.tech.whale.login.dto.UserDto;
import com.tech.whale.login.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;

@RestController
public class RegisterController {

    @Autowired
    private UserService userService;

    @PostMapping(value = "/register/complete", produces = MediaType.APPLICATION_JSON_VALUE)
    public HashMap<String, Object> registerUser(@RequestBody HashMap<String, Object> map, HttpSession session) {
        HashMap<String, Object> response = new HashMap<>();

        //입력받은 값
        String username = (String) map.get("username");
        String password = (String) map.get("password");
        String email = (String) map.get("email");
        String nickname = (String) map.get("nickname");

        // 중복 검사
        if (userService.isUsernameTaken(username)) {
            response.put("success", false);
            response.put("message", "이미 사용 중인 아이디입니다.");
            return response;
        }
//        if (userService.isNicknameTaken(nickname)) {
//            response.put("success", false);
//            response.put("message", "이미 사용 중인 닉네임입니다.");
//            return response;
//        }
//        if (userService.isEmailTaken(email)) {
//            response.put("success", false);
//            response.put("message", "이미 사용 중인 이메일입니다.");
//            return response;
//        }

        // User 객체를 통해 DB에 저장 사용자 등록 처리
        boolean isRegistered = userService.registerUser(username, password, email, nickname, (String) session.getAttribute("spotifyId"));

        if (isRegistered) {
            response.put("success", true);
            userService.followAdmin(username, "WHALE"); // 새 유저가 WHALE을 팔로우
            userService.followUser("WHALE", username); // WHALE이 새 유저를 팔로우

            response.put("message", "회원가입 완료되었습니다.");
            response.put("redirectTo", "/whale");
            session.invalidate(); //세션 초기화
            return response; // 성공 시 로그인 페이지로 리디렉트
        } else {
            response.put("success", false);
            response.put("message", "회원가입 실패했습니다.");
            return response;
        }
    }
}
