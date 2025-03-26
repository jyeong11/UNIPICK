package com.itwillbs.unipick.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.OtpMapper;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.MessageType;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@PropertySource("classpath:application.properties")
@Service
public class OtpService {

    private final OtpMapper otpMapper;

    @Value("${coolsms.api_key}")
    private String apiKey;
    
    @Value("${coolsms.api_secret}")
    private String apiSecret;
    
    @Value("${coolsms.sender}")
    private String sender;

    public OtpService(OtpMapper otpMapper) {
        this.otpMapper = otpMapper;
    }

    // 6자리 OTP 생성
    public String generateOTP() {
        return String.valueOf(100000 + new Random().nextInt(900000));
    }

    // OTP 발송 및 DB 저장
    public void sendOtp(String phone) {
        String otp = generateOTP();
        Date expiration = new Date(System.currentTimeMillis() + 10 * 60 * 1000); // 10분 후 만료

        // 기존 OTP가 있는지 확인
        Map<String, Object> existingOtp = otpMapper.selectByPhoneNumber(phone);
        if (existingOtp == null) {
            // INSERT
            Map<String, Object> verification = new HashMap<>();
            verification.put("pho_nm", phone);
            verification.put("pho_otp", otp);
            verification.put("pho_at", expiration);
            otpMapper.insertVerification(verification);
        } else {
            // UPDATE
            otpMapper.updateVerification(phone, otp, expiration);
        }

        // SMS 전송
        sendSms(phone, "인증번호: " + otp);
    }

    // CoolSMS API를 활용한 SMS 전송
    private void sendSms(String phone, String message) {
        try {
            net.nurigo.sdk.message.model.Message coolsms = new net.nurigo.sdk.message.model.Message();
            coolsms.setTo(phone);
            coolsms.setFrom(sender);
            coolsms.setText(message);
            coolsms.setType(MessageType.SMS);

            DefaultMessageService messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecret, "https://api.coolsms.co.kr");
            SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(coolsms));
        } catch (Exception e) {
            System.out.println("SMS 전송 실패: " + e.getMessage());
        }
    }

    // OTP 검증
    public boolean verifyOtp(String phone, String otp) {
        Map<String, Object> verification = otpMapper.selectByPhoneNumber(phone);
        if (verification == null) {
            System.out.println("OTP 정보 없음: " + phone);
            return false;
        }
        
        Date expiration = (Date) verification.get("pho_at");
        if (expiration.before(new Date())) {
            System.out.println("OTP 만료됨: " + phone);
            otpMapper.deleteByPhoneNumber(phone);
            return false;
        }
        
        String savedOtp = String.valueOf(verification.get("pho_otp"));
        if (savedOtp.equals(otp)) {
            otpMapper.deleteByPhoneNumber(phone);
            return true;
        }
        return false;
    }
}
