package com.Init.service;

import java.util.List;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;


public interface MemberService {
	
	// 회원가입 동작
	public void memberJoin(MemberVO vo);
	
	// 회원로그인 체크 동작
	public MemberVO memberLoginCheck(MemberVO vo);
	
	// 회원정보 조회 및 수정
	public MemberVO memberInfo(String emp_id);
	public int memberUpdate(MemberVO uvo);
	
	// 계좌 정보 가져오기
    AccountVO getAccount(String emp_id);

    // 자격증 정보 가져오기
    List<LicenseVO> getLicense(String emp_id);

    // 교육이력 정보 가져오기
    List<His_eduVO> getHis_edu(String emp_id);

    // 포상/징계 정보 가져오기
    List<RewardVO> getReward(String emp_id);

    // 인사평가 정보 가져오기
    List<EvalVO> getEval(String emp_id);
	
}
