package com.itwillbs.unipick.controller;

import java.math.BigInteger;
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

import com.itwillbs.unipick.service.BuyerService;

import kotlin.RequiresOptIn;
import lombok.RequiredArgsConstructor;


@RestController
@RequestMapping("pay")
public class PayController {

    private final RestTemplate restTemplate;
    @Autowired
    public PayController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
    @Autowired
    BuyerService buyService;
    
    private final String adminKey = "3aa13e550703f35b24a4886d3254644d"; // 카카오페이 Admin 키

    // 1. 결제 준비 API - 결제 요청
    @PostMapping("/ready")
    public ResponseEntity<Map<String, Object>> kakaoPayReady(HttpSession session, @RequestBody Map<String, Object> req) {
    	int amount = (int)req.get("amount");
        String prd_cd = (String)req.get("prd_cd");
        String referer1 = "http://localhost:8080/UNIPICK/orderDetail" ;
        String referer2 = "http://localhost:8080/UNIPICK/productOrder" ;
        
        String shipName = (String)req.get("shipping_name");
        String shiptelephone = (String)req.get("shipping_telephone");
        String shipzipcode = (String)req.get("shipping_zipcode");
        String shipadd = (String)req.get("shipping_address");
        String shipaddDeatil = (String)req.get("shipping_addDetail");
        String shipmemo = (String)req.get("shipping_memo");
        String siz_nm = (String)req.get("siz_nm");
        String clr_nm = (String)req.get("clr_nm");
        
        session.setAttribute("shipping_name", shipName);
        session.setAttribute("shipping_telephone", shiptelephone);
        session.setAttribute("shipping_zipcode", shipzipcode);
        session.setAttribute("shipping_address", shipadd);
        session.setAttribute("shipping_addDetail", shipaddDeatil);
        session.setAttribute("shipping_memo", shipmemo);
        session.setAttribute("siz_nm", siz_nm);
        session.setAttribute("clr_nm", clr_nm);
        session.setAttribute("prd_cd", prd_cd);

        
        // 카카오페이 결제 요청 파라미터 설정
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "order_" + System.currentTimeMillis());
        params.add("partner_user_id", "user1234");
        params.add("item_name", prd_cd);
        params.add("quantity", "1");
        params.add("total_amount", String.valueOf(amount));
        params.add("tax_free_amount", "0");
        params.add("approval_url", "http://localhost:8080/UNIPICK/pay/success?returnUrl=" + referer1);
        params.add("cancel_url", "http://localhost:8080/UNIPICK/pay/cancel?returnUrl=" + referer2 + prd_cd);
        params.add("fail_url", "http://localhost:8080/UNIPICK/pay/fail?returnUrl=" + referer2 + prd_cd);
        
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

        Map<String, Object> orderData = response.getBody();
        orderData.put("shipping_name", (String)session.getAttribute("shipping_name"));
        orderData.put("shipping_telephone", (String)session.getAttribute("shipping_telephone"));
        orderData.put("shipping_zipcode", (String)session.getAttribute("shipping_zipcode"));
        orderData.put("shipping_address", (String)session.getAttribute("shipping_address"));
        orderData.put("shipping_addDetail", (String)session.getAttribute("shipping_addDetail"));
        orderData.put("shipping_memo", (String)session.getAttribute("shipping_memo"));
        orderData.put("buy_em", (String)session.getAttribute("buyEm"));
        String sizNm = (String) session.getAttribute("siz_nm");
        String clrNm = (String) session.getAttribute("clr_nm");
        String prdCd = (String) session.getAttribute("prd_cd");
        

        if (response.getStatusCode() == HttpStatus.OK) {
        	// 옵션 id 찾기
        	Map<String, Object> otpId = buyService.getOptionId(sizNm, clrNm, prdCd);
            orderData.put("otp_id", otpId.get("opt_id"));
            
        	// 주문& 주문 상세등록
        	buyService.insertOrder(orderData);
        	BigInteger ordIdBigInt = (BigInteger) orderData.get("ord_id");
        	long ordId = ordIdBigInt.longValue();
        	String realreturnUrl = returnUrl + "?ord_id=" + ordId;
        	return ResponseEntity.ok("<script>alert('결제가 완료되었습니다!'); window.opener.location.href='" + realreturnUrl + "'; window.close();</script>");
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
