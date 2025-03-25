package com.itwillbs.unipick.service;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.OtpMapper;

// coolsms SDK의 Message 클래스는 해당 API 문서에 맞게 구현해 주세요.
class Message {
    private String apiKey;
    private String apiSecret;
    
    public Message(String apiKey, String apiSecret) {
        this.apiKey = apiKey;
        this.apiSecret = apiSecret;
    }
    
    public JSONObject send(Map<String, String> params) throws Exception {
        // 실제 SMS 전송 로직 구현 (예시로 성공 결과를 반환)
        return new JSONObject("{\"result\":\"success\"}");
    }
}

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
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    // OTP 발송 및 DB 저장
    public void sendOtp(String phone) {
        String otp = generateOTP();
        // 현재 시각 기준 10분 후 만료
        Date expiration = new Date(System.currentTimeMillis() + 10 * 60 * 1000);

        // 기존 OTP 삭제 후 새로 저장
        otpMapper.deleteByPhoneNumber(phone);

        // XML 매퍼와 키 이름이 일치하도록 변경 (pho_nm, pho_otp, pho_at)
        Map<String, Object> verification = new HashMap<>();
        verification.put("pho_nm", phone);
        verification.put("pho_otp", otp);
        verification.put("pho_at", expiration);

        otpMapper.insertVerification(verification);

        // SMS 전송
        sendSms(phone, "인증번호: " + otp);
    }

    // CoolSMS API를 활용한 SMS 전송
    private void sendSms(String phone, String message) {
        Message coolsms = new Message(apiKey, apiSecret);
        
        
        Map<String, String> params = new HashMap<>();
        params.put("to", phone);
        params.put("from", sender);
        params.put("text", message);
        params.put("type", "SMS");

        try {
            JSONObject result = coolsms.send(params);
            System.out.println("SMS 전송 결과: " + result.toString());
            String status = result.getString("result");  // result로 변경
         // result 필드를 확인하여 success인지 확인
            if (result.getString("result").equals("success")) {
                System.out.println("SMS 전송 성공");
            } else {
                // 실패 시, 오류 코드 및 메시지 출력
                String errorMessage = result.optString("error_message", "알 수 없는 오류");
                String errorCode = result.optString("error_code", "알 수 없는 오류 코드");
                System.out.println("SMS 전송 실패, 오류 메시지: " + errorMessage + ", 오류 코드: " + errorCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // OTP 검증
    public boolean verifyOtp(String phone, String otp) {
        Map<String, Object> verification = otpMapper.selectByPhoneNumber(phone);
        if (verification == null) {
            return false;
        }
        
        Date expiration = (Date) verification.get("pho_at");
        // 만료 체크
        if (expiration.before(new Date())) {
            otpMapper.deleteByPhoneNumber(phone);
            return false;
        }
        // OTP 일치 여부 확인
        if (verification.get("pho_otp").equals(otp)) {
            otpMapper.deleteByPhoneNumber(phone);
            return true;
        }
        return false;
    }
}
