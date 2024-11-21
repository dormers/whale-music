package com.tech.whale.community.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.CommentDto;
import com.tech.whale.community.dto.PostDto;
import com.tech.whale.community.service.BookmarkService;
import com.tech.whale.community.service.ComDetailService;
import com.tech.whale.community.service.ComHomeService;
import com.tech.whale.community.service.ComLikeCommentService;
import com.tech.whale.community.service.ComPostService;
import com.tech.whale.community.service.ComRegService;
import com.tech.whale.community.service.ComServiceInter;
import com.tech.whale.community.service.PostUpdateService;
import com.tech.whale.community.vo.SearchVO;

@Controller
public class CommunityController {
	ComServiceInter comServiceInter;
	
	@Autowired
	private ComDao comDao;
	
	@Autowired
	private ComLikeCommentService comLikeCommentService;
	
	@Autowired
	private ComRegService comRegService;
	
	@Autowired
	private ComHomeService comHomeService;
	
	@Autowired
	private PostUpdateService postUpdateService;
	
	@Autowired
	private BookmarkService bookmarkService;
	
	@PostMapping("/toggleBookmark")
	@ResponseBody
	public String toggleBookmark(@RequestParam("communityId") int communityId, HttpSession session) {
	    String userId = (String) session.getAttribute("user_id"); // 세션에서 사용자 ID를 가져옴
	    if (userId == null) {
	        return "error"; // 세션이 없으면 에러
	    }

	    boolean isBookmarked = bookmarkService.toggleBookmark(communityId, userId);
	    return isBookmarked ? "followed" : "unfollowed"; // 즐겨찾기 상태에 따라 응답
	}
	
	@RequestMapping("/communityHome")
	public String communityHome(HttpServletRequest request, Model model) {
		System.out.println("communityHome");
		model.addAttribute("request", request);
		comHomeService.execute(model);
		
		return "community/communityHome";
	}
	
	@RequestMapping("/communityPost")
	public String communityPost(@RequestParam("c") int communityId, 
			@RequestParam(value = "tagId", required = false) Integer tagId,
			SearchVO searchVO, HttpServletRequest request, Model model) {
		System.out.println("communityPost");
		System.out.println("communityPost - communityId: " + communityId);
		String communityName = comDao.getCommunityName(communityId);
		
	    if (tagId == null) {
	        tagId = -1; // 기본값으로 설정
	    }
		
		model.addAttribute("communityName", communityName);
		model.addAttribute("communityId", communityId);
		model.addAttribute("tagId", tagId);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("request", request);
		comServiceInter = new ComPostService(comDao);
		comServiceInter.execute(model);
		
		return "community/communityPost";
	}
	
	@RequestMapping("/communityDetail")
	public String communityDetail(
	    @RequestParam("c") int communityId,
	    HttpSession session,
	    @RequestParam("p") String postId,
	    HttpServletRequest request,
	    Model model) {

	    String communityName = comDao.getCommunityName(communityId);
	    String now_id = (String) session.getAttribute("user_id");

	    // 모델에 필요한 데이터 추가
	    model.addAttribute("now_id", now_id);
	    model.addAttribute("communityName", communityName);
	    model.addAttribute("postId", postId);
	    model.addAttribute("request", request);
	    model.addAttribute("communityId", communityId);

	    // 서비스 클래스를 통해 비즈니스 로직 처리
	    comServiceInter = new ComDetailService(comDao, comLikeCommentService);
	    comServiceInter.execute(model);

	    return "community/communityDetail";
	}
	
	@PostMapping("/communityDetail/like")
	@ResponseBody
	public Map<String, Object> likePost(@RequestParam("postId") String postId, @RequestParam("userId") String userId) {
	    int newLikeCount = comLikeCommentService.toggleLike(postId, userId);

	    Map<String, Object> result = new HashMap<>();
	    result.put("success", true);
	    result.put("newLikeCount", newLikeCount);

	    return result;
	}
    
    @PostMapping("/communityDetail/comments")
    public String commentsPost(@RequestParam("c") int communityId, 
    		@RequestParam("comments") String comments, 
    		@RequestParam("postId") String postId, 
    		@RequestParam("userId") String userId,
    	    @RequestParam(value = "parentCommentId", required = false) String parentCommentId,
    	    Model model) {
        

    	comLikeCommentService.insertComment(postId, userId, comments, parentCommentId);

        return "redirect:/communityDetail?c=" + communityId + "&p=" + postId;
        
    }
    
    @RequestMapping("/communityDetail/deleteComment")
    public String deleteComments(@RequestParam("postCommentsId") String postCommentsId,
                                @RequestParam("postId") String postId,
                                @RequestParam("communityId") int communityId) {
    	
    	System.out.println("postCommentsId : " + postCommentsId);
        // 댓글 삭제
        comLikeCommentService.deleteComments(postCommentsId);

        // 삭제 후 해당 게시글 디테일 페이지로 리다이렉트
        return "redirect:/communityDetail?c=" + communityId + "&p=" + postId;
    }

	
	@RequestMapping("/communityReg")
	public String communityReg(HttpServletRequest request, HttpSession session, @RequestParam("c") int communityId, Model model) {
		System.out.println("communityReg");
		System.out.println(session.getAttribute("user_id"));
		String now_id = (String) session.getAttribute("user_id");

		String communityName = comDao.getCommunityName(communityId);
		
		List<PostDto> postTag = comDao.chooseTag();
		System.out.println("Post Tags: " + postTag);
		model.addAttribute("postTag", postTag);
		model.addAttribute("now_id", now_id);
		model.addAttribute("communityId", communityId);
		model.addAttribute("communityName", communityName);
		return "community/communityReg";
	}
	
