package com.huation.myweb.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.huation.myweb.mapper.ABoardMapper;
import com.huation.myweb.vo.ABoardCommentVO;
import com.huation.myweb.vo.ABoardVO;

@Service
@Qualifier("aBoardService")
public class ABoardServiceImpl implements ABoardService {

	@Autowired
	@Qualifier("aBoardMapper")
	private ABoardMapper aBoardMapper;

	@Override
	public int findABoardCount(HashMap<String, Object> params) {
		
		return aBoardMapper.selectABoardCount(params);
	}

	@Override
	public List<ABoardVO> findABoardWithPaging(HashMap<String, Object> params) {
		
		return aBoardMapper.selectABoardWithPaging(params);
	}

	@Override
	public void writeABoard(ABoardVO aBoard) {
		
		aBoardMapper.insertABoard(aBoard);
	}

	@Override
	public ABoardVO showABoardDetail(int aBoardNo) {
		
		ABoardVO aBoard = aBoardMapper.selectABoardByABoardNo(aBoardNo);

		if (aBoard != null) {
			aBoardMapper.updateABoardReadCount(aBoard.getBoardNo());
		}

		return aBoard;
	}

	@Override
	public void updateABoard(ABoardVO aBoard) {
		
		aBoardMapper.updateABoardByABoardNo(aBoard);
	}

	@Override
	public void deleteABoard(int boardNo) {
		
		aBoardMapper.deleteABoardByABoardNo(boardNo);
	}

	@Override
	public void rewriteABoard(ABoardVO aBoard, int prABoardNo) {
		
		ABoardVO prABoard = aBoardMapper.selectABoardByABoardNo(prABoardNo);

		for (int i = 0; i < aBoard.getStepNo(); i++) {
			aBoard.setTitle("RE : " + aBoard.getTitle());
		}

		aBoard.setTitle("└" + aBoard.getTitle());

		aBoard.setGroupNo(prABoard.getGroupNo());
		aBoard.setStepNo(prABoard.getStepNo() + 1);
		aBoard.setDepth(prABoard.getDepth() + 1);

		aBoardMapper.updateSno(prABoard);

		aBoardMapper.insertReABoard(aBoard);
	}

	@Override
	public void writeReply(ABoardCommentVO comment) {
		
		aBoardMapper.insertABoardComment(comment);
	}

	@Override
	public List<ABoardCommentVO> getCommentListByBno(int aBoardNo) {
		
		return aBoardMapper.selectABoardCommentsByBoardNo(aBoardNo);
	}

	@Override
	public void updateABoardComment(ABoardCommentVO comment) {
		
		aBoardMapper.updateABoardComment(comment);
	}

	@Override
	public void writeReReply(ABoardCommentVO comment, int prCommentNo) {
		
		ABoardCommentVO prComment = aBoardMapper.selectABoardCommentByCommentNo(prCommentNo);

		comment.setBoardNo(prComment.getBoardNo());
		comment.setReplyGno(prComment.getReplyGno());
		comment.setReplySno(prComment.getReplySno() + 1);
		comment.setReplyDepth(prComment.getReplyDepth() + 1);

		aBoardMapper.updateCommentSno(prComment);

		aBoardMapper.insertABoardReComment(comment);
	}

	@Override
	public void deleteABoardComment(int commentNo) {
		
		aBoardMapper.deleteComment(commentNo);
	}	

}
