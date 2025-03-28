package com.itwillbs.unipick.service;

import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.handler.MailClient;
import com.itwillbs.unipick.mapper.BuyerMapper2;

@Service
public class BuyerService2 {

    @Autowired
    BuyerMapper2 mapper;
    
//    @Autowired
//	private PasswordEncoder passwordEncoder;
    
    @Autowired
	private MailClient mailClient;
    
    // 로그인 메서드
    public Map<String, Object> BuyerLogin(Map<String, Object> logindata) {
        return mapper.BuyerLogin(logindata);
    }

    // 이메일 중복 검사 메서드
    public boolean BuyEmail(String email) {
        return mapper.BuyEmail(email) > 0;
    }
    
    // 비밀번호 유효성 검사 메서드
    public boolean validatePassword(String password) {
    	System.out.println("❗ 비밀번호 검증 중: " + password);
        if (password == null) {
            return false; // 비밀번호가 null일 경우 유효하지 않음
        }

        // 비밀번호 규칙: 8~16자, 영문자, 숫자, 특수문자(!@#$%)
        String regex = "^[A-Za-z0-9!@#$%]{8,16}$";
        return password.matches(regex);
    }

    // 회원 등록 메서드
    public boolean registerBuyer(Map<String, Object> buyerData) {
    	
        if (buyerData == null || buyerData.isEmpty()) {
            return false; // buyerData가 null 또는 비어있으면 등록 실패
        }

        // 입력된 데이터에서 비밀번호를 가져옴
        String password = (String) buyerData.get("buy_pw");
        
        // 비밀번호 유효성 검사
        if (password == null || !validatePassword(password)) {
            return false; // 비밀번호가 null이거나 유효하지 않으면 등록 실패
        }

        // 추가적으로, 다른 필수 값들 (예: 이메일, 전화번호 등)이 null인지 체크
        String email = (String) buyerData.get("buy_em");
        if (email == null || email.isEmpty()) {
            return false; // 이메일이 비어있으면 등록 실패
        }
        
        // 약관 동의 값 Boolean -> Integer 변환
        Integer accTa = Boolean.parseBoolean(String.valueOf(buyerData.get("acc_ta"))) ? 1 : 0;
        Integer accPa = Boolean.parseBoolean(String.valueOf(buyerData.get("acc_pa"))) ? 1 : 0;
        Integer accMa = Boolean.parseBoolean(String.valueOf(buyerData.get("acc_ma"))) ? 1 : 0;

        buyerData.put("acc_ta", accTa);
        buyerData.put("acc_pa", accPa);
        buyerData.put("acc_ma", accMa);

        // 비밀번호 및 기타 필수 정보들이 유효한 경우 DB에 사용자 정보를 삽입
        try {
            int result = mapper.insertBuyer(buyerData);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 세션에 약관 동의 정보 저장 메서드
    public boolean saveBuyerAgreement(HttpSession session, boolean acc_ta, boolean acc_pa, boolean acc_ma) {
        // 세션에 약관 동의 정보를 저장
        session.setAttribute("acc_ta", acc_ta);
        session.setAttribute("acc_pa", acc_pa);
        session.setAttribute("acc_ma", acc_ma);
        
        // 저장된 값 확인 후 반환
        return acc_ta && acc_pa && acc_ma;
    }
    
    public Map<String, Object> findEmployeeByNameAndPhone(String buyNm, String buyPh) {
        Map<String, Object> employee = mapper.selectEmployeeByNameAndPhone(buyNm, buyPh);
        
        if (employee != null) {
            return employee; 
        }
        
        return null; 
    }

 // 비밀번호 보내기
    @Async  // 이메일 전송을 비동기 처리
    public boolean resetPassword(String buyNm, String buyEm) {
        Map<String, Object> user = mapper.findEmployeeByNoAndEmail(buyNm, buyEm);
        if (user == null || user.isEmpty()) {
            return false;
        }

        // 임시 비밀번호 생성
        String tempPassword = generateTempPassword();

        // DB 업데이트
        mapper.updatePassword(buyEm, tempPassword);

        // 이메일 전송 (이름이 아닌 이메일 전달)
        sendResetEmail((String) user.get("buy_em"), tempPassword);
        return true;
    }

    private void sendResetEmail(String buyEm, String tempPassword) {
        // 이메일이 null이거나 빈 값이면 전송하지 않음
        if (buyEm == null || buyEm.trim().isEmpty()) {
            System.out.println("🚨 오류: 이메일 주소가 비어 있음");
            return;
        }

        String subject = "유니픽 임시 비밀번호 안내";
        String content = "임시 비밀번호: " + tempPassword + "<br>로그인 후 비밀번호를 변경해주세요.";

        try {
            mailClient.sendMail(buyEm, subject, content); // ✅ 올바른 값 전달
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String generateTempPassword() {
        return UUID.randomUUID().toString().substring(0, 8);
    }

}
