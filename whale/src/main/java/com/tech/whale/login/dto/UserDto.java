package com.tech.whale.login.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class UserDto {
    private String user_id;
    private String user_password;
    private String user_email;
    private String user_nickname;  // 닉네임 필드 추가
    private String user_spotify_id;

    // 필수 필드만 사용하는 생성자 (예: ID, 이메일, 닉네임만 필요할 때)
    public UserDto(String user_id, String user_email, String user_nickname) {
        this.user_id = user_id;
        this.user_email = user_email;
        this.user_nickname = user_nickname;
    }

    // ID와 이메일만 사용하는 생성자 (필요할 경우)
    public UserDto(String user_id, String user_email) {
        this.user_id = user_id;
        this.user_email = user_email;
    }
}
