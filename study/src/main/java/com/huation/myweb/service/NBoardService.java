package com.huation.myweb.service;

import java.util.HashMap;
import java.util.List;

import com.huation.myweb.vo.NBoardVO;
import com.huation.myweb.vo.UploadFileVO;

public interface NBoardService {

	int writeNBoard(NBoardVO nBoard);

//	List<NBoardVO> showNBoardList();

	NBoardVO showNBoardDetail(int nBoardNo);

	void deleteNBoard(int nBoardNo);

	void updateNBoard(NBoardVO nBoard);

	void uploadFile(UploadFileVO uploadFile);

	UploadFileVO findUploadFileByFileNo(int fileNo);

	List<NBoardVO> findNBoardWithPaging(HashMap<String, Object> params);

	int findNBoardCount(HashMap<String, Object> params);
	
}
