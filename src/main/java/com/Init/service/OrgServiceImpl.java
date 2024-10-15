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
        
        // CEO 노드 생성
        Map<String, Object> ceoNode = new HashMap<>();
        ceoNode.put("name", "CEO");
        ceoNode.put("title", "CEO");
        ceoNode.put("children", new ArrayList<>());

        // 본부별로 그룹화
        Map<String, List<MemberVO>> branchGroups = allMembers.stream()
            .collect(Collectors.groupingBy(MemberVO::getEmp_bnum));

        for (Map.Entry<String, List<MemberVO>> entry : branchGroups.entrySet()) {
            Map<String, Object> branchNode = createBranchNode(entry.getKey(), entry.getValue());
            ((List<Map<String, Object>>) ceoNode.get("children")).add(branchNode);
        }

        return ceoNode;
    }

    private Map<String, Object> createBranchNode(String branchName, List<MemberVO> branchMembers) {
        Map<String, Object> branchNode = new HashMap<>();
        branchNode.put("name", branchName);
        branchNode.put("title", "본부");
        branchNode.put("children", new ArrayList<>());

        // 본부장 찾기
        MemberVO branchManager = branchMembers.stream()
            .filter(m -> "본부장".equals(m.getEmp_job()))
            .findFirst()
            .orElse(null);

        if (branchManager != null) {
            Map<String, Object> managerNode = new HashMap<>();
            managerNode.put("name", branchManager.getEmp_name());
            managerNode.put("title", branchManager.getEmp_job());
            ((List<Map<String, Object>>) branchNode.get("children")).add(managerNode);
        }

        // 부서별로 그룹화
        Map<String, List<MemberVO>> deptGroups = branchMembers.stream()
            .collect(Collectors.groupingBy(MemberVO::getEmp_dnum));

        for (Map.Entry<String, List<MemberVO>> entry : deptGroups.entrySet()) {
            Map<String, Object> deptNode = createDepartmentNode(entry.getKey(), entry.getValue());
            ((List<Map<String, Object>>) branchNode.get("children")).add(deptNode);
        }

        return branchNode;
    }

    private Map<String, Object> createDepartmentNode(String deptName, List<MemberVO> deptMembers) {
        Map<String, Object> deptNode = new HashMap<>();
        deptNode.put("name", deptName);
        deptNode.put("title", "부서");
        deptNode.put("children", new ArrayList<>());

        // 부서장 찾기
        MemberVO deptManager = deptMembers.stream()
            .filter(m -> "부서장".equals(m.getEmp_job()))
            .findFirst()
            .orElse(null);

        if (deptManager != null) {
            Map<String, Object> managerNode = new HashMap<>();
            managerNode.put("name", deptManager.getEmp_name());
            managerNode.put("title", deptManager.getEmp_job());
            managerNode.put("id", deptManager.getEmp_id());  // 팀원 조회를 위한 ID
            ((List<Map<String, Object>>) deptNode.get("children")).add(managerNode);
        }

        return deptNode;
    }

    @Override
    public List<MemberVO> getTeamMemPage(String deptId) {
        return orgDAO.getTeamMemPage(deptId);
    }
}