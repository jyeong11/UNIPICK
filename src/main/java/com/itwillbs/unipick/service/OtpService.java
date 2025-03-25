package com.itwillbs.unipick.service;

import java.io.UnsupportedEncodingException;
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

// coolsms SDK의 Message 클래스는 해당 API 문서에 맞게 구현해 주세요.
class Message {
    private String apiKey;
    private String apiSecret;
    
    DefaultMessageService messageService;

    public Message(String apiKey, String apiSecret) {
        this.messageService = null;
		this.apiKey = apiKey;
        this.apiSecret = apiSecret;
        this.messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecret, "https://api.coolsms.co.kr");
    }
    
    public JSONObject send(Map<String, String> params) throws Exception {
        // 실제 SMS 전송 로직 구현 (예시로 성공 결과를 반환)
        return new JSONObject("{\"result\":\"success\"}");
    }
}

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
        net.nurigo.sdk.message.model.Message coolsms = new net.nurigo.sdk.message.model.Message();
        coolsms.setTo(phone);
        coolsms.setFrom(sender);
        coolsms.setText(message);
        coolsms.setType(MessageType.SMS);
        Message message2 = new Message(apiKey, apiSecret);
        SingleMessageSentResponse response = message2.messageService.sendOne(new SingleMessageSendingRequest(coolsms));
        
        
        Map<String, String> params = new HashMap<>();
        params.put("to", phone);
        params.put("from", sender);
        params.put("text", message);
        params.put("type", "SMS");

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
