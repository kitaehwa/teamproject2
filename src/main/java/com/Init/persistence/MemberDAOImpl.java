package com.Init.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;



@Repository
public class MemberDAOImpl implements MemberDAO{
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.Init.mapper.MemberMapper";
	
	@Override
	public void insertMember(MemberVO vo) {
		System.out.println(" DAO : 회원가입 동작 실행");
		 
		int result = sqlSession.insert(NAMESPACE + ".insertMember", vo);
		
		System.out.println(" DAO : "+result);
		System.out.println(" DAO : 회원가입 완료");
	}
	
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
	public MemberVO loginMember(String emp_id, String emp_pw) {
		System.out.println(" DAO : loginMember(String emp_id, String emp_pw) 실행");
	
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("emp_id", emp_id);
		paramMap.put("emp_pw", emp_pw);
		
		MemberVO resultVO = sqlSession.selectOne(NAMESPACE+".loginMember",paramMap);
	
		return resultVO;
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
    
}    
