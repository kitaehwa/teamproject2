package com.Init.service;

import java.util.List;
import java.util.Map;

import com.Init.domain.MemberVO;

public interface OrgService {
    Map<String, Object> getFullOrgChartData();
    List<MemberVO> getTeamMemPage(String deptId);
}