	@RequestMapping("/communityRegDo")
	public String communityRegDo(@RequestParam("community_id") int communityId,
            @RequestParam("post_title") String post_title,
            @RequestParam("post_text") String post_text,
            @RequestParam("user_id") String user_id,
            @RequestParam("post_tag_id") int post_tag_id,  // 태그 ID
            @RequestParam(value = "selectedTrackId", required = false) String track_id,
            HttpSession session, Model model) {
		
		System.out.println("communityReg");
		
		PostDto postDto = new PostDto();
		postDto.setCommunity_id(communityId);
		postDto.setUser_id(user_id);
		postDto.setPost_title(post_title);
		postDto.setPost_text(post_text);
		postDto.setPost_tag_id(post_tag_id);
		if (track_id != null) {
			postDto.setTrack_id(track_id);			
		}
        try {
            // 게시글 및 이미지 저장
            comRegService.registerPost(postDto);
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "이미지 업로드 중 오류가 발생했습니다.");
            return "errorPage";
        }

        return "redirect:/communityPost?c=" + communityId;
	}
	
	@RequestMapping("/communityDetailDel")
	public String CommunityDetailDel(@RequestParam("p") String post_id, @RequestParam("c") int comId) {
		System.out.println("communityDetailDel");
		System.out.println(post_id);
		
		String postNum = comDao.getPostNumById(post_id);
		
		comDao.deletePost(post_id);
		
		comDao.updatePostNumsAfterDeletion(comId, postNum);
		
		return "redirect:/communityPost?c="+comId;
	}
	
	@RequestMapping(value = "/communityUpdate", method = RequestMethod.GET)
	public String communityUpdate(HttpServletRequest request, HttpSession session, 
            @RequestParam("p") String postId, 
            @RequestParam("c") int communityId, Model model) {
		System.out.println("communityUpdate");
		
	    String now_id = (String) session.getAttribute("user_id");
	    System.out.println("현재 사용자 ID: " + now_id);

	    // 커뮤니티 이름 가져오기
	    String communityName = comDao.getCommunityName(communityId);

	    // 게시물 정보 가져오기
	    PostDto post = comDao.getPost(postId);
	    if (post == null) {
	        // 게시물이 없는 경우 처리
	        return "error/noPostFound";
	    }
	    
	    // 게시물에 사용할 태그 리스트 가져오기
	    List<PostDto> postTag = comDao.chooseTag();
	    System.out.println("Post Tags: " + postTag);

	    // 모델에 필요한 데이터 추가
	    model.addAttribute("postTag", postTag);
	    model.addAttribute("now_id", now_id);
	    model.addAttribute("communityId", communityId);
	    model.addAttribute("communityName", communityName);
	    model.addAttribute("postId", postId);
	    model.addAttribute("post", post);

		return "community/communityUpdate";
	}
	
	@RequestMapping(value = "/communityUpdateDo", method = RequestMethod.POST)
	public String communityUpdateDo(HttpServletRequest request, 
	                                @RequestParam("post_id") int postId, 
	                                @RequestParam("community_id") int communityId,
	                                @RequestParam("post_tag_id") int postTagId,
	                                @RequestParam("post_title") String postTitle,
	                                @RequestParam("post_text") String postText,
	                                @RequestParam(value = "selectedTrackId", required = false) String selectedTrackId,
	                                RedirectAttributes redirectAttributes) {
	    
	    PostDto postDto = new PostDto();
	    postDto.setPost_id(postId);
	    postDto.setPost_title(postTitle);
	    postDto.setPost_text(postText);
	    postDto.setPost_tag_id(postTagId);
	    
	    try {
	        // 게시물 업데이트
	        postUpdateService.updatePost(postDto);
	        
	        // 음악 정보 업데이트
	        if (selectedTrackId != null && !selectedTrackId.isEmpty()) {
	            postUpdateService.updatePostMusic(postId, selectedTrackId);
	        } else {
	            postUpdateService.removePostMusic(postId);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "errorPage";
	    }
	    
	    // 업데이트 후 게시물 상세 페이지로 리다이렉트
	    return "redirect:/communityDetail?c=" + communityId + "&p=" + postId;
	}
	
	
	
	
	@PostMapping("/communityDetail/commentLike")
	@ResponseBody
	public Map<String, Object> likeComment(@RequestParam("commentId") String commentId, @RequestParam("userId") String userId) {
	    int newLikeCount = comLikeCommentService.toggleCommentLike(commentId, userId);

	    Map<String, Object> result = new HashMap<>();
	    result.put("success", true);
	    result.put("newLikeCount", newLikeCount);

	    return result;
	}
	
}
