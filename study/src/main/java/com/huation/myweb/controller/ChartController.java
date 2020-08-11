package com.huation.myweb.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huation.myweb.service.ChartService;
import com.huation.myweb.vo.ChartVO;

@Controller
@RequestMapping(path = { "/chart" })
public class ChartController {
	
	@Autowired
	@Qualifier("chartService")
	private ChartService chartService;
	
	@GetMapping
	public String showChartPage() {
		
		return "chart/chart";
	}
	
	@GetMapping(path = { "/count" })
	@ResponseBody
	public List<ChartVO> findNBoardCount() {
		
		return chartService.findNBoardCountByRegDate();
	}
	
}
