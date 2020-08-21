package com.huation.myweb.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.huation.myweb.service.ABoardService;
import com.huation.myweb.service.NBoardService;
import com.huation.myweb.vo.ABoardVO;
import com.huation.myweb.vo.NBoardVO;

@Component
public class BoardTaskScheduler {
	
	@Autowired
	@Qualifier("nBoardService")
	private NBoardService nBoardService;
	
	@Autowired
	@Qualifier("aBoardService")
	private ABoardService aBoardService;

	@Scheduled(cron="0 0 0/1 * * *")
	public void schedulerTest() {
		
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String formatedDate = format.format(date);
		
		NBoardVO nBoardScheduled = new NBoardVO();
		nBoardScheduled.setWriter("admin");
		nBoardScheduled.setTitle("Scheduling Test");
		nBoardScheduled.setContent(formatedDate);
		nBoardService.writeNBoard(nBoardScheduled);
		
		ABoardVO aBoardScheduled = new ABoardVO();
		aBoardScheduled.setWriter("admin");
		aBoardScheduled.setTitle("Scheduling Test");
		aBoardScheduled.setContent(formatedDate);
		aBoardService.writeABoard(aBoardScheduled);
		
		System.out.println("Scheduling Start ...");
	}
	
}
