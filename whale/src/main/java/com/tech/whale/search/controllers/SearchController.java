package com.tech.whale.search.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.tech.whale.community.dto.PostDto;
import com.tech.whale.feed.dto.FeedDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tech.whale.community.dto.PostDto;
import com.tech.whale.feed.dto.FeedDto;
import com.tech.whale.search.service.SearchService;
import com.tech.whale.setting.dto.UserInfoDto;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SearchController {

	@Autowired
	private SearchService searchService;

	// [ 메인 페이지 이동 ]
    @RequestMapping("/searchHome")
	public String main(HttpSession session) {
    	return "search/searchHome";
	}
	
	// [ 유저 검색 결과 송출 ]
	@GetMapping("/search/user")
    @ResponseBody
    public Map<String, Object> searchUser(@RequestParam("keyword") String keyword) {
        Map<String, Object> result = new HashMap<>();
        try {
        	List<UserInfoDto> userList = searchService.getSearchUserService(keyword);
            result.put("success", true);
            result.put("userList", userList);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result; // JSON 형식으로 응답
    }

    // [ 게시글 검색 결과 송출 ]
    @GetMapping("/search/post")
    @ResponseBody
    public Map<String, Object> searchPost(@RequestParam("keyword") String keyword) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<PostDto> postList = searchService.getSearchPostService(keyword);
            result.put("success", true);
            result.put("postList", postList);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // [ 피드 검색 결과 송출 ]
    @GetMapping("/search/feed")
    @ResponseBody
    public Map<String, Object> searchFeed(@RequestParam("keyword") String keyword, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<FeedDto> feedList = searchService.getSearchFeedService(keyword,session);
            result.put("success", true);
            result.put("feedList", feedList);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
}
