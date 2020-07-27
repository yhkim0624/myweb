package com.huation.myweb.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.huation.myweb.vo.MemberVO;

@Mapper
public interface MemberMapper {

	void insertMember(MemberVO member);

	MemberVO selectMemberByIdAndPasswd(MemberVO member);

}
