package com.Init.service;

import com.Init.domain.*;
import com.Init.persistence.MemberDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

    @Autowired
    private MemberDAO mdao;
    
    private static final String UPLOAD_DIR = "/path/to/upload/directory/";

    @Override
    @Transactional
    public void memberJoin(MemberVO vo) {
        logger.debug("회원가입 서비스 실행: {}", vo);
        mdao.insertMember(vo);
    }

    @Override
    public MemberVO memberLoginCheck(MemberVO vo) {
        logger.debug("로그인 체크 서비스 실행: {}", vo);
        return mdao.loginMember(vo);
    }

    @Override
    public MemberVO memberInfo(String emp_id) {
        logger.debug("회원 정보 조회 서비스 실행: {}", emp_id);
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
    
	@Override
    public void updateProfilePicture(String emp_id, String emp_profile) {
        mdao.updateProfilePicture(emp_id, emp_profile);
    }
    
    @Override
    public void updateAccountInfo(MemberVO memberVO) throws Exception {
        mdao.updateAccount(memberVO);
    }
    
    // 회원 목록 조회
    @Override
    public List<MemberVO> getPaginatedMembers(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return mdao.getPaginatedMembers(offset, pageSize);
    }

    @Override
    public int getTotalMembersCount() {
        return mdao.getTotalMembersCount();
    }

    @Override
    public MemberVO getMemberDetail(String emp_id) {
        return mdao.getMemberDetail(emp_id);
    }
}
