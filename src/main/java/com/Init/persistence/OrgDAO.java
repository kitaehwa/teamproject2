package com.Init.persistence;

import java.util.List;
import com.Init.domain.MemberVO;

public interface OrgDAO {
    List<MemberVO> getAllMemPage();
    List<MemberVO> getTeamMemPage(String deptId);
}
