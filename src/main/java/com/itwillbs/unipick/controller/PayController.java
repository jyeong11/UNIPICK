package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;


@RestController
@RequestMapping("pay")
public class PayController {

    private final RestTemplate restTemplate;
    @Autowired
    public PayController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
    private final String adminKey = "3aa13e550703f35b24a4886d3254644d"; // 카카오페이 Admin 키

    // 1. 결제 준비 API - 결제 요청
    @PostMapping("/ready")
    public ResponseEntity<Map<String, Object>> kakaoPayReady(HttpSession session, @RequestBody Map<String, Object> req) {
        int amount = (int)req.get("amount");
        String prdCd = (String)req.get("prdCd");
        String referer = "http://localhost:8080/UNIPICK/orderSuccess?prd_cd=" + prdCd;

        // 카카오페이 결제 요청 파라미터 설정
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("cid", "TC0ONETIME"); // 테스트 CID
        params.add("partner_order_id", "order_" + System.currentTimeMillis());
        params.add("partner_user_id", "user1234");
        params.add("item_name", "상품명");
        params.add("quantity", "1");
        params.add("total_amount", String.valueOf(amount));
        params.add("tax_free_amount", "0");
        params.add("approval_url", "http://localhost:8080/UNIPICK/pay/success?returnUrl=" + referer);
        params.add("cancel_url", "http://localhost:8080/UNIPICK/pay/cancel?returnUrl=" + referer);
        params.add("fail_url", "http://localhost:8080/UNIPICK/pay/fail?returnUrl=" + referer);
        // 카카오페이 API 호출
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + adminKey);
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(params, headers);
        ResponseEntity<Map> response = restTemplate.exchange(
            "https://kapi.kakao.com/v1/payment/ready",
            HttpMethod.POST,
            requestEntity,
            Map.class
        );
        Map<String, Object> responseBody = response.getBody();
        session.setAttribute("tid", responseBody.get("tid"));
        session.setAttribute("partner_order_id", params.getFirst("partner_order_id"));
        session.setAttribute("partner_user_id", params.getFirst("partner_user_id"));
        
        return ResponseEntity.ok(responseBody);
    }

 // 2. 결제 승인 처리 API
    @GetMapping("/success")
    public ResponseEntity<String> kakaoPaySuccess(@RequestParam("pg_token") String pgToken,
                                                  @RequestParam("returnUrl") String returnUrl,
                                                  HttpSession session) {
        // 결제 승인 요청
    	MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    	params.add("cid", "TC0ONETIME");
    	params.add("tid", (String)session.getAttribute("tid"));
    	params.add("partner_order_id", (String)session.getAttribute("partner_order_id"));
    	params.add("partner_user_id", (String)session.getAttribute("partner_user_id"));
    	params.add("pg_token", pgToken);

        
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + adminKey);
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);  

        // 폼 데이터로 전송하기 위해 Map<String, String>을 사용
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(params, headers);
        
        // 카카오 API 호출
        ResponseEntity<Map> response = restTemplate.exchange(
            "https://kapi.kakao.com/v1/payment/approve",
            HttpMethod.POST,
            requestEntity,
            Map.class
        );

        System.out.println("!@#!@$!@");
        System.out.println(response);

        if (response.getStatusCode() == HttpStatus.OK) {
        	return ResponseEntity.ok("<script>alert('결제가 완료되었습니다!'); window.opener.location.href='" + returnUrl + "'; window.close();</script>");
        } else {
        	return ResponseEntity.ok("<script>alert('결제 승인에 실패했습니다.'); window.close();</script>");
        }
    }


    // 3. 결제 취소 처리 API
    @GetMapping("/cancel")
    public ResponseEntity<String> kakaoPayCancel(@RequestParam("returnUrl") String returnUrl) {
        return ResponseEntity.ok("<script>alert('결제가 취소되었습니다. 다시 시도해주세요.'); window.location.href='" + returnUrl + "';</script>");
    }

    // 4. 결제 실패 처리 API
    @GetMapping("/fail")
    public ResponseEntity<String> kakaoPayFail(@RequestParam("returnUrl") String returnUrl) {
        return ResponseEntity.ok("<script>alert('결제에 실패했습니다. 다시 시도해주세요.'); window.location.href='" + returnUrl + "';</script>");
    }
}
