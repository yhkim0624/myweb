package com.huation.myweb.service;

import java.util.HashMap;
import java.util.List;

import com.huation.myweb.vo.ABoardCommentVO;
import com.huation.myweb.vo.ABoardVO;

public interface ABoardService {

	int findABoardCount();

	List<ABoardVO> findABoardWithPaging(HashMap<String, Object> params);

	void writeABoard(ABoardVO aBoard);

	ABoardVO showABoardDetail(int aBoardNo);

	void updateABoard(ABoardVO aBoard);

	void deleteABoard(int boardNo);

	void rewriteABoard(ABoardVO aBoard, int prABoardNo);

	void writeReply(ABoardCommentVO comment);

	List<ABoardCommentVO> getCommentListByBno(int aBoardNo);

	void updateABoardComment(ABoardCommentVO comment);

	void writeReReply(ABoardCommentVO comment, int prCommentNo);

	void deleteABoardComment(int rno);
	
}
