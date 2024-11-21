package com.tech.whale.feed.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tech.whale.feed.dao.FeedDao;
import com.tech.whale.feed.dto.FeedDto;
import com.tech.whale.feed.dto.FeedImgDto;

@Service
public class FeedWriteService {
	
	@Autowired
	private FeedDao feedDao;
	
	
	public void registerFeed(FeedDto feedDto, String feedImageUrl) throws IOException {
	    int feedId = feedDao.getNextFeedId();
	    feedDto.setFeed_id(feedId);
	    feedDao.insertFeed(feedDto);
	    if (feedDto.getTrack_id() != null) {
	        int feedMusicId = feedDao.getNextFeedMusicId();
	        feedDto.setFeed_music_id(feedMusicId);
	        feedDao.insertFeedMusic(feedDto);			
	    }
	    
	    if (feedImageUrl != null && !feedImageUrl.isEmpty()) {
	        FeedImgDto feedImgDto = new FeedImgDto();
	        feedImgDto.setFeed_id(feedId);  // 게시물 ID 설정
	        feedImgDto.setFeed_img_url(feedImageUrl);  // 이미지 URL 설정
	        feedImgDto.setFeed_img_type("image/jpeg");  // MIME 타입 설정 (필요에 따라 조정)
	        feedImgDto.setFeed_img_name("");  // 파일명 설정 (필요 없다면 빈 문자열)
	        feedDao.insertImage(feedImgDto);  // 이미지 정보 DB에 저장
	    }
	}



}
