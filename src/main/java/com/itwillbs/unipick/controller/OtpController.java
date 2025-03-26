package com.itwillbs.unipick.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

import com.itwillbs.unipick.service.OtpService;

@RestController
@RequestMapping("/api/otp")
public class OtpController {

    private final OtpService otpService;
    private final HttpSession session;

    public OtpController(OtpService otpService, HttpSession session) {
        this.otpService = otpService;
        this.session = session;
    }

    // OTP 전송 요청
    @PostMapping("/send")
    public ResponseEntity<String> sendOtp(@RequestParam("phone") String phone) {
        try {
            session.setAttribute("userPhone", phone); // 세션에 전화번호 저장
            otpService.sendOtp(phone);
            return ResponseEntity.ok("인증번호가 전송되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("인증번호 전송에 실패하였습니다.");
        }
    }

    // OTP 검증 요청
    @PostMapping("/verify")
    public ResponseEntity<String> verifyOtp(@RequestParam("otp") String otp) {
        String userPhone = (String) session.getAttribute("userPhone");
        if (userPhone == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                 .body("세션에서 전화번호를 찾을 수 없습니다.");
        }
        
        boolean verified = otpService.verifyOtp(userPhone, otp);
        if (verified) {
            session.removeAttribute("userPhone"); // 검증 성공 시 세션 삭제
            return ResponseEntity.ok("인증이 완료되었습니다.");
        } else {
            return ResponseEntity.badRequest()
                                 .body("인증번호가 올바르지 않거나 만료되었습니다.");
        }
    }
    
    @PostMapping("/setPhoneNumber")
    public ResponseEntity<String> setPhoneNumber(@RequestParam("phone") String phone) {
        session.setAttribute("phoneNumber", phone); // 세션에 휴대폰 번호 저장
        return ResponseEntity.ok("휴대폰 번호 저장 성공");
    }
}
