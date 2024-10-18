package com.tech.whale.message.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MessageController {
	@RequestMapping("/message/home")
    public String settingHome(HttpServletRequest request, HttpSession session, Model model) {
        return "message/messageHome";
    }
}
