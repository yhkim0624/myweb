package com.huation.myweb.vo;

import java.util.List;

import lombok.Data;

@Data
public class NBoardVO {

	private int boardNo;
	private String title;
	private String writer;
	private String content;
	private String regDate;
	private int readCount;
	private boolean deleted;
	private int groupNo;
	private int stepNo;
	private int depth;
	
	private List<UploadFileVO> uploadFiles;
	
	private List<NBoardCommentVO> nBoardComments;
	
}
