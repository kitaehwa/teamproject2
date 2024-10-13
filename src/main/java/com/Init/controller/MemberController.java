package com.Init.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Init.domain.*;
import com.Init.service.MemberService;

import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//http://localhost:8088/member/login
@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService mService;
    
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @GetMapping("/join")
    public String joinMemberGet() {
        return "member/join";
    }

    @PostMapping("/join")
    public String joinMemberPost(@ModelAttribute MemberVO vo) {
        mService.memberJoin(vo);
        return "redirect:/member/login";
    }

    @GetMapping("/login")
    public String loginMemberGET() {
        return "member/loginForm";
    }

    @PostMapping("/login")
    public String loginMemberPOST(@ModelAttribute MemberVO vo, HttpSession session) {
        MemberVO resultVO = mService.memberLoginCheck(vo);
        if (resultVO == null) {
            return "redirect:/member/login";
        }
        session.setAttribute("emp_id", resultVO.getEmp_id());
        return "redirect:/member/main";
    }

    @GetMapping("/logout")
    public String logoutMemberGET(HttpSession session) {
        session.invalidate();
        return "redirect:/member/main";
    }

    @GetMapping("/info")
    public String infoMemberGET(HttpSession session, Model model) {
        String emp_id = (String) session.getAttribute("emp_id");
        model.addAttribute("memberVO", mService.memberInfo(emp_id));
        return "member/info";
    }

    // 회원정보 수정 - 입력GET
 	@RequestMapping(value = "/update",method = RequestMethod.GET)
 	public String updateMemberGET(HttpSession session, Model model) {
 	logger.debug("/member/update -> updateMemberGET() 실행");				
 	logger.debug("기존의 회원정보를 DB에서 가져오기");
 	
 	String emp_id = (String) session.getAttribute("emp_id");
 				
 	model.addAttribute(mService.memberInfo(emp_id));				
 	logger.debug("연결된 뷰페이지 출력(/views/member/update.jsp)");
 				
 	return "/member/update";
 	}
 			
 	// 회원정보 수정 - 처리POST
 	@RequestMapping(value="/update",method = RequestMethod.POST)
 	public String updateMemberPOST(MemberVO vo) {
 	logger.debug("/member/update -> updateMemberPOST() 실행");
 	logger.debug("전달받은 정보(파라메터)를 저장");
 	logger.debug(" vo : "+vo);	
 		
 	int result = mService.memberUpdate(vo);				
 	if(result == 0) {	
 	return "redirect:/member/update";
 	}
 	// 수정 성공
 	return "redirect:/member/info";
 	}

    @GetMapping("/account")
    @ResponseBody
    public AccountVO getAccount(@RequestParam("emp_id") String emp_id) {
        return mService.getAccount(emp_id);
    }

    @GetMapping("/license")
    @ResponseBody
    public List<LicenseVO> getLicense(@RequestParam("emp_id") String emp_id) {
        return mService.getLicense(emp_id);
    }

    @GetMapping("/his_edu")
    @ResponseBody
    public List<His_eduVO> getHis_edu(@RequestParam("emp_id") String emp_id) {
        return mService.getHis_edu(emp_id);
    }

    @GetMapping("/reward")
    @ResponseBody
    public List<RewardVO> getReward(@RequestParam("emp_id") String emp_id) {
        return mService.getReward(emp_id);
    }

    @GetMapping("/eval")
    @ResponseBody
    public List<EvalVO> getEval(@RequestParam("emp_id") String emp_id) {
        return mService.getEval(emp_id);
    }
    
    @PostMapping("/uploadProfilePicture")
    public ResponseEntity<Map<String, Object>> uploadProfilePicture(@RequestParam("profilePic") MultipartFile file,
                                                                    @RequestParam("emp_id") String emp_id) {
        Map<String, Object> response = new HashMap<>();
        try {
            String uploadedFileUrl = mService.uploadProfilePicture(file, emp_id);
            response.put("success", true);
            response.put("newProfilePicUrl", uploadedFileUrl);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/deleteProfilePicture")
    public ResponseEntity<Map<String, Object>> deleteProfilePicture(@RequestParam("emp_id") String emp_id) {
        Map<String, Object> response = new HashMap<>();
        try {
            mService.deleteProfilePicture(emp_id);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/account/update")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateAccount(@RequestBody MemberVO memberVO) {
        Map<String, Object> response = new HashMap<>();
        try {
            mService.updateAccountInfo(memberVO);
            response.put("success", true);
            response.put("message", "계좌 정보가 성공적으로 업데이트되었습니다.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "계좌 정보 업데이트에 실패했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/main")
    public String mainPage() {
        return "member/main";
    }
}
//http://localhost:8088/member/login
