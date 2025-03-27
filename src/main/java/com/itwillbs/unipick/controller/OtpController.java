package com.itwillbs.unipick.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.itwillbs.unipick.service.OtpService;
import com.itwillbs.unipick.service.SellerService;

@RestController
@RequestMapping("/api/otp")
public class OtpController {

    private final OtpService otpService;
    private final HttpSession session;
    @Autowired
    SellerService selservice;

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
    
    @PostMapping("/seller")
    public ResponseEntity<?> Otp(@RequestParam("otp") String otp, 
    							 @RequestParam("sel_id") String sel_id) {
        String userPhone = (String) session.getAttribute("userPhone");
        System.out.println("SADSA" + userPhone);
        System.out.println("sel"+sel_id);

        boolean verified = otpService.verifyOtp(userPhone, otp);
        System.out.println("OTP 검증 결과: " + verified);
        if (!verified) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                                 .body("인증번호가 올바르지 않습니다.");
        }
        Map<String, Object> sellerInfo = selservice.otpSellerInfo(userPhone, sel_id);
        System.out.println("Seller Info: " + sellerInfo);
        session.removeAttribute("userPhone");
        
        if (sellerInfo == null || sellerInfo.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                                 .body("아이디 및 휴대폰 번호를 다시 입력해주세요.");
        }
        return ResponseEntity.ok(sellerInfo);
    }
}
