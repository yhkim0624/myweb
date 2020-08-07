package com.huation.myweb.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Qualifier;

import com.huation.myweb.vo.ABoardVO;

@Mapper
@Qualifier("aBoardMapper")
public interface ABoardMapper {

	List<ABoardVO> selectABoardWithPaging(HashMap<String, Object> params);

	int selectABoardCount();

	void insertABoard(ABoardVO aBoard);

	ABoardVO selectABoardByABoardNo(int aBoardNo);

	void updateABoardReadCount(int boardNo);

	void updateABoardByABoardNo(ABoardVO aBoard);

}
