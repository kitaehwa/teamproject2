package com.Init.persistence;

import com.Init.domain.MemberVO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class OrgDAOImpl implements OrgDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.Init.mapper.MemberMapper";

    @Override
    public List<MemberVO> getAllMemPage() {
        return sqlSession.selectList(NAMESPACE + ".getAllMemPage");
    }

    @Override
    public List<MemberVO> getTeamMemPage(String deptId) {
        return sqlSession.selectList(NAMESPACE + ".getTeamMemPage", deptId);
    }
}
