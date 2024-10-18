package com.tech.whale.community.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tech.whale.community.dao.ComDao;
import com.tech.whale.community.dto.PostDto;
import com.tech.whale.community.dto.PostImgDto;

@Service
public class ComRegService {

    @Autowired
    private ComDao comDao;

    // 게시물 등록과 파일 업로드를 처리하는 메소드
    public void registerPost(PostDto postDto, List<MultipartFile> files) throws IOException {
        // 1. 게시물 등록
    	int postId = comDao.getNextPostId();
    	postDto.setPost_id(postId);
    	comDao.insertPost(postDto);

    	String workPath = System.getProperty("user.dir");
        // 2. 파일 저장 경로 설정
        String uploadDir = workPath + "/src/main/resources/static/images/community";
        File uploadPath = new File(uploadDir);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();  // 경로가 없으면 생성
        }

        // 3. 이미지 저장 및 DB 삽입
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                // 파일을 서버에 저장
                File saveFile = new File(uploadPath, file.getOriginalFilename());
                file.transferTo(saveFile);  // 파일 저장

                // POST_IMG 테이블에 이미지 정보 삽입
                PostImgDto postImgDto = new PostImgDto();
                postImgDto.setPost_id(postId);  // 게시물 ID 설정
                postImgDto.setPost_img_url(saveFile.getAbsolutePath());  // 파일 절대 경로 설정
                postImgDto.setPost_img_type(file.getContentType());  // 파일 MIME 타입 설정
                postImgDto.setPost_img_name(file.getOriginalFilename());  // 파일명 설정
                comDao.insertImage(postImgDto);  // 이미지 정보 DB에 저장
            }
        }
    }
}