package com.huation.myweb.service;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.huation.myweb.common.Util;
import com.huation.myweb.mapper.MemberMapper;
import com.huation.myweb.vo.MemberVO;

import lombok.Setter;

@Service
@Qualifier("memberService")
public class MemberServiceImpl implements MemberService {

	@Setter
	private MemberMapper memberMapper;

	@Override
	public void registerMember(MemberVO member) {
		
		// 비밀번호 암호화 추가
		String plainPasswd = member.getPasswd();
		String hashedPasswd = Util.getHashedString(plainPasswd, "SHA-256");
		member.setPasswd(hashedPasswd);
		
		System.out.println(member);
		memberMapper.insertMember(member);
		
	}

	@Override
	public MemberVO loginMember(MemberVO member) {
		
		// 비밀번호 암호화 추가
		String plainPasswd = member.getPasswd();
		String hashedPasswd = Util.getHashedString(plainPasswd, "SHA-256");
		member.setPasswd(hashedPasswd);
		
		MemberVO member2 = memberMapper.selectMemberByIdAndPasswd(member);
		
		return member2;
	}
	
	
	
}
