package com.tech.whale.streaming.controller;

import com.tech.whale.streaming.service.LyricsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LyricsController {

    @Autowired
    private LyricsService lyricsService;

    @GetMapping("/lyrics")
    public String showLyrics(@RequestParam("artist") String artist, @RequestParam("title") String title, Model model) {
        String lyrics = lyricsService.getLyrics(artist, title);
        model.addAttribute("lyrics", lyrics);
        return "lyricsView";  // 가사를 표시할 JSP 또는 HTML 페이지 이름
    }
}
