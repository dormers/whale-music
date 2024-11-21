package com.tech.whale.message.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class FollowListDto {
    private String follow_user_id;
    private String follow_user_nickname;
    private String follow_user_image_url;
}
