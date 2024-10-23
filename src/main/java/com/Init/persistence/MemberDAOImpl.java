package com.Init.persistence;

import java.sql.Timestamp;
import java.time.Year;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;
import com.Init.domain.VerificationCode;



@Repository
public class MemberDAOImpl implements MemberDAO{
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.Init.mapper.MemberMapper";
	
	@Override
	public MemberVO loginMember(MemberVO vo) {
		System.out.println(" DAO : loginMember(Member VO vo) 실행");

		System.out.println(" DAO : mapper SQL 생성완료");
	
		MemberVO resultVO 
			= sqlSession.selectOne(NAMESPACE+".loginMember", vo);
		
		System.out.println(" DAO : resultVO");
		
		return resultVO;
	}
	
	@Override
	public MemberVO loginMember(String emp_id) {
	    return sqlSession.selectOne(NAMESPACE + ".getMemberById", emp_id);
	}
	// 퇴직신청
	@Override
	public int insertQuitEmployee(MemberVO memberVO) {
	    return sqlSession.insert(NAMESPACE + ".insertQuitEmployee", memberVO);
	}
	
	// 비밀번호 찾기
	@Override
    public boolean isValidEmployee(String emp_id, String emp_email) {
        Map<String, Object> params = new HashMap<>();
        params.put("emp_id", emp_id);
        params.put("emp_email", emp_email);
        return sqlSession.selectOne(NAMESPACE + ".isValidEmployee", params) != null;
    }
	
	// 인증코드
	@Override
	public VerificationCode getVerificationCode(String emp_id) {
	    List<VerificationCode> codes = sqlSession.selectList(NAMESPACE + ".getVerificationCode", emp_id);
	    if (codes.isEmpty()) {
	        return null;
	    }
	    // 가장 최근의 인증 코드를 반환
	    return codes.get(0);
	}
	
