package com.tech.whale.community.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.CommunityDto;

public class ComHomeService implements ComServiceInter {
	private ComDao comDao;
	
	public ComHomeService(ComDao comDao) {
		this.comDao = comDao;
	}
	
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		System.out.println(">>> CommunityHomeService");
//		Map<String, Object> map = model.asMap();
//		HttpServletRequest request = (HttpServletRequest) map.get("request");

		List<CommunityDto> dto = comDao.getComAll();
		
		model.addAttribute("list",dto);
		
	}

}
