package com.huation.myweb.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Qualifier;

import com.huation.myweb.vo.ABoardCommentVO;
import com.huation.myweb.vo.ABoardVO;

@Mapper
@Qualifier("aBoardMapper")
public interface ABoardMapper {

	List<ABoardVO> selectABoardWithPaging(HashMap<String, Object> params);

	int selectABoardCount(HashMap<String, Object> params);

	void insertABoard(ABoardVO aBoard);

	ABoardVO selectABoardByABoardNo(int aBoardNo);

	void updateABoardReadCount(int boardNo);

	void updateABoardByABoardNo(ABoardVO aBoard);

	void deleteABoardByABoardNo(int boardNo);

	void updateSno(ABoardVO prABoard);

	void insertReABoard(ABoardVO aBoard);

	void insertABoardComment(ABoardCommentVO comment);

	List<ABoardCommentVO> selectABoardCommentsByBoardNo(int aBoardNo);

	void updateABoardComment(ABoardCommentVO comment);

	ABoardCommentVO selectABoardCommentByCommentNo(int prCommentNo);

	void updateCommentSno(ABoardCommentVO prComment);

	void insertABoardReComment(ABoardCommentVO comment);

	void deleteComment(int commentNo);

}
