package com.huation.myweb.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.huation.myweb.common.ExcelRead;
import com.huation.myweb.common.ExcelReadOption;
import com.huation.myweb.mapper.NBoardMapper;
import com.huation.myweb.vo.NBoardCommentVO;
import com.huation.myweb.vo.NBoardVO;
import com.huation.myweb.vo.UploadFileVO;

@Service
@Qualifier("nBoardService")
public class NBoardServiceImpl implements NBoardService {

	@Autowired
	@Qualifier("nBoardMapper")
	private NBoardMapper nBoardMapper;

	@Override
	public int writeNBoard(NBoardVO nBoard) {

		nBoardMapper.insertNBoard(nBoard);
		int newNum = nBoard.getBoardNo();

		return newNum;
	}

	@Override
	public int rewriteNBoard(NBoardVO nBoard, int prNBoardNo) {

		NBoardVO prNBoard = nBoardMapper.selectNBoardByNBoardNo(prNBoardNo);

		for (int i = 0; i < nBoard.getStepNo(); i++) {
			nBoard.setTitle("RE : " + nBoard.getTitle());
		}

		nBoard.setTitle("└" + nBoard.getTitle());

		nBoard.setGroupNo(prNBoard.getGroupNo());
		nBoard.setStepNo(prNBoard.getStepNo() + 1);
		nBoard.setDepth(prNBoard.getDepth() + 1);

		nBoardMapper.updateSno(prNBoard);

		nBoardMapper.insertReNBoard(nBoard);
		int newNum = nBoard.getBoardNo();

		return newNum;
	}

	@Override
	public NBoardVO showNBoardDetail(int nBoardNo) {

		NBoardVO nBoard = nBoardMapper.selectNBoardByNBoardNo(nBoardNo);

		if (nBoard != null) {
			nBoardMapper.updateNBoardReadCount(nBoard.getBoardNo());
		}

		return nBoard;
	}

	@Override
	public UploadFileVO showLastUploadFile(int nBoardNo) {
		
		ArrayList<UploadFileVO> uploadFiles = nBoardMapper.selectUploadFileByNBoardNo(nBoardNo);
		UploadFileVO uploadFile = null;
		if (!uploadFiles.isEmpty()) {
			uploadFile = uploadFiles.get(uploadFiles.size() - 1);
		}
		
		return uploadFile;
	}

	@Override
	public void deleteNBoard(int nBoardNo) {

		nBoardMapper.deleteNBoardByNBoardNo(nBoardNo);
	}

	@Override
	public void updateNBoard(NBoardVO nBoard) {

		nBoardMapper.updateNBoardByNBoardNo(nBoard);
	}

	@Override
	public void uploadFile(UploadFileVO uploadFile) {

		nBoardMapper.insertUploadFile(uploadFile);
	}

	@Override
	public UploadFileVO findUploadFileByFileNo(int fileNo) {

		return nBoardMapper.selectUploadFileByFileNo(fileNo);
	}

	@Override
	public List<NBoardVO> findNBoardWithPaging(HashMap<String, Object> params) {

		List<NBoardVO> nBoardList = nBoardMapper.selectNBoardWithPaging(params);
		
		return nBoardList;
	}

	@Override
	public int findNBoardCount(HashMap<String, Object> params) {

		return nBoardMapper.selectNBoardCount(params);
	}

	@Override
	public int writeReply(NBoardCommentVO comment) {

		int newNum = comment.getCommentNo();
		nBoardMapper.insertNBoardComment(comment);

		return newNum;
	}

	@Override
	public void deleteReply(int commentNo) {

		nBoardMapper.deleteComment(commentNo);
	}

	@Override
	public NBoardCommentVO showReplyDetail(int rno) {

		return nBoardMapper.selectNBoardCommentByCommentNo(rno);
	}

	@Override
	public void modifyReply(NBoardCommentVO comment) {

		nBoardMapper.updateNBoardComment(comment);
	}

	@Override
	public int writeReReply(int prCommentNo, NBoardCommentVO comment) {

		NBoardCommentVO prComment = nBoardMapper.selectNBoardCommentByCommentNo(prCommentNo);

		comment.setBoardNo(prComment.getBoardNo());
		comment.setReplyGno(prComment.getReplyGno());
		comment.setReplySno(prComment.getReplySno() + 1);
		comment.setReplyDepth(prComment.getReplyDepth() + 1);

		nBoardMapper.updateCommentSno(prComment);

		nBoardMapper.insertNBoardReComment(comment);
		int newNum = comment.getBoardNo();
		System.out.println(newNum);

		return newNum;
	}

	@Override
	public void excelUpload(File file) {

		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(file.getAbsolutePath());
		excelReadOption.setOutputColumns("A", "B", "C");
		excelReadOption.setStartRow(2);

		NBoardVO nBoard = new NBoardVO();

		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);

		for (Map<String, String> article : excelContent) {
			String title = article.get("A");
			String writer = article.get("B");
			String content = article.get("C");
			
			if (title != null && writer != null && content != null) {
				nBoard.setTitle(title);
				nBoard.setWriter(writer);
				nBoard.setContent(content);
				nBoardMapper.insertNBoard(nBoard);
			}			
		}

	}

	@Override
	public void deleteFileByUploadFileNo(int fileNo) {
		
		nBoardMapper.deleteUploadFileByuploadFileNo(fileNo);
	}

	@Override
	public List<NBoardVO> findNBoardAll() {
		
		return nBoardMapper.selectNBoards();
	}

}
