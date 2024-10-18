package com.tech.whale.admin.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.service.AdminAccountUserService;
import com.tech.whale.admin.service.AdminServiceInter;
import com.tech.whale.community.vo.SearchVO;


/*

- 광고 업무
광고주가 신청서를 작성할 수 있는 양식. (페이지)
광고를 심사하고 승인할 수 있는 양식(승인 거절 남김)
승인된 광고 게시
광고id, 제목, 내용, 이미지url, 광고주정보, 광고상태, 시작 종료날짜
광고 기간에만 게시되도록 종료날짜에 광고 비활성화
노출횟수, 클릭수, 광고종료시 연장 및 새로신청

*/




@Controller
public class AdminController {
	
	private AdminServiceInter adService;
	private AdminIDao AdminIDao;
	
	@RequestMapping("/adminAccountOfficialView")
	public String adminAccountOfficialView(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("pname", "오피셜관리");
		
		return "/admin/view/adminAccountOfficialView";
	}
	
	@RequestMapping("/adminAccountClientView")
	public String adminAccountClientView(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("pname", "광고주관리");
		
		return "/admin/view/adminAccountClientView";
	}
	
	@RequestMapping("/adminMyInfoView")
	public String adminMyInfoView(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("pname", "나의정보");
		
		return "/admin/view/adminMyInfoView";
	}
	
	@RequestMapping("/adminMainView")
	public String adminMainView(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("pname", "HOME");
		
		return "/admin/view/adminMainView";
	}
	
	@RequestMapping("/adminAccountAddView")
	public String adminAccountAddView(HttpServletRequest request,
			SearchVO searchVO , Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("pname", "권한추가");
		
		return "/admin/view/adminAccountAddView";
	}
	
	@RequestMapping("/adminAccountUserView")
	public String adminAccountUserView(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("pname", "유저관리");
		
		adService = new AdminAccountUserService(AdminIDao);
		
		return "/admin/view/adminAccountUserView";
	}
	
	
}
