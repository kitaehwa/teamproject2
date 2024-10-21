package com.Init.persistence;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.Init.domain.QuitVO;

@Repository
public class QuitDAOImpl implements QuitDAO {

	@Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.Init.mapper.MemberMapper";

    @Override
    public void insertQuit(QuitVO quitVO) {
        sqlSession.insert(NAMESPACE + ".insertQuit", quitVO);
    }
}