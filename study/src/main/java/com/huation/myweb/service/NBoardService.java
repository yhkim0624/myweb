package com.huation.myweb.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import com.huation.myweb.vo.NBoardCommentVO;
import com.huation.myweb.vo.NBoardVO;
import com.huation.myweb.vo.UploadFileVO;

public interface NBoardService {

	int writeNBoard(NBoardVO nBoard);

	NBoardVO showNBoardDetail(int nBoardNo);

	void deleteNBoard(int nBoardNo);

	void updateNBoard(NBoardVO nBoard);

	void uploadFile(UploadFileVO uploadFile);

	UploadFileVO findUploadFileByFileNo(int fileNo);

	List<NBoardVO> findNBoardWithPaging(HashMap<String, Object> params);

	int findNBoardCount(HashMap<String, Object> params);

	int rewriteNBoard(NBoardVO nBoard, int prNBoardNo);

	int writeReply(NBoardCommentVO comment);

	void deleteReply(int commentNo);

	NBoardCommentVO showReplyDetail(int rno);

	void modifyReply(NBoardCommentVO comment);

	int writeReReply(int prCommentNo, NBoardCommentVO comment);

	void excelUpload(File file);

	void deleteFileByUploadFileNo(int fileNo);

	UploadFileVO showLastUploadFile(int nBoardNo);

	List<NBoardVO> findNBoardAll();
	
}
