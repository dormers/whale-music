package com.tech.whale.streaming.service;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class LyricsService {

    private final RestTemplate restTemplate = new RestTemplate();

    public String getLyrics(String artistName, String songTitle) {
        try {
            String apiUrl = "https://api.lyrics.ovh/v1/" + artistName + "/" + songTitle;
            ResponseEntity<String> response = restTemplate.getForEntity(apiUrl, String.class);

            // JSON 파싱하여 "lyrics" 필드만 추출
            return parseLyrics(response.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return "가사를 불러오는 중 오류가 발생했습니다.";
        }
    }

    private String parseLyrics(String response) {
        // JSON 데이터를 "lyrics" 필드에서 가져옴
        if (response != null && response.contains("\"lyrics\":")) {
            int startIndex = response.indexOf("\"lyrics\":\"") + 10;
            int endIndex = response.indexOf("\"", startIndex);
            return response.substring(startIndex, endIndex).replace("\\n", "\n");
        }
        return "가사를 찾을 수 없습니다.";
    }
}
