package com.tech.whale.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.PostDto;

@Service
public class PostUpdateService {

    @Autowired
    private ComDao comDao;
    
    @Transactional
    public void updatePost(PostDto postDto) {
        comDao.updatePost(postDto);
    }

    @Transactional
    public void updatePostMusic(int postId, String trackId) {
        // 기존 음악 정보가 있는지 확인
        PostDto existingPost = comDao.getPost(""+postId);
        if (existingPost.getTrack_id() != null) {
            // 기존 음악 정보가 있으면 업데이트
            comDao.updatePostMusic(postId, trackId);
        } else {
            PostDto postDto = new PostDto();
            postDto.setPost_id(postId);
            postDto.setTrack_id(trackId);
            int postMusicId = comDao.getNextPostMusicId();
            postDto.setPost_music_id(postMusicId);
            comDao.insertPostMusic(postDto);
        }
    }

    @Transactional
    public void removePostMusic(int postId) {
        comDao.deletePostMusic(postId);
    }
}