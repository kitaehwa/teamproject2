package com.Init.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.Init.domain.MemberVO;
import com.Init.domain.QuitVO;
import com.Init.service.MemberService;
import com.Init.service.QuitService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

import javax.servlet.http.HttpSession;

//http://localhost:8088/member/login

@Controller
@RequestMapping("/quit")
public class QuitController {
	
private static final Logger logger = LoggerFactory.getLogger(QuitController.class);
    
	@Autowired
    private MemberService mService;

    @Autowired
    private QuitService quitService;

    @GetMapping("/application")
    public String quitApplicationForm(HttpSession session, Model model) {
        String emp_id = (String) session.getAttribute("emp_id");
        MemberVO member = mService.memberInfo(emp_id);
        model.addAttribute("memberVO", member);
        return "member/quit";
    }
    

    @PostMapping("/submit")
    public ResponseEntity<String> submitQuit(@RequestBody QuitVO quitVO) {
        try {
            quitService.submitQuit(quitVO);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
}

//http://localhost:8088/member/login