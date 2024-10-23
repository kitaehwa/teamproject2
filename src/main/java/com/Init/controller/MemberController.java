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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Init.domain.*;
import com.Init.service.MemberService;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.sql.Date;

//http://localhost:8088/member/login

@Controller
@RequestMapping("/member")
public class MemberController implements ServletContextAware {

	@Autowired
	private MemberService mService;

	private ServletContext servletContext;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@GetMapping("/main")
	public String mainPage(HttpSession session, Model model) {
	    String emp_id = (String) session.getAttribute("emp_id");
	    MemberVO member = mService.memberInfo(emp_id);
	    
	    if (member.getEmp_tel() == null || member.getEmp_email() == null || member.getEmp_addr() == null) {
	        model.addAttribute("needInfoUpdate", true);
	    }
	    
	    return "member/main";
	}

	@GetMapping("/login")
	public String loginMemberGET() {
		return "member/loginForm";
	}

	@PostMapping("/login")
	public String loginMemberPOST(@ModelAttribute MemberVO vo, HttpSession session, RedirectAttributes rttr) {
	    MemberVO resultVO = mService.memberLoginCheck(vo);
	    if (resultVO == null) {
	        rttr.addFlashAttribute("loginError", "사원번호 또는 비밀번호가 올바르지 않습니다.");
	        return "redirect:/member/login";
	    }
	    session.setAttribute("emp_id", resultVO.getEmp_id());
	    return "redirect:/member/main";
	}
	// 퇴직신청 - GET
	@GetMapping("/quit")
	public String quitPage(HttpSession session, Model model) {
	    String emp_id = (String) session.getAttribute("emp_id");
	    // 로그인 체크
	    if(emp_id == null) {
	        return "redirect:/member/login";
	    }
	    
	    MemberVO memberVO = mService.memberInfo(emp_id);
	    model.addAttribute("memberVO", memberVO);
	    
	    return "member/quit";  
	}
	
	// 퇴직신청 - POST
	@PostMapping("/submitQuit")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> submitQuit(
	        @RequestParam("emp_id") String emp_id,
	        @RequestParam("reason") String reason,
	        @RequestParam("emp_quit_date") Date emp_quit_date,  
	        @RequestParam("reason_detail") String reason_detail) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        MemberVO memberVO = new MemberVO();
	        memberVO.setEmp_id(emp_id);
	        memberVO.setReason(reason);
	        memberVO.setEmp_quit_date(emp_quit_date);  
	        memberVO.setReason_detail(reason_detail);
	        
	        boolean result = mService.insertQuitEmployee(memberVO);
	        if(result) {
	            response.put("success", true);
	            response.put("message", "퇴직 신청이 완료되었습니다.");
	        } else {
	            response.put("success", false);
	            response.put("message", "퇴직 신청 처리 중 오류가 발생했습니다.");
	        }
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "서버 오류: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
	// 비밀번호 찾기
	@GetMapping("/forgotPassword")
    public String showForgotPasswordForm() {
        return "member/forgotPassword";
    }