	 @Override
	    public void saveVerificationCode(String emp_id, String code, Date expiryTime) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("emp_id", emp_id);
	        params.put("code", code);
	        params.put("expiryTime", expiryTime);
	        sqlSession.insert(NAMESPACE + ".saveVerificationCode", params);
	    }
	 
	 @Override
	    public void deleteVerificationCode(String emp_id) {
	        sqlSession.delete(NAMESPACE + ".deleteVerificationCode", emp_id);
	    }

	@Override
	public boolean verifyCode(String emp_id, String verificationCode) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("emp_id", emp_id);
	    params.put("code", verificationCode);
	    params.put("currentTime", new Timestamp(System.currentTimeMillis()));
	    return sqlSession.selectOne(NAMESPACE + ".verifyCode", params) != null;
	}

	@Override
	public int resetPassword(String emp_id, String newPassword) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("emp_id", emp_id);
	    params.put("newPassword", newPassword);
	    return sqlSession.update(NAMESPACE + ".resetPassword", params);
	}
	
	
	@Override
	public MemberVO getMember(String emp_id) {
		System.out.println(" DAO : getMember(String emp_id)");
		
		return sqlSession.selectOne(NAMESPACE+".getMember",emp_id);
	}
	
	@Override
	public int updateMember(MemberVO uvo) {
		System.out.println(" DAO : updateMember(MemberVO uvo)");

		return sqlSession.update(NAMESPACE+".updateMember", uvo);
	}

	@Override
	public void insertHisMember(MemberVO uvo) {
		sqlSession.insert(NAMESPACE+".insertHisMember", uvo);
	}

	@Override
	public AccountVO getAccount(String emp_id) {
		
		return sqlSession.selectOne(NAMESPACE+".getAccount",emp_id);
	}

	@Override
	public List<LicenseVO> getEmpLicense(String emp_id) {
		
		return sqlSession.selectList(NAMESPACE+".getEmpLicense",emp_id);
	}
	
	// 자격증 추가
	@Override
    public List<Map<String, Object>> getLicenseList() {
        return sqlSession.selectList(NAMESPACE + ".getLicenseList");
    }

    @Override
    public void addLicense(LicenseVO licenseVO) {
        sqlSession.insert(NAMESPACE + ".addLicense", licenseVO);
    }

    @Override
    public void deleteLicense(String licenseId, String emp_id) {
        Map<String, Object> params = new HashMap<>();
        params.put("licenseId", licenseId);
        params.put("emp_id", emp_id);
        sqlSession.delete(NAMESPACE + ".deleteLicense", params);
    }

	@Override
	public List<His_eduVO> getHis_edu(String emp_id) {
		
		return sqlSession.selectList(NAMESPACE+".getHis_edu",emp_id);
	}

	@Override
	public List<RewardVO> getReward(String emp_id) {
		
		return sqlSession.selectList(NAMESPACE+".getReward",emp_id);
	}

	@Override
	public List<EvalVO> getEval(String emp_id) {
		
		return sqlSession.selectList(NAMESPACE+".getEval",emp_id);
	}
	
	@Override
	public void updateProfilePicture(String emp_id, String emp_profile) {
	    sqlSession.update(NAMESPACE+".updateProfilePicture", new MemberVO(emp_id, emp_profile));
	}

    @Override
    public void updateAccount(MemberVO memberVO) throws Exception {
        sqlSession.update(NAMESPACE + ".updateAccount", memberVO);
    }
    
    // 회원 목록 조회
    @Override
    public List<MemberVO> getPaginatedMembers(int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return sqlSession.selectList(NAMESPACE + ".getPaginatedMembers", params);
    }

    @Override
    public int getTotalMembersCount() {
        return sqlSession.selectOne(NAMESPACE + ".getTotalMembersCount");
    }

    @Override
    public MemberVO getMemberDetail(String emp_id) {
        return sqlSession.selectOne(NAMESPACE + ".getMemberDetail", emp_id);
    }
    
    // 조직도
    @Override
    public List<MemberVO> getAllMembers() {
        return sqlSession.selectList(NAMESPACE + ".getAllMembers");
    }
    
    @Override
    public List<MemberVO> getTeamMembers(String emp_dnum) {
        return sqlSession.selectList(NAMESPACE + ".getTeamMembers", emp_dnum);
    }
    
    @Override
    public List<String> getBranchList() {
        return sqlSession.selectList(NAMESPACE + ".getBranchList");
    }
    
    // 필터 부분
    @Override
    public List<String> getFilterOptions(String filterType) {
        return sqlSession.selectList(NAMESPACE + ".getFilterOptions", filterType);
    }

    @Override
    public List<MemberVO> getFilteredMembers(String filterType, String filterValue, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("filterType", filterType);
        params.put("filterValue", filterValue);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return sqlSession.selectList(NAMESPACE + ".getFilteredMembers", params);
    }

    @Override
    public int getFilteredMembersCount(String filterType, String filterValue) {
        Map<String, Object> params = new HashMap<>();
        params.put("filterType", filterType);
        params.put("filterValue", filterValue);
        return sqlSession.selectOne(NAMESPACE + ".getFilteredMembersCount", params);
    }
    
    // 검색기능
    @Override
    public List<MemberVO> searchMembers(String searchType, String keyword, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("keyword", keyword);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return sqlSession.selectList(NAMESPACE + ".searchMembers", params);
    }

    @Override
    public int getSearchMembersCount(String searchType, String keyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("keyword", keyword);
        return sqlSession.selectOne(NAMESPACE + ".getSearchMembersCount", params);
    }
    
    // 비밀번호 수정
    @Override
    public void updatePassword(MemberVO member) {
        sqlSession.update(NAMESPACE + ".updatePassword", member);
    }
    
    // 사원 등록
    @Override
    public void insertMember(MemberVO vo) {
        sqlSession.insert(NAMESPACE + ".insertMember", vo);
    }

    @Override
    public int getNextEmployeeSequence() {
        Integer sequence = sqlSession.selectOne(NAMESPACE + ".getNextEmployeeSequence");
        return (sequence != null) ? sequence : 1;
    }
    
    // 관리자 수정
    @Override
    public int updateEmployee(MemberVO vo) {
        return sqlSession.update(NAMESPACE + ".updateEmployee", vo);
    }

    @Override
    public void insertEmployeeHistory(MemberVO vo) {
        sqlSession.insert(NAMESPACE + ".insertEmployeeHistory", vo);
    }
}    
