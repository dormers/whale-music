package com.tech.whale.admin.controllers;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tech.whale.admin.dao.AdminIDao;
import com.tech.whale.admin.service.AdminAccountUserInfoService;
import com.tech.whale.admin.service.AdminAccountUserListService;
import com.tech.whale.admin.service.AdminAccountUserModifyService;
import com.tech.whale.admin.service.AdminMainPageService;
import com.tech.whale.admin.service.AdminUserImgDeleteService;
import com.tech.whale.admin.service.AdminUserInfoCommentService;
import com.tech.whale.admin.service.AdminUserInfoFeedService;
import com.tech.whale.admin.service.AdminUserInfoPostService;
import com.tech.whale.admin.service.AdminUserNicknameModifyService;
import com.tech.whale.admin.service.AdminUserStatusLogListService;
import com.tech.whale.admin.util.AdminSearchVO;
import com.tech.whale.community.vo.SearchVO;



@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminAccountUserListService adminAccountUserListService;
	@Autowired
	private AdminAccountUserInfoService adminAccountUserInfoService;
	@Autowired
	private AdminUserInfoPostService adminUserInfoPostService;
	@Autowired
	private AdminUserInfoFeedService adminUserInfoFeedService;
	@Autowired
	private AdminUserInfoCommentService adminUserInfoCommentService;
	@Autowired
	private AdminAccountUserModifyService adminAccountUserModifyService;
	@Autowired
	private AdminUserNicknameModifyService adminUserNicknameModifyService;
	@Autowired
	private AdminUserImgDeleteService adminUserImgDeleteService;
	@Autowired
	private AdminMainPageService adminMainPageService;
	@Autowired
	private AdminUserStatusLogListService adminUserStatusLogListService;
	
	@Autowired
	private AdminIDao adminIDao;
	
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
	
	public void accountSubBar(Model model) {
	    Map<String, String> subMenu = new LinkedHashMap<>();
	    subMenu.put("adminAccountUserListView", "유저관리");
	    subMenu.put("adminUserStatusLogListView", "정지내역");
	    
	    model.addAttribute("subMenu", subMenu);
	}
	
	@RequestMapping("/adminMainView")
	public String adminMainView(HttpServletRequest request,
			HttpSession session,
			Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("pname", "HOME");
		model.addAttribute("contentBlockJsp",
				"../main/adminMainContent.jsp");
	    model.addAttribute("contentBlockCss",
	    		"/whale/static/css/admin/main/adminMainContent.css");
	    model.addAttribute("subBarBlockJsp",
	    		null);
	    model.addAttribute("subBarBlockCss",
	    		null);
	    accountSubBar(model);
	    
	    adminMainPageService.execute(model);
	    adminMainPageService.adminMemo(model);
	    
	    
		return "/admin/view/adminMainView";
	}
	
	@RequestMapping("/adminMemoSave")
	@Transactional
	public String adminMemoSave(HttpServletRequest request,
			Model model) {
		model.addAttribute("request", request);
		adminMainPageService.memoUpdate(model);
		return "redirect:adminMainView";
	}
	
	
	@RequestMapping("/adminAccountUserListView")
	public String adminAccountUserListView(
			HttpServletRequest request,
			AdminSearchVO searchVO,
			Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("pname", "유저관리");
		model.addAttribute("contentBlockJsp",
				"../account/adminAccountUserListContent.jsp");
	    model.addAttribute("contentBlockCss",
	    		"/whale/static/css/admin/account/adminAccountUserListContent.css");
	    accountSubBar(model);
	    
	    adminAccountUserListService.execute(model);
	    adminAccountUserInfoService.excuteArray(model);
		return "/admin/view/adminOutlineForm";
	}
	
	
	@RequestMapping("/adminAccountUserInfo")
	public String adminAccountUserInfo(
			@RequestParam("page") int page,
			@RequestParam("searchType") String searchType,
			@RequestParam("sk") String sk,
			@RequestParam("searchOrderBy") String searchOrderBy,
			HttpServletRequest request,
			AdminSearchVO searchVO,
			Model model) {
		
		model.addAttribute("searchOrderBy", searchOrderBy);
		model.addAttribute("sk", sk);
		model.addAttribute("searchType", searchType);
		model.addAttribute("page", page);
		model.addAttribute("request", request);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("pname", "유저정보");
		model.addAttribute("contentBlockJsp",
				"../account/adminAccountUserInfoContent.jsp");
	    model.addAttribute("contentBlockCss",
	    		"/whale/static/css/admin/account/adminAccountUserInfoContent.css");
	    accountSubBar(model);
	    
	    adminAccountUserInfoService.execute(model);
		adminUserInfoPostService.execute(model);
		adminUserInfoFeedService.execute(model);
		adminUserInfoCommentService.execute(model);
		
		return "/admin/view/adminOutlineForm";
	}
	
	
	@RequestMapping("/adminAccountUserModify")
	public String adminAccountUserModify(
			@RequestParam("page") int page,
			@RequestParam("searchType") String searchType,
			@RequestParam("sk") String sk,
			@RequestParam("searchOrderBy") String searchOrderBy,
			HttpServletRequest request,
			Model model) {
		
		model.addAttribute("searchOrderBy", searchOrderBy);
		model.addAttribute("sk", sk);
		model.addAttribute("searchType", searchType);
		model.addAttribute("page", page);
		model.addAttribute("request", request);
		model.addAttribute("pname", "유저정보수정");
		model.addAttribute("contentBlockJsp",
				"../account/adminAccountUserModifyContent.jsp");
		model.addAttribute("contentBlockCss",
				"/whale/static/css/admin/account/adminAccountUserModifyContent.css");
		accountSubBar(model);
		
		adminAccountUserModifyService.execute(model);
		adminAccountUserInfoService.execute(model);
		
		return "/admin/view/adminOutlineForm";
	}
	
	@RequestMapping("/adminUserAccessModify")
	public String adminUserAccessModify(
			@RequestParam("page") int page,
			@RequestParam("searchType") String searchType,
			@RequestParam("sk") String sk,
			@RequestParam("searchOrderBy") String searchOrderBy,
			HttpSession session,
			HttpServletRequest request,
			Model model) {
		model.addAttribute("request", request);
		String userId = request.getParameter("userId");
		
		adminAccountUserModifyService.modifyAccess(model,session);
		
		
		return "redirect:adminAccountUserModify?"
				+ "userId=" + userId
				+ "&page=" + page
				+ "&searchType=" + searchType
				+ "&searchOrderBy=" + searchOrderBy
				+ "&sk=" + sk;
	}
	
	@RequestMapping("/adminUserStatusModify")
	public String adminUserStatusModify(
			@RequestParam("page") int page,
			@RequestParam("searchType") String searchType,
			@RequestParam("sk") String sk,
			@RequestParam("searchOrderBy") String searchOrderBy,
			HttpSession session,
			HttpServletRequest request,
			Model model) {
		model.addAttribute("request", request);
		String userId = request.getParameter("userId");
		
		adminAccountUserModifyService.modifyStatus(model,session);
		
		
		return "redirect:adminAccountUserModify?"
				+ "userId=" + userId
				+ "&page=" + page
				+ "&searchType=" + searchType
				+ "&searchOrderBy=" + searchOrderBy
				+ "&sk=" + sk;
	}
	
	@RequestMapping("/adminUserNicknameModify")
	public String adminUserNicknameModify(
			@RequestParam("page") int page,
			@RequestParam("searchType") String searchType,
			@RequestParam("sk") String sk,
			@RequestParam("searchOrderBy") String searchOrderBy,
			HttpServletRequest request,
			Model model) {
		model.addAttribute("request", request);
		String userId = request.getParameter("userId");
		
		adminUserNicknameModifyService.execute(model);
		
				
		return "redirect:adminAccountUserModify?"
				+ "userId=" + userId
				+ "&page=" + page
				+ "&searchType=" + searchType
				+ "&searchOrderBy=" + searchOrderBy
				+ "&sk=" + sk;
	}
	
	@RequestMapping("/adminUserImgDelete")
	public String adminUserImgDelete(
			@RequestParam("page") int page,
			@RequestParam("searchType") String searchType,
			@RequestParam("sk") String sk,
			@RequestParam("searchOrderBy") String searchOrderBy,
			@RequestParam("userId") String userId,
			HttpServletRequest request,
			Model model) {
		model.addAttribute("request", request);
		
		adminUserImgDeleteService.execute(model);
		
		
		return "redirect:adminAccountUserModify?"
				+ "userId=" + userId
				+ "&page=" + page
				+ "&searchType=" + searchType
				+ "&searchOrderBy=" + searchOrderBy
				+ "&sk=" + sk;
	}
	
	@RequestMapping("/adminUserStatusLogListView")
	public String adminUserStatusLogListView(
			HttpServletRequest request,
			AdminSearchVO searchVO,
			Model model) {
		
		model.addAttribute("request", request);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("pname", "정지내역");
		model.addAttribute("contentBlockJsp",
				"../account/adminUserStatusLogListContent.jsp");
	    model.addAttribute("contentBlockCss",
	    		"/whale/static/css/admin/account/adminAccountUserListContent.css");
	    accountSubBar(model);
	    
	    adminUserStatusLogListService.execute(model);
	    
		return "/admin/view/adminOutlineForm";
	}
	
	
}