	@PostMapping(value = "/sendVerificationCode", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<?> sendVerificationCode(@RequestParam String emp_id, @RequestParam String emp_email) {
	    if (mService.isValidEmployee(emp_id, emp_email)) {
	        String verificationCode = generateVerificationCode();
	        // 비동기로 이메일 발송 (결과를 기다리지 않음)
	        mService.sendVerificationEmail(emp_id, emp_email, verificationCode);
	        return ResponseEntity.ok().body("{\"message\": \"인증 코드가 이메일로 전송되었습니다. 잠시 후 이메일을 확인해주세요.\"}");
	    } else {
	        return ResponseEntity.badRequest().body("{\"message\": \"유효하지 않은 사원번호 또는 이메일입니다.\"}");
	    }
	}

	@PostMapping(value = "/verifyCode", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<?> verifyCode(@RequestParam String emp_id, @RequestParam String verificationCode) {
	    boolean isValid = mService.verifyCode(emp_id, verificationCode);
	    if (isValid) {
	        return ResponseEntity.ok().body("{\"message\": \"인증에 성공했습니다.\", \"success\": true}");
	    } else {
	        return ResponseEntity.ok().body("{\"message\": \"잘못된 인증 코드이거나 만료되었습니다.\", \"success\": false}");
	    }
	}

    @GetMapping("/resetPassword")
    public String showResetPasswordForm(@RequestParam String emp_id, Model model) {
        model.addAttribute("emp_id", emp_id);
        return "member/resetPassword";
    }

    @PostMapping(value = "/resetPassword", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ResponseEntity<?> resetPassword(@RequestParam String emp_id, @RequestParam String newPassword) {
        try {
            mService.resetPassword(emp_id, newPassword);
            return ResponseEntity.ok().body("{\"message\": \"비밀번호가 성공적으로 변경되었습니다.\"}");
        } catch (Exception e) {
            logger.error("비밀번호 재설정 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("{\"message\": \"비밀번호 재설정 중 오류가 발생했습니다: " + e.getMessage() + "\"}");
        }
    }

    private String generateVerificationCode() {
        // 6자리 랜덤 숫자 생성
        return String.format("%06d", new Random().nextInt(999999));
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
	// 정보수정 비밀번호 인증
	@PostMapping("/verifyPassword")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> verifyPassword(
	        @RequestParam String emp_id, 
	        @RequestParam String password) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        boolean isValid = mService.verifyPassword(emp_id, password);
	        response.put("success", isValid);
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "비밀번호 확인 중 오류가 발생했습니다.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
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
	 	@RequestMapping(value="/update", method = RequestMethod.POST)
	 	@ResponseBody
	 	public ResponseEntity<Map<String, Object>> updateMemberPOST(@ModelAttribute MemberVO vo) {
	 	    logger.debug("/member/update -> updateMemberPOST() 실행");
	 	    logger.debug("전달받은 정보(파라메터)를 저장");
	 	    logger.debug(" vo : "+vo);	
	 			
	 	    Map<String, Object> response = new HashMap<>();
	 	    try {
	 	        int result = mService.memberUpdate(vo);				
	 	        if(result == 0) {	
	 	            response.put("success", false);
	 	            response.put("message", "회원 정보 업데이트 실패");
	 	            return ResponseEntity.ok(response);
	 	        }
	 	        // 수정 성공
	 	        response.put("success", true);
	 	        response.put("message", "회원 정보가 성공적으로 업데이트되었습니다.");
	 	        return ResponseEntity.ok(response);
	 	    } catch (Exception e) {
	 	        response.put("success", false);
	 	        response.put("message", "서버 오류: " + e.getMessage());
	 	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	 	    }
	 	}

	// 비밀번호 수정
	 	@PostMapping("/updatePassword")
	 	@ResponseBody
	 	public ResponseEntity<Map<String, Object>> updatePassword(@RequestParam String emp_id,
	 	        @RequestParam String current_password, @RequestParam String new_password,
	 	        @RequestParam String confirm_password) {

	 	    logger.debug("/member/updatePassword -> updatePassword() 실행");

	 	    Map<String, Object> response = new HashMap<>();

	 	    if (!new_password.equals(confirm_password)) {
	 	        response.put("success", false);
	 	        response.put("message", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
	 	        return ResponseEntity.ok(response);
	 	    }

	 	    try {
	 	        boolean result = mService.updatePassword(emp_id, current_password, new_password);
	 	        if (result) {
	 	            response.put("success", true);
	 	            response.put("message", "비밀번호가 성공적으로 변경되었습니다.");
	 	        } else {
	 	            response.put("success", false);
	 	            response.put("message", "현재 비밀번호가 일치하지 않습니다.");
	 	        }
	 	    } catch (Exception e) {
	 	        response.put("success", false);
	 	        response.put("message", "비밀번호 변경 중 오류가 발생했습니다: " + e.getMessage());
	 	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	 	    }

	 	    return ResponseEntity.ok(response);
	 	}
	 	private boolean isValidPassword(String password) {
	 	    String regex = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";
	 	    return password.matches(regex);
	 	}

	@GetMapping("/account")
	@ResponseBody
	public AccountVO getAccount(@RequestParam("emp_id") String emp_id) {
		return mService.getAccount(emp_id);
	}

	@GetMapping("/license")
	@ResponseBody
	public List<LicenseVO> getEmpLicense(@RequestParam("emp_id") String emp_id) {
		return mService.getEmpLicense(emp_id);
	}

	@GetMapping("/licenseList")
	@ResponseBody
	public List<Map<String, Object>> getLicenseList() {
		List<Map<String, Object>> licenseList = mService.getAllLicenses();
		System.out.println("License List: " + licenseList); // 디버깅용 로그
		return licenseList;
	}

	@PostMapping("/addLicense")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addLicense(@RequestBody LicenseVO licenseVO, HttpSession session) {
		String emp_id = (String) session.getAttribute("emp_id");
		licenseVO.setEmp_id(emp_id);
		Map<String, Object> response = new HashMap<>();
		try {
			boolean isAdded = mService.registerLicense(licenseVO);
			if (isAdded) {
				response.put("success", true);
				response.put("message", "자격증이 성공적으로 추가되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "이미 등록된 자격증입니다.");
			}
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "자격증 추가에 실패했습니다: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@DeleteMapping("/deleteLicense/{licenseId}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deleteLicense(@PathVariable String licenseId, HttpSession session) {
		String emp_id = (String) session.getAttribute("emp_id");
		Map<String, Object> response = new HashMap<>();
		try {
			mService.removeLicense(licenseId, emp_id);
			response.put("success", true);
			response.put("message", "자격증이 성공적으로 삭제되었습니다.");
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "자격증 삭제에 실패했습니다: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
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
		int pageSize = 8;
		List<MemberVO> members = mService.getPaginatedMembers(page, pageSize);
		int totalMembers = mService.getTotalMembersCount();
		int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

		model.addAttribute("members", members);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		return "member/list";
	}

	@GetMapping("/manager")
	public String listManager(@RequestParam(defaultValue = "1") int page, Model model) {
		int pageSize = 8;
		List<MemberVO> members = mService.getPaginatedMembers(page, pageSize);
		int totalMembers = mService.getTotalMembersCount();
		int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

		model.addAttribute("members", members);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		return "member/manager";
	}

	@GetMapping("/detail/{emp_id}")
	@ResponseBody
	public MemberVO getMemberDetail(@PathVariable String emp_id) {
		MemberVO member = mService.getMemberDetail(emp_id);
		logger.debug("Member detail requested for emp_id: {}, Result: {}", emp_id, member);
		return member;
	}

	// 회원목록 내 조직도
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
		logger.info("Fetching org chart for branch: {}", emp_bnum);
		return mService.getOrgChartData(emp_bnum);
	}

	@GetMapping("/branchList")
	@ResponseBody
	public List<String> getBranchList() {
		return mService.getBranchList();
	}

	// 필터 부분
	@GetMapping("/filterOptions")
	@ResponseBody
	public List<String> getFilterOptions(@RequestParam String filterType) {
		return mService.getFilterOptions(filterType);
	}

	@GetMapping("/filter")
    public String filterMembers(@RequestParam String filterType, 
                                @RequestParam String filterValue,
                                @RequestParam(defaultValue = "1") int page, 
                                @RequestParam(required = false) String pageType, 
                                Model model) {
        int pageSize = 8;
        List<MemberVO> members = mService.getFilteredMembers(filterType, filterValue, page, pageSize);
        int totalMembers = mService.getFilteredMembersCount(filterType, filterValue);
        int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

        model.addAttribute("members", members);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("filterType", filterType);
        model.addAttribute("filterValue", filterValue);

        logger.debug("Filtered members: " + members.size());
        logger.debug("Total filtered members: " + totalMembers);
        logger.debug("Received pageType: " + pageType);

        if ("manager".equals(pageType)) {
            return "member/manager";
        } else {
            return "member/list";
        }
    }

	// 검색기능
	@GetMapping("/search")
    public String searchMembers(@RequestParam String searchType, 
                                @RequestParam String keyword,
                                @RequestParam(defaultValue = "1") int page, 
                                @RequestParam(required = false) String pageType, 
                                Model model) {
        int pageSize = 8;
        List<MemberVO> members = mService.searchMembers(searchType, keyword, page, pageSize);
        int totalMembers = mService.getSearchMembersCount(searchType, keyword);
        int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

        model.addAttribute("members", members);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);

        logger.debug("Searched members: " + members.size());
        logger.debug("Total searched members: " + totalMembers);
        logger.debug("Received pageType: " + pageType);

        if ("manager".equals(pageType)) {
            return "member/manager";
        } else {
            return "member/list";
        }
    }
	
	// 사원 등록
	@PostMapping("/register")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> registerEmployee(@RequestBody MemberVO vo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 사원번호 자동 생성
	        String emp_id = mService.generateEmployeeId();
	        vo.setEmp_id(emp_id);
	        
	        // 비밀번호를 생년월일로 설정
	        String birthDate = vo.getEmp_birth().toString().replaceAll("-", "");
	        vo.setEmp_pw(birthDate);
	        
	        // 사원 등록
	        boolean result = mService.registerEmployee(vo);
	        if (result) {
	            response.put("success", true);
	            response.put("message", "사원이 성공적으로 등록되었습니다.");
	            response.put("emp_id", emp_id);
	        } else {
	            response.put("success", false);
	            response.put("message", "사원 등록에 실패했습니다.");
	        }
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "서버 오류: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
	// 관리자 수정
	@PostMapping("/mupdate")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateEmployeeInfo(@RequestBody MemberVO vo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	    	logger.info("Updating employee info: {}", vo);
	    	boolean result = mService.updateEmployeeInfo(vo);
	        if(result) {
	            response.put("success", true);
	            response.put("message", "사원 정보가 성공적으로 업데이트되었습니다.");
	        } else {
	            response.put("success", false);
	            response.put("message", "사원 정보 업데이트에 실패했습니다.");
	        }
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	    	logger.error("사원 정보 업데이트 중 서버 오류 발생", e);
	    	response.put("success", false);
	        response.put("message", "서버 오류: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
}
//http://localhost:8088/member/login
