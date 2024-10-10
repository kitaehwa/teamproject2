package com.Init.persistence;

import java.util.List;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;

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
