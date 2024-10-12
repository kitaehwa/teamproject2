package com.Init.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
	
	private final DataSource dataSource;  // HikariCP DataSource
	
	private static final String NAMESPACE = "com.Init.mapper.MemberMapper";
	
	@Inject
    public MemberDAOImpl(SqlSession sqlSession, DataSource dataSource) {
        this.sqlSession = sqlSession;
        this.dataSource = dataSource; // DataSource 주입
    }
	
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

	// 모달창 계좌정보 수정
	@Override
	public void updateAccount(MemberVO memberVO) throws Exception {
		
		sqlSession.update(NAMESPACE + ".updateAccount", memberVO);
	}
	
	@Override
    public void saveProfilePicture(String emp_id, String fileUrl) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "UPDATE employee SET emp_profile = ? WHERE emp_id = ?";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setString(1, fileUrl);
                pstmt.setString(2, emp_id);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException("프로필 사진 저장 중 오류 발생", e);
        }
    }

    @Override
    public void deleteProfilePicture(String emp_id) {
        try (Connection connection = dataSource.getConnection()) {
            String sql = "UPDATE employee SET emp_profile = NULL WHERE emp_id = ?";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setString(1, emp_id);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException("프로필 사진 삭제 중 오류 발생", e);
        }
    }
	

	
}
