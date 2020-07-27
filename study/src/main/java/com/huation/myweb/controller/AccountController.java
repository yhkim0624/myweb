package com.huation.myweb.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.huation.myweb.service.MemberService;
import com.huation.myweb.vo.MemberVO;

@Controller
public class AccountController {
	
	@Autowired
	@Qualifier("memberService")
	private MemberService memberService;
	
	@GetMapping(path = { "/register" })
	public String showRegisterForm() {
		
		return "signup";
	}
	
	@GetMapping(path = { "/login" })
	public String showLoginForm() {
		
		return "signin";
	}
	
	@PostMapping(path = { "/register" })
	public String register(MemberVO member) {
		
		System.out.println(member);
		memberService.registerMember(member);
		
		return "redirect:/login";
	}
	
	@PostMapping(path = { "/login" })
	public String login(MemberVO member, HttpSession session) {
		
		System.out.println(member);
		MemberVO member2 = memberService.loginMember(member);
		System.out.println(member2);
		session.setAttribute("loginuser", member2);
		
		return "redirect:/";
	}
	
	@GetMapping(path = { "/logout" })
	public String logout(HttpSession session) {
		
		session.removeAttribute("loginuser");
		
		return "redirect:/";
	}
		
}
