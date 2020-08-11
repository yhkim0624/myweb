package com.huation.myweb.service;

import java.util.List;

import com.huation.myweb.vo.ChartVO;

public interface ChartService {

	List<ChartVO> findNBoardCountByRegDate();
	
}
