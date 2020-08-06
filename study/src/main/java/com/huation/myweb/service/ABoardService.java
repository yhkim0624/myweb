package com.huation.myweb.service;

import java.util.HashMap;
import java.util.List;

import com.huation.myweb.vo.ABoardVO;

public interface ABoardService {

	int findABoardCount();

	List<ABoardVO> findNBoardWithPaging(HashMap<String, Object> params);

	void writeABoard(ABoardVO aBoard);
	
}
