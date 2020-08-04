package com.huation.myweb.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NBoardCommentVO {

	private int commentNo;
	private int boardNo;
	private String replier;
	private String reply;
	private Date replyDate;
	private int replyGno;
	private int replySno;
	private int replyDepth;
	private boolean replyDeleted;
	
}
