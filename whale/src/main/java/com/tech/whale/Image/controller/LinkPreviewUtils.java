package com.tech.whale.Image.controller;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component
public class LinkPreviewUtils {

    @Value("${image.address}")
    private String address;  // static 제거

    public Map<String, String> fetchOpenGraphData(String url) {
        Map<String, String> metaData = new HashMap<>();
        
        try {
            // 내부 Whale 링크인지 확인
            if (isInternalWhaleLink(url)) {
                // 기본 미리보기 데이터 설정
                metaData.put("url", url);
                metaData.put("title", "Whale");
                metaData.put("description", "Whale의 콘텐츠를 확인해보세요!");
                metaData.put("image", "https://storage.googleapis.com/whale_project/whale/setting/whaleLogo.png"); // 실제 이미지 URL로 변경

                return metaData;
            }
        
            Document doc = Jsoup.connect(url).get();
            metaData.put("title", doc.select("meta[property=og:title]").attr("content"));
            metaData.put("description", doc.select("meta[property=og:description]").attr("content"));
            metaData.put("image", doc.select("meta[property=og:image]").attr("content"));
            metaData.put("url", url);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return metaData;
    }
        
    private boolean isInternalWhaleLink(String url) {
        // Whale 애플리케이션의 도메인으로 변경하세요
        String whaleDomain = address;

        return url != null && url.startsWith(whaleDomain);
    }
    
    public String fetchYouTubeEmbedHtml(String url) {
        String oEmbedUrl = "https://www.youtube.com/oembed?url=" + url + "&format=json";
        try {
            Document doc = Jsoup.connect(oEmbedUrl).ignoreContentType(true).get();
            String embedHtml = doc.select("html").text();
            return embedHtml;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}