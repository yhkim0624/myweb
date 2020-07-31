package com.huation.myweb.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Qualifier;

import com.huation.myweb.vo.MemberVO;

@Mapper
@Qualifier("memberMapper")
public interface MemberMapper {

	void insertMember(MemberVO member);

	MemberVO selectMemberByIdAndPasswd(MemberVO member);

}
