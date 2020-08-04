package com.huation.myweb.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

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

//	@Override
//	public List<NBoardVO> showNBoardList() {
//		
//		return nBoardMapper.selectNBoards();
//	}

	@Override
	public NBoardVO showNBoardDetail(int nBoardNo) {
		
		NBoardVO nBoard = nBoardMapper.selectNBoardByNBoardNo(nBoardNo);
		
		if (nBoard != null) {
			nBoardMapper.updateNBoardReadCount(nBoard.getBoardNo());
		}
		
		return nBoard;
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
		
		return nBoardMapper.selectNBoardWithPaging(params);
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
	
}
