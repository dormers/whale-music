package com.tech.whale.community.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.CommentDto;
import com.tech.whale.community.dto.PostDto;
import com.tech.whale.community.service.ComDetailService;
import com.tech.whale.community.service.ComHomeService;
import com.tech.whale.community.service.ComLikeCommentService;
import com.tech.whale.community.service.ComPostService;
import com.tech.whale.community.service.ComServiceInter;
import com.tech.whale.community.vo.SearchVO;

@Controller
public class CommunityController {
	ComServiceInter comServiceInter;
	
	@Autowired
	private ComDao comDao;
	
	@Autowired
	private ComLikeCommentService comLikeCommentService;
	
	@RequestMapping("/communityHome")
	public String communityHome(HttpServletRequest request, Model model) {
		System.out.println("communityHome");
		model.addAttribute(request);
		comServiceInter = new ComHomeService(comDao);
		comServiceInter.execute(model);
		
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
	public String communityDetail(@RequestParam("c") int communityId, @RequestParam("p") String postId, HttpServletRequest request, Model model) {
		System.out.println("communityDetail");
		System.out.println("postId : " + postId);
		String communityName = comDao.getCommunityName(communityId);
		
		PostDto postDetail = comDao.getPost(postId);
		
		List<CommentDto> commentsList = comLikeCommentService.getCommentsForPost(postId);
		postDetail.setComments(commentsList);
		
		System.out.println("Comments List: " + commentsList);
		
		model.addAttribute("communityName", communityName);
		model.addAttribute("postId", postId);
		model.addAttribute("postDetail", postDetail);
		model.addAttribute("request", request);
		comServiceInter = new ComDetailService(comDao);
		System.out.println("Before execute - postDetail: " + postDetail);
		comServiceInter.execute(model);
		System.out.println("After execute - postDetail: " + model.getAttribute("postDetail"));
		return "community/communityDetail";
	}
	
    @PostMapping("/communityDetail/like")
    public String likePost(@RequestParam("c") int communityId, @RequestParam("postId") String postId, @RequestParam("userId") String userId, Model model) {
        int newLikeCount = comLikeCommentService.toggleLike(postId, userId);

        PostDto postDetail = comDao.getPost(postId); 
        postDetail.setLikeCount(newLikeCount);
        
        // 모델에 필요한 값 추가
        model.addAttribute("postDetail", postDetail);
        model.addAttribute("likeCount", newLikeCount);

        return "redirect:/communityDetail?c=" + communityId + "&p=" + postId;
        
    }
    
    @PostMapping("/communityDetail/comments")
    public String commentsPost(@RequestParam("c") int communityId, @RequestParam("comments") String comments, @RequestParam("postId") String postId, @RequestParam("userId") String userId, Model model) {
        

    	comLikeCommentService.insertComment(postId, userId, comments);
    	
    	List<CommentDto> commentsList = comLikeCommentService.getCommentsForPost(postId);
    	
    	
        PostDto postDetail = comDao.getPost(postId); 
        postDetail.setComments(commentsList);
        
        
        // 모델에 필요한 값 추가
        model.addAttribute("postDetail", postDetail);

        return "redirect:/communityDetail?c=" + communityId + "&p=" + postId;
        
    }
    
    @PostMapping("/communityDetail/deleteComment")
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
	public String communityReg(HttpServletRequest request, Model model) {
		System.out.println("communityReg");
		return "community/communityReg";
	}
	
	@RequestMapping(value = "/communityUpdate", method = RequestMethod.POST)
	public String communityUpdate(HttpServletRequest request, Model model) {
		System.out.println("communityUpdate");
		return "community/communityUpdate";
	}
}
