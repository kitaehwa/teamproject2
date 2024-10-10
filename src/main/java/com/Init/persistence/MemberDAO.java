package com.Init.persistence;

import java.util.List;

import com.Init.domain.MemberVO;

public interface MemberDAO {

	// 회원가입
	public void insertMember(MemberVO vo);
	
	// 로그인
	public MemberVO loginMember(String emp_id,String emp_pw);
	public MemberVO loginMember(MemberVO vo);
	
	// 사용자 정보조회
	public MemberVO getMember(String emp_id);
	// 정보수정
	public int updateMember(MemberVO uvo);
	// 정보수정 이력
	void insertHisMember(MemberVO uvo);
	
}
