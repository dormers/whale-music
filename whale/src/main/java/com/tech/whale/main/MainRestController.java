package com.tech.whale.main;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.tech.whale.main.service.MainService;

@RestController
public class MainRestController {
	private MainService mainService;
	
	public MainRestController(MainService mainService) {
		this.mainService = mainService;
	}
	
	@PostMapping(value = "/main/device_id", produces = MediaType.APPLICATION_JSON_VALUE)
    public void mainGetDeviceId(@RequestBody HashMap<String, Object> map, HttpSession session) {
		session.setAttribute("device_id", map.get("device_id"));
    }
	
	// [ 시작페이지 설정 값 ]
	@GetMapping(value = "/main/checkStartPage", produces = MediaType.APPLICATION_JSON_VALUE)
	public HashMap<String, Object> checkStartPage(HttpSession session) {
		String[] startPages = mainService.checkStartPageMain(session);
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("leftStartPage",startPages[0]);
		map.put("rightStartPage",startPages[1]);
		
		return map;
	}
}
