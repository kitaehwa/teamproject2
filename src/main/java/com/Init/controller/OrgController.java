package com.Init.controller;

import com.Init.domain.MemberVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.Init.service.OrgService;

import java.util.List;
import java.util.Map;


//http://localhost:8088/member/login
@Controller
@RequestMapping("/member/org")
public class OrgController {

    @Autowired
    private OrgService orgService;

    @GetMapping("/chart")
    public String getOrgChartPage() {
        return "member/org";  // org.jsp를 반환
    }

    @GetMapping("/data")
    @ResponseBody
    public ResponseEntity<?> getOrgChartData() {
        try {
            Map<String, Object> data = orgService.getFullOrgChartData();
            System.out.println("Returning org chart data: " + data);
            return ResponseEntity.ok(data);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("Error fetching org chart data: " + e.getMessage());
        }
    }

    @GetMapping("/teamMembers")
    @ResponseBody
    public List<MemberVO> getTeamMemPage(@RequestParam String deptId) {
        return orgService.getTeamMemPage(deptId);
    }
}
