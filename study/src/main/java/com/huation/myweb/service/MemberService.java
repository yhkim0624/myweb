package com.huation.myweb.service;

import com.huation.myweb.vo.MemberVO;

public interface MemberService {

	void registerMember(MemberVO member);

	MemberVO loginMember(MemberVO member);
	
}
