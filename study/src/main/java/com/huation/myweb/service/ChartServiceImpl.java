package com.huation.myweb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.huation.myweb.mapper.ChartMapper;
import com.huation.myweb.vo.ChartVO;

@Service
@Qualifier("chartService")
public class ChartServiceImpl implements ChartService {

	@Autowired
	@Qualifier("chartMapper")
	private ChartMapper chartMapper;

	@Override
	public List<ChartVO> findNBoardCountByRegDate() {
		
		return chartMapper.selectCountNBoardByRegDate();
	}
	
}
