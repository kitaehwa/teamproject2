package com.Init.service;

import java.util.List;

import com.Init.domain.MemberVO;


public interface MemberService {
	
	// 회원가입 동작
	public void memberJoin(MemberVO vo);
	
	// 회원로그인 체크 동작
	public MemberVO memberLoginCheck(MemberVO vo);
	
	// 회원정보 조회 및 수정
	public MemberVO memberInfo(String emp_id);
	public int memberUpdate(MemberVO uvo);
	
}
