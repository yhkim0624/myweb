package com.huation.myweb.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.huation.myweb.common.ThePager2;
import com.huation.myweb.common.Util;
import com.huation.myweb.service.NBoardService;
import com.huation.myweb.vo.NBoardVO;
import com.huation.myweb.vo.UploadFileVO;

@Controller
@RequestMapping(path = { "/nboard" })
public class NBoardController {
	
	@Autowired
	@Qualifier("nBoardService")
	private NBoardService nBoardService;
	
//	@GetMapping(path = { "/list" })
//	public String showNBoardList(Model model) {
//		
//		System.out.println("NBoard List...");
//		
//		List<NBoardVO> nBoards = nBoardService.showNBoardList();
//		model.addAttribute("nBoards", nBoards);
//		
//		return "nboard/list";
//	}
	
	@GetMapping(path = { "/list" })
	public String showNBoardList(
			@RequestParam(defaultValue = "1") int pageNo,
			//RequestParam(required=false) : 요청 데이터가 없으면 null로 설정
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKey,
			HttpServletRequest req,
			Model model) { // 목록보기

		HashMap<String, Object> params = new HashMap<>();
		params.put("searchType", searchType);
		params.put("searchKey", searchKey);
		int boardCount = nBoardService.findNBoardCount(params); //전체 글 개수
		
		int pageSize = 10;
		int pagerSize = 5;
		int beginning = boardCount - (pageNo -1) * pageSize;
		int end = (boardCount - pageNo * pageSize) + 1;
		
		if (end < 1) end = 1;
		
		System.out.printf("[%d][%d][%d]", boardCount, beginning, end);
		System.out.printf("[%s][%s]", searchType, searchKey);
		
		params.put("beginning", beginning);
		params.put("end", end);
				
		//데이터 조회 (서비스에 요청)
		List<NBoardVO> boards = nBoardService.findNBoardWithPaging(params);

		ThePager2 pager = 
			new ThePager2(boardCount, pageNo, pageSize, pagerSize, 
						  "list", req.getQueryString());
		
		//Model 타입 전달인자에 데이터 저장 -> View로 전달
		//(실제로는 Request 객체에 데이터 저장)
		model.addAttribute("nBoards", boards);
		model.addAttribute("pager", pager);
		
		return "nboard/list";
	}
	
	@GetMapping(path = { "/write" })
	public String showNBoardWriteForm() {
		
		System.out.println("NBoard write...");
		return "nboard/write";
	}
	
	@PostMapping(path = { "/write" })
	public String writeNBoard(@RequestParam("attach") MultipartFile userFile, HttpServletRequest req, NBoardVO nBoard, UploadFileVO uploadFile) {
		
		System.out.println(nBoard);
		System.out.println(userFile);
		
		int newBoardNo = nBoardService.writeNBoard(nBoard);
		
		System.out.println(newBoardNo);
		
		if (!userFile.isEmpty()) {
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("resources/file/upload-files");
			String userFileName = userFile.getOriginalFilename();
			String savedFileName = Util.makeUniqueFileName(userFileName);
			
			try {
				File file = new File(path, savedFileName);
				userFile.transferTo(file);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			
			uploadFile.setBoardNo(newBoardNo);
			uploadFile.setSavedFileName(savedFileName);
			uploadFile.setUserFileName(userFileName);
			
			System.out.println(uploadFile);
			
			nBoardService.uploadFile(uploadFile);
			
		}
		
		return "redirect: /myweb/nboard/list";
	}
	
	@GetMapping(path = { "/detail" })
	public String showNBoardDetail(@RequestParam("nboardno") int nBoardNo, HttpSession session) {
		
		System.out.println("NBoard detail..." + nBoardNo);
		
		NBoardVO nBoard = nBoardService.showNBoardDetail(nBoardNo);
		
		if (nBoard == null) {
			return "redirect: /myweb/nboard/list";
		}
		
		session.setAttribute("nBoard", nBoard);
		
		return "nboard/detail";
	}
	
	@PostMapping(path = { "/delete" })
	public String deleteNBoard(@RequestParam("nBoardNo") int nBoardNo) {
		
		System.out.println("NBoard delete..." + nBoardNo);
		
		nBoardService.deleteNBoard(nBoardNo);
		
		return "redirect: /myweb/nboard/list";
	}
	
	@GetMapping(path = { "/update" })
	public String showNBoardUpdateForm(@RequestParam("nboardno") int nBoardNo) {
		
		NBoardVO nBoard = nBoardService.showNBoardDetail(nBoardNo);
		
		if (nBoard == null) {
			return "redirect: /myweb/nboard/list";
		}
		
		return "nboard/update";
	}
	
	@PostMapping(path = { "/update" })
	public String updateNBoard(NBoardVO nBoard) {
		
		System.out.println("NBoard update..." + nBoard.getBoardNo());
		System.out.println(nBoard);
		
		nBoardService.updateNBoard(nBoard);
		
		return "redirect: /myweb/nboard/list";
	}
	
	@GetMapping(path = { "/download" })
	public void downloadFile(@RequestParam("file-no") int fileNo, HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		UploadFileVO uploadFile = nBoardService.findUploadFileByFileNo(fileNo);
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/upload-files/" + uploadFile.getSavedFileName());
		resp.setContentType("application/octet-stream;charset=utf-8");
		resp.addHeader("Content-Disposition",
						"Attachment;filename=\"" + new String(uploadFile.getUserFileName().getBytes("UTF-8"), "ISO-8859-1") + "\"");
		
		FileInputStream fis = new FileInputStream(path);
		OutputStream fos = resp.getOutputStream();
		
		while (true) {
			int data = fis.read();
			if (data == -1) {
				break;
			}
			fos.write(data);
		}
		
		fis.close();
		fos.close();
	}
	
}
