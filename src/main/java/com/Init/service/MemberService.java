package com.Init.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;


public interface MemberService {
	
	// 회원로그인 체크 동작
	public MemberVO memberLoginCheck(MemberVO vo);
	
	// 비밀번호 찾기
	boolean isValidEmployee(String emp_id, String emp_email);
	void sendVerificationEmail(String emp_id, String emp_email, String verificationCode);
    boolean verifyCode(String emp_id, String verificationCode);
    void resetPassword(String emp_id, String newPassword);
	
    // 정보수정 비밀번호 인증
    boolean verifyPassword(String emp_id, String password);
    
	// 회원정보 조회 및 수정
	public MemberVO memberInfo(String emp_id);
	public int memberUpdate(MemberVO uvo);
	
	// 계좌 정보 가져오기
    AccountVO getAccount(String emp_id);

    // 자격증 정보 가져오기
    List<LicenseVO> getEmpLicense(String emp_id);

    // 교육이력 정보 가져오기
    List<His_eduVO> getHis_edu(String emp_id);

    // 포상/징계 정보 가져오기
    List<RewardVO> getReward(String emp_id);

    // 인사평가 정보 가져오기
    List<EvalVO> getEval(String emp_id);
    
    // 모달 계좌정보 업데이트
    void updateAccountInfo(MemberVO memberVO) throws Exception;
    
    // 프로필 사진 업로드
    void updateProfilePicture(String emp_id, String emp_profile);
    
    // 회원목록 조회
    List<MemberVO> getPaginatedMembers(int page, int pageSize);
    int getTotalMembersCount();
    MemberVO getMemberDetail(String emp_id);
    
    // 조직도
    List<MemberVO> getTeamMembers(String emp_dnum);
    List<Map<String, Object>> getOrgChartData(String emp_bnum);
    List<String> getBranchList();
    
    // 자격증 추가
    List<Map<String, Object>> getAllLicenses();
    boolean registerLicense(LicenseVO licenseVO);
    void removeLicense(String licenseId, String emp_id);
    
    // 필터 부분
    List<String> getFilterOptions(String filterType);
    List<MemberVO> getFilteredMembers(String filterType, String filterValue, int page, int pageSize);
    int getFilteredMembersCount(String filterType, String filterValue);
    
    // 검색기능
    List<MemberVO> searchMembers(String searchType, String keyword, int page, int pageSize);
    int getSearchMembersCount(String searchType, String keyword);
    
    // 비밀번호 수정
    boolean updatePassword(String emp_id, String currentPassword, String newPassword) throws Exception;
    
    // 관리자정보 수정
    boolean updateEmployeeInfo(MemberVO vo);
    
    // 사원등록
    String generateEmployeeId();
    boolean registerEmployee(MemberVO vo);
    void insertMember(MemberVO vo);
    
    // 퇴직신청
    boolean insertQuitEmployee(MemberVO memberVO);
}
