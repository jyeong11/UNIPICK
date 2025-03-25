package com.itwillbs.unipick.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.unipick.service.OtpService;

@RestController
@RequestMapping("/api/otp")
public class OtpController {

    private final OtpService otpService;

    public OtpController(OtpService otpService) {
        this.otpService = otpService;
    }

    // OTP 전송 요청
    @PostMapping("/send")
    public ResponseEntity<String> sendOtp(@RequestParam("phone") String phone) {
        try {
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
    public ResponseEntity<String> verifyOtp(@RequestParam("phone") String phone,
                                            @RequestParam("otp") String otp) {
        boolean verified = otpService.verifyOtp(phone, otp);
        if (verified) {
            return ResponseEntity.ok("인증이 완료되었습니다.");
        } else {
            return ResponseEntity.badRequest().body("인증번호가 올바르지 않거나 만료되었습니다.");
        }
    }
}
