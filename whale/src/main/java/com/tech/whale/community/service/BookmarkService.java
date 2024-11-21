package com.tech.whale.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tech.whale.community.dao.ComDao;

@Service
public class BookmarkService {

    @Autowired
    private ComDao comDao;

    @Transactional
    public boolean toggleBookmark(int communityId, String userId) {
        // DB에서 커뮤니티 즐겨찾기 여부 확인 후 토글
        boolean isBookmarked = comDao.isCommunityBookmarkedByUser(communityId, userId) > 0;
        if (isBookmarked) {
            comDao.removeCommunityBookmark(communityId, userId);
        } else {
            comDao.addCommunityBookmark(communityId, userId);
        }
        return !isBookmarked; // 변경 후의 상태 반환
    }
}