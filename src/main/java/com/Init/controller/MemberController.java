package com.Init.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;
import com.Init.service.MemberService;

@Controller
@RequestMapping(value = "/member/*")
public class MemberController {
	
	@Autowired
	private MemberService mService;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	// 테스트용 확인 후 삭제
	// http://localhost:8088/member/join
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void joinMemberGet() {
		logger.debug(" /join -> joinMemberGet() 실행");
		logger.debug(" 연결된 뷰(JSP)를 보여주기");
		logger.debug(" /views/member/join.jsp 뷰페이지 연결");
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinMemberPost(MemberVO vo) {
		logger.debug(" /member/join -> joinMemberPost() 실행");
		logger.debug(" vo : "+vo);
		
		mService.memberJoin(vo);
		
		logger.debug(" 회원가입 성공!");
		logger.debug(" 로그인 페이지로 이동 /member/login");
		
		return "/member/join";
	}
		// http://localhost:8088/member/login
		// 로그인 처리 - 입력(GET)
		@RequestMapping(value="/login", method = RequestMethod.GET)
		public String loginMemberGET() {
			logger.debug("/member/login -> loginMemberGET() 실행");
			logger.debug("연결된 뷰페이지(JSP) 출력");
			return "/member/loginForm"; 
		}
		
	// 로그인 처리 - 처리(POST)
	@RequestMapping(value="/login", method = RequestMethod.POST)
		public String loginMemberPOST(MemberVO vo, HttpSession session, Model model) {
		logger.debug("/member/login(post) -> loginMemberPOST() 실행");
		logger.debug("vo : "+vo);
		
		MemberVO resultVO = mService.memberLoginCheck(vo);
		
			if(resultVO == null) {
			// 로그인 실패! 로그인 페이지로 이동			
			return "redirect:/member/login";
			}
			// 사용자의 아이디정보를 세션 영역에 저장
			session.setAttribute("emp_id", resultVO.getEmp_id());
				
			// 로그인 성공! 메인 페이지로 이동
			return "redirect:/member/main";
		}
		
	// 로그아웃 - GET(정보입력, 조회, 출력) / POST(처리 - insert, update, delete...)
	@RequestMapping(value = "/logout",method = RequestMethod.GET)
	public String logoutMemberGET(HttpSession session) {
	logger.debug("/member/logout -> logoutMemberGET() 실행");
			
	// 로그아웃 처리 => 세션정보 초기화
	session.invalidate();
	logger.debug("사용자 정보 로그아웃!");
			
	// 페이지 이동
	return "redirect:/member/main";
}
	
	// 회원정보 조회 - GET
	@GetMapping(value="/info")
	public void infoMemberGET(HttpSession session, Model model) {
	logger.debug("/member/info -> infoMemberGET() 실행");
				
	String emp_id = (String) session.getAttribute("emp_id");
	logger.debug("아이디 : "+emp_id);
	
	MemberVO resultVO = mService.memberInfo(emp_id);
	logger.debug(" vo : "+resultVO);
				
			
	model.addAttribute(resultVO);
	logger.debug("연결된 뷰페이지로 이동 (/member/info.jsp)");
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
	
	// 회원정보 탭 - 비동기
	// 계좌 정보 조회
    @ResponseBody
    @GetMapping("account")
    public AccountVO getAccount(@RequestParam("emp_id") String emp_id) {
        return mService.getAccount(emp_id);
    }

    // 자격증 정보 조회
    @ResponseBody
    @GetMapping("license")
    public List<LicenseVO> getLicense(@RequestParam("emp_id") String emp_id) {
        return mService.getLicense(emp_id);
    }

    // 교육이력 정보 조회
    @ResponseBody
    @GetMapping("his_edu")
    public List<His_eduVO> getHis_edu(@RequestParam("emp_id") String emp_id) {
        return mService.getHis_edu(emp_id);
    }

    // 포상/징계 정보 조회
    @ResponseBody
    @GetMapping("reward")
    public List<RewardVO> getReward(@RequestParam("emp_id") String emp_id) {
        return mService.getReward(emp_id);
    }

    // 인사평가 정보 조회
    @ResponseBody
    @GetMapping("eval")
    public List<EvalVO> getEval(@RequestParam("emp_id") String emp_id) {
        return mService.getEval(emp_id);
    }
    
    // 모달창 계좌정보 수정
    @PostMapping("/member/account/update")
    public ResponseEntity<Map<String, Object>> updateAccount(@RequestBody MemberVO memberVO) {
        Map<String, Object> response = new HashMap<>();      
        try {
            // memberVO의 값을 업데이트하는 서비스 호출
            mService.updateAccountInfo(memberVO);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            e.printStackTrace();
        }
        return ResponseEntity.ok(response);
    }
    
    // 프로필 사진 업로드 처리
    @PostMapping("/uploadProfilePicture")
    public ResponseEntity<Map<String, Object>> uploadProfilePicture(@RequestParam("profilePic") MultipartFile file,
                                                                    @RequestParam("emp_id") String emp_id) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 파일 저장 처리 로직 (예: 로컬 저장소, S3 등)
            String uploadedFileUrl = mService.uploadProfilePicture(file, emp_id);
            
            response.put("success", true);
            response.put("newProfilePicUrl", uploadedFileUrl);  // 새 프로필 이미지 URL 응답
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    // 프로필 사진 삭제 처리
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
    
	
	// 템플릿 적용 확인
	// http://localhost:8088/member/login
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainPage() {
		logger.debug(" /main -> mainPage() 실행");
		logger.debug(" /views/member/main.jsp 뷰페이지 연결");
	}
	
	
}
