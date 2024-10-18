package com.tech.whale.main.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.tech.whale.setting.dao.SettingDao;
import com.tech.whale.setting.dto.StartpageDto;

@Service
public class MainService {
	private SettingDao settingDao;
	
	public MainService(SettingDao settingDao) {
		this.settingDao = settingDao;
	}

	public String[] checkStartPageMain(HttpSession session) {
		StartpageDto startpageDto = settingDao.getStartpageSetting((String) session.getAttribute("user_id"));
		return new String[] {searchStartPageMain(startpageDto,1),searchStartPageMain(startpageDto,2)};
	}
	
	private String searchStartPageMain(StartpageDto startpageDto, int x) {
		if (startpageDto.getStartpage_music_setting() == x) {return "streaming";}
		else if (startpageDto.getStartpage_feed_setting() == x) {return "feedHome";}
		else if (startpageDto.getStartpage_community_setting() == x) {return "communityHome";}
		else if (startpageDto.getStartpage_message_setting() == x) {return "message/home";}
		else {return "Error";}
	}
}
