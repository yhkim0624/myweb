package com.huation.myweb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Qualifier;

import com.huation.myweb.vo.ChartVO;

@Mapper
@Qualifier("chartMapper")
public interface ChartMapper {

	List<ChartVO> selectCountNBoardByRegDate();

}
