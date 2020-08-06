package com.huation.myweb.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.huation.myweb.mapper.ABoardMapper;
import com.huation.myweb.vo.ABoardVO;

@Service
@Qualifier("aBoardService")
public class ABoardServiceImpl implements ABoardService {

	@Autowired
	@Qualifier("aBoardMapper")
	private ABoardMapper aBoardMapper;

	@Override
	public int findABoardCount() {
		
		return aBoardMapper.selectABoardCount();
	}

	@Override
	public List<ABoardVO> findNBoardWithPaging(HashMap<String, Object> params) {
		
		return aBoardMapper.selectABoardWithPaging(params);
	}

	@Override
	public void writeABoard(ABoardVO aBoard) {
		
		aBoardMapper.insertABoard(aBoard);
	}	

}
