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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    
    // 조직도
    @Override
    public List<Map<String, Object>> getOrgChartData(String emp_bnum) {
        List<MemberVO> members = mdao.getAllMembers();
        List<Map<String, Object>> orgChartData = new ArrayList<>();
        
        // 지정된 지부의 사원만 필터링
        members = members.stream()
            .filter(m -> emp_bnum.equals(m.getEmp_bnum()))
            .collect(Collectors.toList());
        
        // 본부장 노드 추가 (최상위 계층)
        MemberVO headManager = members.stream()
            .filter(m -> "본부장".equals(m.getEmp_job()))
            .findFirst()
            .orElse(null);

        if (headManager != null) {
            Map<String, Object> headManagerNode = new HashMap<>();
            headManagerNode.put("id", headManager.getEmp_id());
            headManagerNode.put("name", headManager.getEmp_name());
            headManagerNode.put("title", headManager.getEmp_job());
            headManagerNode.put("pid", null);
            orgChartData.add(headManagerNode);
        }

        // 부서 노드와 부서장 노드 추가
        String[] departments = {"인사부", "개발부", "영업부", "마케팅부", "재무부"};
        for (String dept : departments) {
            Map<String, Object> deptNode = new HashMap<>();
            deptNode.put("id", dept);
            deptNode.put("name", dept);
            deptNode.put("title", dept);
            deptNode.put("pid", headManager != null ? headManager.getEmp_id() : null);
            orgChartData.add(deptNode);

            // 해당 부서의 부서장 찾기
            MemberVO deptManager = members.stream()
                .filter(m -> m.getEmp_dnum().equals(dept) && "부서장".equals(m.getEmp_job()))
                .findFirst()
                .orElse(null);

            if (deptManager != null) {
                Map<String, Object> managerNode = new HashMap<>();
                managerNode.put("id", deptManager.getEmp_id());
                managerNode.put("name", deptManager.getEmp_name());
                managerNode.put("title", deptManager.getEmp_job());
                managerNode.put("pid", dept);
                orgChartData.add(managerNode);
            }
        }

        return orgChartData;
    }
    
    @Override
    public List<MemberVO> getTeamMembers(String emp_dnum) {
        logger.info("Getting team members for department: {}", emp_dnum);
        List<MemberVO> allMembers = mdao.getTeamMembers(emp_dnum);
        logger.info("Total members found: {}", allMembers.size());
        List<MemberVO> filteredMembers = allMembers.stream()
                         .filter(m -> !"부서장".equals(m.getEmp_job()))
                         .collect(Collectors.toList());
        logger.info("Filtered members (excluding 부서장): {}", filteredMembers.size());
        return filteredMembers;
    }
    
    @Override
    public List<String> getBranchList() {
        return mdao.getBranchList();
    }
    
    
    
}
