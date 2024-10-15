package com.Init.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.persistence.OrgDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.Init.domain.MemberVO;

@Service
public class OrgServiceImpl implements OrgService {

    @Autowired
    private OrgDAO orgDAO;

    @Override
    public Map<String, Object> getFullOrgChartData() {
        List<MemberVO> allMembers = orgDAO.getAllMemPage();
        Map<String, Object> orgChart = new HashMap<>();

        // CEO 노드 생성
        orgChart.put("name", "CEO");
        orgChart.put("title", "CEO");
        orgChart.put("children", new ArrayList<>());

        // 본부별로 그룹화
        Map<String, List<MemberVO>> branchGroups = allMembers.stream()
            .collect(Collectors.groupingBy(MemberVO::getEmp_bnum));

        for (Map.Entry<String, List<MemberVO>> entry : branchGroups.entrySet()) {
            Map<String, Object> branchNode = createBranchNode(entry.getKey(), entry.getValue());
            ((List<Map<String, Object>>) orgChart.get("children")).add(branchNode);
        }

        return orgChart;
    }

    private Map<String, Object> createBranchNode(String branchName, List<MemberVO> branchMembers) {
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
            .filter(m -> !"본부장".equals(m.getEmp_job()))
            .collect(Collectors.groupingBy(MemberVO::getEmp_dnum));

        for (Map.Entry<String, List<MemberVO>> entry : deptGroups.entrySet()) {
            Map<String, Object> deptNode = createDepartmentNode(entry.getKey(), entry.getValue());
            ((List<Map<String, Object>>) branchNode.get("children")).add(deptNode);
        }

        return branchNode;
    }

    private Map<String, Object> createDepartmentNode(String deptName, List<MemberVO> deptMembers) {
        Map<String, Object> deptNode = new HashMap<>();
        
        // 부서장 찾기
        MemberVO deptManager = deptMembers.stream()
            .filter(m -> "부서장".equals(m.getEmp_job()))
            .findFirst()
            .orElse(null);

        deptNode.put("name", deptManager != null ? deptManager.getEmp_name() : "미정");
        deptNode.put("title", deptName);
        deptNode.put("children", new ArrayList<>());

        // 여기서 팀원들을 추가할 수 있습니다. 필요하다면 아래 주석을 해제하세요.
        /*
        for (MemberVO member : deptMembers) {
            if (!"부서장".equals(member.getEmp_job())) {
                Map<String, Object> memberNode = new HashMap<>();
                memberNode.put("name", member.getEmp_name());
                memberNode.put("title", member.getEmp_position());
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