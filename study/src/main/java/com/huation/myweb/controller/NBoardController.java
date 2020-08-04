package com.huation.myweb.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.huation.myweb.common.ThePager2;
import com.huation.myweb.common.Util;
import com.huation.myweb.service.NBoardService;
import com.huation.myweb.vo.NBoardCommentVO;
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
	public String showNBoardList(@RequestParam(defaultValue = "1") int pageNo,
			// RequestParam(required=false) : 요청 데이터가 없으면 null로 설정
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey,
			HttpServletRequest req, Model model) { // 목록보기

		HashMap<String, Object> params = new HashMap<>();
		params.put("searchType", searchType);
		params.put("searchKey", searchKey);
		int boardCount = nBoardService.findNBoardCount(params); // 전체 글 개수

		int pageSize = 10;
		int pagerSize = 5;
		int beginning = boardCount - (pageNo - 1) * pageSize;
		int end = (boardCount - pageNo * pageSize) + 1;

		if (end < 1)
			end = 1;

		System.out.printf("[%d][%d][%d]", boardCount, beginning, end);
		System.out.printf("[%s][%s]", searchType, searchKey);

		params.put("beginning", beginning);
		params.put("end", end);

		// 데이터 조회 (서비스에 요청)
		List<NBoardVO> boards = nBoardService.findNBoardWithPaging(params);

		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "list", req.getQueryString());

		// Model 타입 전달인자에 데이터 저장 -> View로 전달
		// (실제로는 Request 객체에 데이터 저장)
		model.addAttribute("nBoards", boards);
		model.addAttribute("pager", pager);

		return "nboard/list";
	}

	@GetMapping(path = { "/write" })
	public String showNBoardWriteForm() {

		System.out.println("NBoard write...");

		return "nboard/write";
	}

	@GetMapping(path = { "/rewrite" })
	public String showNBoardRewriteForm(@RequestParam("nboardno") int nBoardNo, @RequestParam("stepno") int stepNo,
			HttpSession session) {

		System.out.println("NBoard write...");

		session.setAttribute("nBoardNo", nBoardNo);
		session.setAttribute("stepNo", stepNo);

		return "nboard/rewrite";
	}

	@PostMapping(path = { "/write" })
	public String writeNBoard(@RequestParam("attach") MultipartFile userFile, HttpServletRequest req, NBoardVO nBoard,
			UploadFileVO uploadFile) {

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

	@PostMapping(path = { "/rewrite" })
	public String rewriteNBoard(@RequestParam("attach") MultipartFile userFile,
			@RequestParam("prNBoardNo") int prNBoardNo, HttpServletRequest req, NBoardVO nBoard,
			UploadFileVO uploadFile) {

		System.out.println(nBoard);
		System.out.println(userFile);
		System.out.println(prNBoardNo);

		if (prNBoardNo == 0)
			return "redirect: /myweb/nboard/list";

		int newBoardNo = nBoardService.rewriteNBoard(nBoard, prNBoardNo);

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

		System.out.println(nBoard.getNBoardComments());

		session.setAttribute("nBoard", nBoard);
		session.setAttribute("comments", nBoard.getNBoardComments());

		return "nboard/detail";
	}

	@PostMapping(path = { "/delete" })
	public String deleteNBoard(@RequestParam("nBoardNo") int nBoardNo) {

		System.out.println("NBoard delete..." + nBoardNo);

		nBoardService.deleteNBoard(nBoardNo);

		return "redirect: /myweb/nboard/list";
	}

	@GetMapping(path = { "/update" })
	public String showNBoardUpdateForm(@RequestParam("nboardno") int nBoardNo, HttpSession session) {

		NBoardVO nBoard = nBoardService.showNBoardDetail(nBoardNo);

		if (nBoard == null) {
			return "redirect: /myweb/nboard/list";
		}
		
		session.setAttribute("nBoard", nBoard);

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
	public void downloadFile(@RequestParam("file-no") int fileNo, HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		UploadFileVO uploadFile = nBoardService.findUploadFileByFileNo(fileNo);
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/upload-files/" + uploadFile.getSavedFileName());
		resp.setContentType("application/octet-stream;charset=utf-8");
		resp.addHeader("Content-Disposition", "Attachment;filename=\""
				+ new String(uploadFile.getUserFileName().getBytes("UTF-8"), "ISO-8859-1") + "\"");

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

	@PostMapping(path = { "/reply" })
	public String writeReply(NBoardCommentVO comment, RedirectAttributes redirect) {

		System.out.println(comment);

		if (comment.getReplier() == null) {
			return "redirect: /myweb/login";
		} else {
			nBoardService.writeReply(comment);
			redirect.addAttribute("nboardno", comment.getBoardNo());
			System.out.println(comment.getBoardNo());

			return "redirect: detail";
		}
	}

	@PostMapping(path = { "/delete-reply" })
	public String deleteReply(@RequestParam("commentNo") int commentNo, @RequestParam("boardNo") int boardNo,
			RedirectAttributes redirect) {

		nBoardService.deleteReply(commentNo);
		System.out.println(boardNo);
		redirect.addAttribute("nboardno", boardNo);

		return "redirect: detail";
	}

	@GetMapping(path = { "/modify-reply" })
	public String showReplyUpdateForm(@RequestParam("rno") int rno, HttpSession session) {

		NBoardCommentVO comment = nBoardService.showReplyDetail(rno);
		
		session.setAttribute("comment", comment);
		
		return "nboard/re-reply";
	}
	
	@PostMapping(path = { "/modify-reply" })
	public String modifyReply(NBoardCommentVO comment, RedirectAttributes redirect) {
		
		nBoardService.modifyReply(comment);
		
		redirect.addAttribute("nboardno", comment.getBoardNo());
		
		return "redirect: detail";
	}
	
	@GetMapping(path = { "/re-reply" })
	public String showReReplyForm(@RequestParam("rno") int rno, HttpSession session) {
		
		NBoardCommentVO comment = nBoardService.showReplyDetail(rno);
		
		session.removeAttribute("comment");
		session.setAttribute("commentNo", comment.getCommentNo());
		session.setAttribute("stepNo", comment.getReplySno());
		
		return "nboard/re-reply";
	}
	
	@PostMapping(path = { "/re-reply" })
	public String writeReReply(@RequestParam("prCommentNo") int prCommentNo, NBoardCommentVO comment, RedirectAttributes redirect) {
		
		if (comment.getReplier() == null) {
			return "redirect: /myweb/login";
		} else {
			nBoardService.writeReReply(prCommentNo, comment);
			redirect.addAttribute("nboardno", comment.getBoardNo());
			System.out.println(comment.getBoardNo());

			return "redirect: detail";
		}
	}
	
	@PostMapping(path = { "/excel-down" })
	public void excelDown(HttpServletRequest request, HttpServletResponse response,
	        @RequestParam(value = "title") String title, @RequestParam(value = "contents") String contents,
	        @RequestParam(value = "name") String name, @RequestParam(value = "rows") String rows,
	        @RequestParam(value = "columns") String columns) throws Exception {
	 
	    try {
	 
	        // request로 json 데이터 받기 String으로 받아 json으로 변환
	        JSONArray dataArry = new JSONArray(contents);
	        String[] myTitle = title.split(",");
	 
	        // 로우 파라미터 int로 변환
	        int myRows = Integer.parseInt(rows);
	 
	        // 컬럼 파라미터 int로 변환
	        int myColumns = Integer.parseInt(columns);
	 
	        // Workbook 생성
	        Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
	 
	        // Sheet 생성
	        Sheet sheet1 = xlsWb.createSheet(name);
	        Row row = null;
	        Cell cell = null;
	 
	        row = sheet1.createRow(0);
	 
	        // excel 파일 저장
	        for (int r = 0; r < myRows; r++) {
	 
	            // 셀 제목 설정
	            if (r == 0) {
	 
	                for (int c = 0; c < myColumns; c++) {
	 
	                    cell = row.createCell(c);
	                    cell.setCellValue(myTitle[c]);
	 
	                }
	            }
	 
	            row = sheet1.createRow(r + 1); // 두번째줄을 생성(i+1)
	 
	            for (int c = 0; c < myColumns; c++) {
	 
	                cell = row.createCell(c);
	                cell.setCellValue(dataArry.getJSONObject(r).getString(myTitle[c]));
	 
	            }
	 
	        }
	 
	        // 브라우저 별 한글 인코딩
	        String header = request.getHeader("User-Agent");
	        if (header.contains("MSIE") || header.contains("Trident")) { // IE 11버전부터 Trident로 변경되었기때문에 추가해준다.
	            name = URLEncoder.encode(name, "UTF-8").replaceAll("\\+", "%20");
	            response.setHeader("Content-Disposition", "attachment;filename=" + name + ".xls;");
	        } else if (header.contains("Chrome")) {
	            name = new String(name.getBytes("UTF-8"), "ISO-8859-1");
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\".xls");
	        } else if (header.contains("Opera")) {
	            name = new String(name.getBytes("UTF-8"), "ISO-8859-1");
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\".xls");
	        } else if (header.contains("Firefox")) {
	            name = new String(name.getBytes("UTF-8"), "ISO-8859-1");
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\".xls");
	        }
	 
	        // 엑셀 출력
	        xlsWb.write(response.getOutputStream());
	        xlsWb.close();
	        System.out.println("Excel 출력 완료");
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setHeader("Set-Cookie", "fileDownload=false; path=/");
	        System.out.println("Excel 출력 실패");
	    }
	 
	}
	
	@PostMapping(path = { "/excel-up" })
	public String excelUp(@RequestParam("excelFile") MultipartFile excelFile, HttpServletRequest req) {
		
		System.out.println("Excel File Upload...");
		
		if ( excelFile == null || excelFile.isEmpty() ) {
            return "redirect: /myweb/nboard/list";
        }
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/excel");
		String userFileName = excelFile.getOriginalFilename();
		String savedFileName = Util.makeUniqueFileName(userFileName);
		
		try {
			File file = new File(path, savedFileName);
			excelFile.transferTo(file);
			nBoardService.excelUpload(file);
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		
		return "redirect: /myweb/nboard/list";
	}


}
