package com.huation.myweb.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huation.myweb.common.ThePager;
import com.huation.myweb.service.ABoardService;
import com.huation.myweb.vo.ABoardCommentVO;
import com.huation.myweb.vo.ABoardVO;

@Controller
@RequestMapping(path = { "/aboard" })
public class ABoardController {

	@Autowired
	@Qualifier("aBoardService")
	private ABoardService aBoardService;

	@GetMapping(path = { "/main" })
	public String showABoardMain(@RequestParam(defaultValue = "1") int pageNo, Model model) {

		System.out.println("Call main... pageNo=" + pageNo);

		HashMap<String, Object> params = new HashMap<>();
		int boardCount = aBoardService.findABoardCount();

		int pageSize = 5;
		int pagerSize = 5;
		int beginning = boardCount - (pageNo - 1) * pageSize;
		int end = (boardCount - pageNo * pageSize) + 1;

		if (end < 1) {
			end = 1;
		}

		System.out.printf("beginning: %d, end: %d\n", beginning, end);
		params.put("beginning", beginning);
		params.put("end", end);

		// 데이터 조회 (서비스에 요청)
		List<ABoardVO> boards = aBoardService.findABoardWithPaging(params);

		ThePager pager = new ThePager(boardCount, pageNo, pageSize, pagerSize, "main");

		// Model 타입 전달인자에 데이터 저장 -> View로 전달
		// (실제로는 Request 객체에 데이터 저장)
		model.addAttribute("aBoards", boards);
		model.addAttribute("pager", pager);

		return "aboard/main";
	}

	@GetMapping(path = { "/list" })
	public String showABoardList(@RequestParam(defaultValue = "1") int pageNo, Model model, HttpSession session) {

		System.out.println("Call list...");

		HashMap<String, Object> params = new HashMap<>();
		int boardCount = aBoardService.findABoardCount();

		int pageSize = 5;
		int pagerSize = 5;
		int beginning = boardCount - (pageNo - 1) * pageSize;
		int end = (boardCount - pageNo * pageSize) + 1;

		if (end < 1) {
			end = 1;
		}

		params.put("beginning", beginning);
		params.put("end", end);

		// 데이터 조회 (서비스에 요청)
		List<ABoardVO> boards = aBoardService.findABoardWithPaging(params);

		ThePager pager = new ThePager(boardCount, pageNo, pageSize, pagerSize, "main");

		// Model 타입 전달인자에 데이터 저장 -> View로 전달
		// (실제로는 Request 객체에 데이터 저장)
		model.addAttribute("aBoards", boards);
		model.addAttribute("pager", pager);
		System.out.println(pageNo);
		session.setAttribute("pageNo", pageNo);

		return "aboard/list";
	}

	@GetMapping
	public String showABoardWritePopUp(@RequestParam("type") String type, HttpSession session,
			@RequestParam(value = "aboardno", defaultValue = "0") int aBoardNo,
			@RequestParam(value = "stepno", defaultValue = "0") int stepNo) {

		switch (type) {
		case "write":
			System.out.println("ABoard write...");
			return "aboard/write";
		case "rewrite":
			System.out.println("ABoard rewrite...");
			session.setAttribute("aBoardNo", aBoardNo);
			session.setAttribute("stepNo", stepNo);
			return "aboard/rewrite";
		default:
			return "redirect: /myweb/";
		}
	}

	@PostMapping
	@ResponseBody
	public String write(@RequestParam("type") String type,
			@RequestParam(value = "prABoardNo", defaultValue = "0") int prABoardNo, ABoardVO aBoard) {

		switch (type) {
		case "write":
			aBoardService.writeABoard(aBoard);
			break;
		case "rewrite":
			if (prABoardNo == 0) {
				return "redirect: /myweb/aboard/main";
			}
			aBoardService.rewriteABoard(aBoard, prABoardNo);
			break;
		default:
			return "fail";
		}

		return "success";
	}

	@GetMapping(path = { "/{bno}" })
	public String showABoardDetail(@PathVariable int bno, HttpSession session) {

		System.out.println("ABoard detail..." + bno);

		ABoardVO aBoard = aBoardService.showABoardDetail(bno);

		if (aBoard == null) {
			return "redirect: /myweb/aboard/main";
		}

		System.out.println(aBoard.getABoardComments());

		session.setAttribute("aBoard", aBoard);
		session.setAttribute("comments", aBoard.getABoardComments());

		return "aboard/detail";
	}

	@GetMapping(path = { "/update" })
	public String showABoardUpdateForm(@RequestParam("aboardno") int aBoardNo, HttpSession session) {

		ABoardVO aBoard = aBoardService.showABoardDetail(aBoardNo);

		if (aBoard == null) {
			return "redirect: /myweb/aboard/main";
		}

		session.setAttribute("aBoard", aBoard);

		return "aboard/update";
	}

	@PutMapping(path = { "/{boardNo}" }, consumes = "application/json")
	@ResponseBody
	public String updateABoard(@PathVariable int boardNo, @RequestBody ABoardVO aBoard) {

		aBoard.setBoardNo(boardNo);
		System.out.println("ABoard update..." + aBoard.getBoardNo());
		System.out.println(aBoard);

		aBoardService.updateABoard(aBoard);

		return "success";
	}

	@DeleteMapping(path = { "/{bno}" })
	@ResponseBody
	public String deleteABoard(@PathVariable int bno) {

		System.out.println("ABoard delete..." + bno);

		aBoardService.deleteABoard(bno);

		return "success";
	}

	@GetMapping(path = { "/reply-list/{aBoardNo}" })
	public String showReplies(@PathVariable int aBoardNo, Model model) {

		System.out.println("call reply-list..." + aBoardNo);

		List<ABoardCommentVO> replies = aBoardService.getCommentListByBno(aBoardNo);
		model.addAttribute("replies", replies);

		return "aboard/reply-list";
	}

	@PostMapping(path = { "/reply" })
	@ResponseBody
	public String writeReply(@RequestParam("type") String type,
			@RequestParam(value = "prCommentNo", defaultValue = "0") int prCommentNo, ABoardCommentVO comment) {

		if (comment.getReplier() == null) {
			return "fail";
		} else {
			switch (type) {
			case "reply":
				System.out.println("ABoardComment reply...");
				aBoardService.writeReply(comment);
				break;
			case "rereply":
				if (prCommentNo == 0) {
					return "fail";
				}
				aBoardService.writeReReply(comment, prCommentNo);
				break;
			default:
				return "fail";
			}

			return "success";
		}
	}

	@PutMapping(path = { "/reply/{rno}" }, consumes = "application/json")
	@ResponseBody
	public String updateABoardComment(@PathVariable("rno") int commentNo, @RequestBody ABoardCommentVO comment) {

		comment.setCommentNo(commentNo);
		System.out.println("ABoardComment update..." + comment.getCommentNo());
		System.out.println(comment);

		aBoardService.updateABoardComment(comment);

		return "success";
	}
	
	@DeleteMapping(path = { "/reply/{rno}" })
	@ResponseBody
	public String deleteABoardComment(@PathVariable int rno) {

		System.out.println("ABoardComment delete..." + rno);

		aBoardService.deleteABoardComment(rno);

		return "success";
	}

}
