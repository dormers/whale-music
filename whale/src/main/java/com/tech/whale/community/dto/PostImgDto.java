package com.tech.whale.community.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class PostImgDto {
    private int post_img_id;
    private int post_id;
    private String post_img_url;
    private String post_img_type;
    private String post_img_name;
}
