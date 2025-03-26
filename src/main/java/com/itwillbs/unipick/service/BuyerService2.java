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
        String password = (String) buyerData.get("buyer_pw");
        
        // 비밀번호 유효성 검사
        if (password == null || !validatePassword(password)) {
            return false; // 비밀번호가 null이거나 유효하지 않으면 등록 실패
        }

        // 추가적으로, 다른 필수 값들 (예: 이메일, 전화번호 등)이 null인지 체크
        String email = (String) buyerData.get("buyer_em");
        if (email == null || email.isEmpty()) {
            return false; // 이메일이 비어있으면 등록 실패
        }
        
        // 비밀번호 및 기타 필수 정보들이 유효한 경우 DB에 사용자 정보를 삽입
        try {
            mapper.insertBuyer(buyerData);
            return true; // 등록 성공
        } catch (Exception e) {
            e.printStackTrace(); // 예외 발생 시 로그 출력
            return false; // 예외 발생 시 등록 실패
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
