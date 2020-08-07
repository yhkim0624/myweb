package com.huation.myweb.vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ABoardVO {

	private int boardNo;
	private String title;
	private String writer;
	private String content;
	private Date regDate;
	private int readCount;
	private boolean deleted;
	private int groupNo;
	private int stepNo;
	private int depth;
	
	private List<ABoardCommentVO> aBoardComments;
	
}
