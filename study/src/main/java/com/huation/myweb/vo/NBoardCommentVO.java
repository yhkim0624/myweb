package com.huation.myweb.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NBoardCommentVO {

	private int commentNo;
	private int boardNo;
	private String writer;
	private String content;
	private Date regDate;
	private int groupNo;
	private int stepNo;
	private int depth;
	
}
