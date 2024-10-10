package com.Init.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;
import com.Init.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO mdao;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Override
	public void memberJoin(MemberVO vo) {
		logger.debug(" 컨트롤러 -> 서비스 호출");
		logger.debug(" 회원가입 메서드 memberJoin(MemberVO vo) 실행");
		logger.debug(" 서비스에서 -> DAO ");
		
		mdao.insertMember(vo);
		
		logger.debug(" DAO -> 서비스");
		logger.debug(" 서비스 -> 컨트롤러");
	}
	
	@Override
	public MemberVO memberLoginCheck(MemberVO vo) {
		logger.debug("컨트롤러가 호출 -> DAO 호출");
		return mdao.loginMember(vo);
	}
	
	@Override
	public MemberVO memberInfo(String emp_id) {
		logger.debug("memberInfo(String emp_id) 실행");
		return mdao.getMember(emp_id);
	}

	@Override
	public int memberUpdate(MemberVO uvo) {
		logger.debug("memberUpdate(MemberVO uvo) 실행");
		// 회원정보 수정
		int result = mdao.updateMember(uvo);
		// 회원정보 수정 이력
		mdao.insertHisMember(uvo);
		
		return result;
	}

	@Override
	public AccountVO getAccount(String emp_id) {
		
		return mdao.getAccount(emp_id);
	}

	@Override
	public List<LicenseVO> getLicense(String emp_id) {
		
		return mdao.getLicense(emp_id);
	}

	@Override
	public List<His_eduVO> getHis_edu(String emp_id) {
		
		return mdao.getHis_edu(emp_id);
	}

	@Override
	public List<RewardVO> getReward(String emp_id) {
		
		return mdao.getReward(emp_id);
	}

	@Override
	public List<EvalVO> getEval(String emp_id) {
		
		return mdao.getEval(emp_id);
	}
	
	
}
