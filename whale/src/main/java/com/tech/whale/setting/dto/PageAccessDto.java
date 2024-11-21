package com.tech.whale.setting.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class PageAccessDto {
	private int page_access_mypage;
	private int page_access_notification;
	private int page_access_setting;
	private int page_access_music;
	private int page_access_message;
	
}
