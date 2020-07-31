package com.huation.myweb.vo;

import lombok.Data;

@Data
public class UploadFileVO {

	private int uploadFileNo;
	private int boardNo;
	private String savedFileName;
	private String userFileName;
	private int downloadCount;
	
}
