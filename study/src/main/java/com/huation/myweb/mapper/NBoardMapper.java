package com.huation.myweb.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Qualifier;

import com.huation.myweb.vo.NBoardVO;
import com.huation.myweb.vo.UploadFileVO;

@Mapper
@Qualifier("nBoardMapper")
public interface NBoardMapper {

	void insertNBoard(NBoardVO nBoard);

//	List<NBoardVO> selectNBoards();
	
	List<NBoardVO> selectNBoardWithPaging(HashMap<String, Object> params);

	NBoardVO selectNBoardByNBoardNo(int nBoardNo);

	void deleteNBoardByNBoardNo(int nBoardNo);

	void updateNBoardByNBoardNo(NBoardVO nBoard);

	void updateNBoardReadCount(int boardNo);

	void insertUploadFile(UploadFileVO uploadFile);

	UploadFileVO selectUploadFileByFileNo(int fileNo);

	int selectNBoardCount(HashMap<String, Object> params);

}
