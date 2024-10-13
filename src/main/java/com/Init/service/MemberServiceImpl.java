package com.Init.service;

import com.Init.domain.*;
import com.Init.persistence.MemberDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

	@Value("${upload.path}")
    private String uploadPath;
	
    private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

    @Autowired
    private MemberDAO mdao;
    
    private static final String UPLOAD_DIR = "/path/to/upload/directory/";

    @Override
    @Transactional
    public void memberJoin(MemberVO vo) {
        logger.debug("회원가입 서비스 실행: {}", vo);
        mdao.insertMember(vo);
    }

    @Override
    public MemberVO memberLoginCheck(MemberVO vo) {
        logger.debug("로그인 체크 서비스 실행: {}", vo);
        return mdao.loginMember(vo);
    }

    @Override
    public MemberVO memberInfo(String emp_id) {
        logger.debug("회원 정보 조회 서비스 실행: {}", emp_id);
        return mdao.getMember(emp_id);
    }

    @Override
	public int memberUpdate(MemberVO uvo) {
		logger.debug("memberUpdate(MemberVO uvo) 실행");
		// 회원정보 수정
		int result = mdao.updateMember(uvo);
		// 회원정보 수정 이력
		mdao.insertHisMember(uvo);
		
		return result;
	}

    @Override
    public AccountVO getAccount(String emp_id) {
        return mdao.getAccount(emp_id);
    }

    @Override
    public List<LicenseVO> getLicense(String emp_id) {
        return mdao.getLicense(emp_id);
    }

    @Override
    public List<His_eduVO> getHis_edu(String emp_id) {
        return mdao.getHis_edu(emp_id);
    }

    @Override
    public List<RewardVO> getReward(String emp_id) {
        return mdao.getReward(emp_id);
    }

    @Override
    public List<EvalVO> getEval(String emp_id) {
        return mdao.getEval(emp_id);
    }
    
    @Override
    public String uploadProfilePicture(MultipartFile file, String emp_id) throws IOException {
        String fileName = emp_id + "_profile.jpg";
        Path path = Paths.get(uploadPath, fileName);
        Files.write(path, file.getBytes());

        String fileUrl = "/uploads/" + fileName;
        mdao.updateProfilePicture(emp_id, fileUrl);

        return fileUrl;
    }

    @Override
    public void deleteProfilePicture(String emp_id) throws IOException {
        String fileName = emp_id + "_profile.jpg";
        Path path = Paths.get(uploadPath, fileName);
        Files.deleteIfExists(path);

        mdao.updateProfilePicture(emp_id, null);
    }

    
    @Override
    public void updateAccountInfo(MemberVO memberVO) throws Exception {
        mdao.updateAccount(memberVO);
    }
}
