package com.Init.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;



@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Inject
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
	public List<LicenseVO> getLicense(String emp_id) {
		
		return sqlSession.selectList(NAMESPACE+".getLicense",emp_id);
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
	
	
	
	
	
}
