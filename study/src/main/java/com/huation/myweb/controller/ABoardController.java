package com.huation.myweb.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huation.myweb.common.ThePager;
import com.huation.myweb.service.ABoardService;
import com.huation.myweb.vo.ABoardVO;

@Controller
@RequestMapping(path = { "/aboard" })
public class ABoardController {

	@Autowired
	@Qualifier("aBoardService")
	private ABoardService aBoardService;

	@GetMapping(path = { "/main" })
	public String showABoardMain(@RequestParam(defaultValue = "1") int pageNo, Model model) {

		System.out.println("Call main...");
		
		HashMap<String, Object> params = new HashMap<>();
		int boardCount = aBoardService.findABoardCount();
		
		int pageSize = 10;
		int pagerSize = 5;
		int beginning = boardCount - (pageNo - 1) * pageSize;
		int end = (boardCount - pageNo * pageSize) + 1;
		
		if (end < 1) {
			end = 1;
		}
		
		params.put("beginning", beginning);
		params.put("end", end);
		
		// 데이터 조회 (서비스에 요청)
		List<ABoardVO> boards = aBoardService.findNBoardWithPaging(params);
		
		ThePager pager = new ThePager(boardCount, pageNo, pageSize, pagerSize, "main");
		
		// Model 타입 전달인자에 데이터 저장 -> View로 전달
		// (실제로는 Request 객체에 데이터 저장)
		model.addAttribute("aBoards", boards);
		model.addAttribute("pager", pager);

		return "aboard/main";
	}
	
	@GetMapping(path = { "/list" })
	public String showABoardList(@RequestParam(defaultValue = "1") int pageNo, Model model) {

		System.out.println("Call list...");
		
		HashMap<String, Object> params = new HashMap<>();
		int boardCount = aBoardService.findABoardCount();
		
		int pageSize = 10;
		int pagerSize = 5;
		int beginning = boardCount - (pageNo - 1) * pageSize;
		int end = (boardCount - pageNo * pageSize) + 1;
		
		if (end < 1) {
			end = 1;
		}
		
		params.put("beginning", beginning);
		params.put("end", end);
		
		// 데이터 조회 (서비스에 요청)
		List<ABoardVO> boards = aBoardService.findNBoardWithPaging(params);
		
		ThePager pager = new ThePager(boardCount, pageNo, pageSize, pagerSize, "main");
		
		// Model 타입 전달인자에 데이터 저장 -> View로 전달
		// (실제로는 Request 객체에 데이터 저장)
		model.addAttribute("aBoards", boards);
		model.addAttribute("pager", pager);

		return "aboard/list";
	}

	@GetMapping(path = { "/write" })
	public String showABoardWritePopUp() {

		return "aboard/write";
	}
	
	@PostMapping(path = { "/write" })
	@ResponseBody
	public String write(ABoardVO aBoard) {
		
		aBoardService.writeABoard(aBoard);
		
		return "success";
	}

}
