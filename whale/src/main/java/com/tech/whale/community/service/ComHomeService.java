package com.tech.whale.community.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.CommunityDto;

@Service
public class ComHomeService implements ComServiceInter {

    @Autowired
    private ComDao comDao;

    @Override
    public void execute(Model model) {
        System.out.println(">>> CommunityHomeService");
        HttpServletRequest request = (HttpServletRequest) model.getAttribute("request");
        String userId = (String) request.getSession().getAttribute("user_id"); // 세션 속성 이름 일치

        // 모든 커뮤니티 목록을 가져옴
        List<CommunityDto> communities = comDao.getComAll(userId);

        // 각 커뮤니티의 즐겨찾기 여부를 확인하여 설정
        for (CommunityDto community : communities) {
            boolean isBookmarked = comDao.isCommunityBookmarkedByUser(community.getCommunity_id(), userId) > 0;
            community.setBookmarked(isBookmarked); // 즐겨찾기 여부 설정
        }

        // 즐겨찾기 여부가 설정된 커뮤니티 리스트를 모델에 추가
        model.addAttribute("list", communities);
    }
}