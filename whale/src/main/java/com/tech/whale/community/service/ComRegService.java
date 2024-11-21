package com.tech.whale.community.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.PostDto;

@Service
public class ComRegService {

    @Autowired
    private ComDao comDao;

    // 게시물 등록과 파일 업로드를 처리하는 메소드
    public void registerPost(PostDto postDto) throws IOException {
        // 1. 게시물 등록
    	int postId = comDao.getNextPostId();
    	postDto.setPost_id(postId);
    	comDao.insertPost(postDto);
    	if (postDto.getTrack_id() != null) {
			int postMusicId = comDao.getNextPostMusicId();
			postDto.setPost_music_id(postMusicId);
			comDao.insertPostMusic(postDto);
		}


    }
}