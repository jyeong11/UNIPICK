package com.itwillbs.unipick.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.BuyerMapper2;

@Service
public class BuyerService2 {

    @Autowired
    BuyerMapper2 mapper;
    
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
    	
    	System.out.println("✅ 회원가입 데이터: " + buyerData);
    	
        if (buyerData == null || buyerData.isEmpty()) {
        	  System.out.println("❌ buyerData가 비어 있음");
            return false; // buyerData가 null 또는 비어있으면 등록 실패
        }

        // 입력된 데이터에서 비밀번호를 가져옴
        String password = (String) buyerData.get("buy_pw");
        
        // 비밀번호 유효성 검사
        if (password == null || !validatePassword(password)) {
        	 System.out.println("❌ 비밀번호 검증 실패: " + password);
            return false; // 비밀번호가 null이거나 유효하지 않으면 등록 실패
        }

        // 추가적으로, 다른 필수 값들 (예: 이메일, 전화번호 등)이 null인지 체크
        String email = (String) buyerData.get("buy_em");
        if (email == null || email.isEmpty()) {
        	
        	 System.out.println("❌ 이메일 검증 실패: " + email);
            return false; // 이메일이 비어있으면 등록 실패
        }
        
        // 약관 동의 값 Boolean -> Integer 변환
        Integer accTa = Boolean.parseBoolean(String.valueOf(buyerData.get("acc_ta"))) ? 1 : 0;
        Integer accPa = Boolean.parseBoolean(String.valueOf(buyerData.get("acc_pa"))) ? 1 : 0;
        Integer accMa = Boolean.parseBoolean(String.valueOf(buyerData.get("acc_ma"))) ? 1 : 0;

        buyerData.put("acc_ta", accTa);
        buyerData.put("acc_pa", accPa);
        buyerData.put("acc_ma", accMa);

        System.out.println("✅ 변환된 회원가입 데이터: " + buyerData);
        System.out.println("✅ 회원가입 데이터: " + buyerData);
        System.out.println("✅ 약관 동의 여부 - acc_ta: " + accTa + ", acc_pa: " + accPa + ", acc_ma: " + accMa);

        
        // 비밀번호 및 기타 필수 정보들이 유효한 경우 DB에 사용자 정보를 삽입
        try {
            int result = mapper.insertBuyer(buyerData);
            System.out.println("✅ INSERT 결과: " + result);
            return result > 0;
        } catch (Exception e) {
            System.out.println("❌ INSERT 중 예외 발생");
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
}
