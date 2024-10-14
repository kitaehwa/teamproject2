package com.Init.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import com.Init.domain.*;
import com.Init.service.MemberService;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

//http://localhost:8088/member/login

@Controller
@RequestMapping("/member")
public class MemberController implements ServletContextAware {

    @Autowired
    private MemberService mService;
    
    private ServletContext servletContext;
    
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
    
    @GetMapping("/main")
    public String mainPage() {
        return "member/main";
    }
    
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
    
    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
    
    @PostMapping("/uploadProfilePicture")
    @ResponseBody
    public String uploadProfilePicture(@RequestParam("emp_profile") MultipartFile file,
                                       @RequestParam("emp_id") String emp_id) {
        if (file.isEmpty()) {
            return "{\"success\": false, \"message\": \"파일이 비어있습니다.\"}";
        }

        try {
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            String uploadDir = servletContext.getRealPath("/profiles");
            File uploadPath = new File(uploadDir);
            if (!uploadPath.exists()) {
                uploadPath.mkdirs();
            }
            File dest = new File(uploadPath + File.separator + fileName);
            file.transferTo(dest);
            
            String emp_profile = "/profiles/" + fileName; // 웹에서 접근 가능한 URL
            mService.updateProfilePicture(emp_id, emp_profile);
            
            return "{\"success\": true, \"newProfilePicUrl\": \"" + emp_profile + "\"}";
        } catch (IOException e) {
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"파일 업로드 중 오류가 발생했습니다.\"}";
        }
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
    
    @GetMapping("/list")
    public String listMembers(@RequestParam(defaultValue = "1") int page, Model model) {
        int pageSize = 10;
        List<MemberVO> members = mService.getPaginatedMembers(page, pageSize);
        int totalMembers = mService.getTotalMembersCount();
        int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

        model.addAttribute("members", members);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "member/list";
    }

    @GetMapping("/detail/{emp_id}")
    @ResponseBody
    public MemberVO getMemberDetail(@PathVariable String emp_id) {
        MemberVO member = mService.getMemberDetail(emp_id);
        logger.info("Member detail requested for emp_id: {}, Result: {}", emp_id, member);
        return member;
    }
    
    // 조직도
    
    @GetMapping("/teamMembers")
    @ResponseBody
    public ResponseEntity<List<MemberVO>> getTeamMembers(@RequestParam String emp_dnum) {
        logger.info("Fetching team members for department: {}", emp_dnum);
        try {
            List<MemberVO> members = mService.getTeamMembers(emp_dnum);
            logger.info("Found {} team members for department: {}", members.size(), emp_dnum);
            return ResponseEntity.ok(members);
        } catch (Exception e) {
            logger.error("Error fetching team members for department: " + emp_dnum, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
    
    @GetMapping("/orgChart")
    @ResponseBody
    public List<Map<String, Object>> getOrgChart(@RequestParam(defaultValue = "부산지부") String emp_bnum) {
        return mService.getOrgChartData(emp_bnum);
    }

    @GetMapping("/branchList")
    @ResponseBody
    public List<String> getBranchList() {
        return mService.getBranchList();
    }
    
}
//http://localhost:8088/member/login
