package com.tech.whale.admin.controllers;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.dto.AdminLVDataDto;
import com.tech.whale.admin.statistic.service.AdminStatisticService;


@Controller
@RequestMapping("/admin")
public class AdminStatisticController {
	
	
	@Autowired
	private AdminIDao adminIDao;
	@Autowired
	private AdminStatisticService adminStatisticService;
	
	@ModelAttribute("myId")
    public String addUserIdToModel(HttpSession session) {
        return (String) session.getAttribute("user_id");
    }
	
	@ModelAttribute("myImgUrl")
	public String myImgUrl(Model model,HttpSession session) {
		String myId = (String) session.getAttribute("user_id");
		String myImgSty = adminIDao.myImg(myId);
		return myImgSty;
	}
	
	public void statisticSubBar(Model model) {
	    Map<String, String> subMenu = new LinkedHashMap<>();
	    subMenu.put("adminStatisticWritingView", "커뮤&피드 아직");
	    subMenu.put("adminStatisticTrackView", "음악 아직");
	    subMenu.put("adminStatisticReportView", "신고");
	    subMenu.put("adminStatisticUserView", "유저");
	    
	    model.addAttribute("subMenu", subMenu);
	}
	
	@RequestMapping("/adminStatisticReportView")
	public String adminStatisticReportView(
			HttpServletRequest request,
			Model model) {
		model.addAttribute("request", request);
		model.addAttribute("pname", "신고통계");
		model.addAttribute("contentBlockJsp",
				"../statistic/adminStatisticReportContent.jsp");
	    model.addAttribute("contentBlockCss",
	    		"/whale/static/css/admin/statistic/adminStatisticReportContent.css");
	    model.addAttribute("subBarBlockJsp",
	    		null);
	    model.addAttribute("subBarBlockCss",
	    		null);
	    statisticSubBar(model);
	    
	    adminStatisticService.reportStatistic1(model);
	    adminStatisticService.reportStatistic2(model);
	    adminStatisticService.reportStatistic3(model);
	    
        
        
		
		return "/admin/view/adminOutlineForm";
	}
	
	@RequestMapping("/adminStatisticUserView")
	public String adminStatisticUserView(
			HttpServletRequest request,
			Model model) {
		model.addAttribute("request", request);
		model.addAttribute("pname", "신고통계");
		model.addAttribute("contentBlockJsp",
				"../statistic/adminStatisticUserContent.jsp");
		model.addAttribute("contentBlockCss",
				"/whale/static/css/admin/statistic/adminStatisticReportContent.css");
		model.addAttribute("subBarBlockJsp",
				null);
		model.addAttribute("subBarBlockCss",
				null);
		statisticSubBar(model);
		
		adminStatisticService.userStatistic1(model);
		
		
		
		
		return "/admin/view/adminOutlineForm";
	}
	
}