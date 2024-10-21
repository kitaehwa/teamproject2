package com.Init.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.persistence.OrgDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.Init.domain.MemberVO;

@Service
public class OrgServiceImpl implements OrgService {
	private static final Logger logger = LoggerFactory.getLogger(OrgServiceImpl.class);

    @Autowired
    private OrgDAO orgDAO;

    @Override
    public Map<String, Object> getFullOrgChartData() {
        List<MemberVO> allMembers = orgDAO.getAllMemPage();
        Map<String, Object> orgChart = new HashMap<>();
        
        // CEO 노드 생성
        MemberVO ceo = allMembers.stream()
            .filter(m -> "CEO".equals(m.getEmp_job()))
            .findFirst()
            .orElse(null);
        
        orgChart.put("name", ceo != null ? ceo.getEmp_name() : "미정");
        orgChart.put("title", "CEO");
        orgChart.put("children", new ArrayList<>());

        // 본부별로 그룹화
        Map<String, List<MemberVO>> branchGroups = allMembers.stream()
            .filter(m -> m.getEmp_bnum() != null) // null 본부 필터링
            .collect(Collectors.groupingBy(MemberVO::getEmp_bnum));

        for (Map.Entry<String, List<MemberVO>> entry : branchGroups.entrySet()) {
            Map<String, Object> branchNode = createBranchNode(entry.getKey(), entry.getValue());
            if (branchNode != null) {
                ((List<Map<String, Object>>) orgChart.get("children")).add(branchNode);
            }
        }
        
        return orgChart;
    }

    private Map<String, Object> createBranchNode(String branchName, List<MemberVO> branchMembers) {
        if (branchName == null || branchMembers == null || branchMembers.isEmpty()) {
            logger.warn("Invalid branch data: name={}, members={}", branchName, branchMembers);
            return null;
        }

        Map<String, Object> branchNode = new HashMap<>();
        
        // 본부장 찾기
        MemberVO branchManager = branchMembers.stream()
            .filter(m -> "본부장".equals(m.getEmp_job()))
            .findFirst()
            .orElse(null);

        branchNode.put("name", branchManager != null ? branchManager.getEmp_name() : "미정");
        branchNode.put("title", branchName);
        branchNode.put("children", new ArrayList<>());

        // 부서별로 그룹화
        Map<String, List<MemberVO>> deptGroups = branchMembers.stream()
            .filter(m -> !"본부장".equals(m.getEmp_job()) && m.getEmp_dnum() != null) // null 부서 필터링
            .collect(Collectors.groupingBy(MemberVO::getEmp_dnum));

        for (Map.Entry<String, List<MemberVO>> entry : deptGroups.entrySet()) {
            Map<String, Object> deptNode = createDepartmentNode(entry.getKey(), entry.getValue());
            if (deptNode != null) {
                ((List<Map<String, Object>>) branchNode.get("children")).add(deptNode);
            }
        }

        return branchNode;
    }

    private Map<String, Object> createDepartmentNode(String deptName, List<MemberVO> deptMembers) {
        if (deptName == null || deptMembers == null || deptMembers.isEmpty()) {
            logger.warn("Invalid department data: name={}, members={}", deptName, deptMembers);
            return null;
        }

        Map<String, Object> deptNode = new HashMap<>();
        
        // 부서장 찾기
        MemberVO deptManager = deptMembers.stream()
            .filter(m -> "부서장".equals(m.getEmp_job()))
            .findFirst()
            .orElse(null);

        deptNode.put("name", deptManager != null ? deptManager.getEmp_name() : "미정");
        deptNode.put("title", deptName);
        deptNode.put("children", new ArrayList<>());

        // 팀원 추가 (필요한 경우 주석 해제)
        /*
        for (MemberVO member : deptMembers) {
            if (!"부서장".equals(member.getEmp_job())) {
                Map<String, Object> memberNode = new HashMap<>();
                memberNode.put("name", member.getEmp_name() != null ? member.getEmp_name() : "미정");
                memberNode.put("title", member.getEmp_position() != null ? member.getEmp_position() : "미정");
                ((List<Map<String, Object>>) deptNode.get("children")).add(memberNode);
            }
        }
        */

        return deptNode;
    }

    @Override
    public List<MemberVO> getTeamMemPage(String deptId) {
        return orgDAO.getTeamMemPage(deptId);
    }
}