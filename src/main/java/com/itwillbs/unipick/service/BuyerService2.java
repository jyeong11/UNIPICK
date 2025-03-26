package com.itwillbs.unipick.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.BuyerMapper2;

@Service
public class BuyerService2 {

	@Autowired
	BuyerMapper2 mapper;
	
	public Map<String, Object> BuyerLogin(Map<String, Object> logindata) {
		return mapper.BuyerLogin(logindata);
	}
	

    public boolean BuyEmail(String email) {
        return mapper.BuyEmail(email) > 0;
    }
    
    public boolean validatePassword(String password) {
        // 비밀번호 규칙: 8~16자, 영문자, 숫자, 특수문자(!@#$%)
        String regex = "^[A-Za-z0-9!@#$%]{8,16}$";
        return password.matches(regex);
    }

    public boolean registerBuyer(String email, String password, String phone) {
        if (!validatePassword(password)) {
            return false; // 비밀번호 유효성 검사 실패
        }
        try {
            mapper.insertBuyer(email, password, phone); // 사용자 정보를 DB에 삽입
            return true;
        } catch (Exception e) {
            return false;
        }
    }

}
	
	/*// 이메일 비밀번호 보내기
		public boolean resetPassword(String empNo, String empEm) {

			EmployeeVO employee = loginMapper.findEmployeeByNoAndEmail(empNo, empEm);

			if (employee == null) {
				return false;
			}

			// 임시 비밀번호 생성 및 암호화
			String tempPassword = generateTempPassword();
		    String encryptedPassword = passwordEncoder.encode(tempPassword);
		    mapper.updatePassword(empNo, encryptedPassword);

			// 이메일 발송
			String subject = "팀어센드 임시 비밀번호 안내";
			String content = "임시 비밀번호: " + tempPassword + "<br>로그인 후 비밀번호를 변경해주세요.";
			//mailClient.sendMail(empEm, subject, content);
			
			new Thread(() -> mailClient.sendMail(employee.getEmp_em(), subject, content)).start();
			return true;
		}*/
