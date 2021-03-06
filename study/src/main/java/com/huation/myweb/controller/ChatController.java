package com.huation.myweb.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = { "/chat" })
public class ChatController {
	
	@GetMapping
	public String showChatPage(HttpSession session) {
		
		if (session.getAttribute("loginuser") == null) {
			return "redirect: /myweb/login";
		} else {
			return "chat/chat";
		}
	}
	
}
