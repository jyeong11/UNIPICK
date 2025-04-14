package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.List;
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
    public ResponseEntity<Map<String, Object>> kakaoPayReady(HttpSession session,
    														 @RequestBody Map<String, Object> req) {
    	String amount = String.valueOf(req.get("amount"));
    	List<Map<String, Object>> productList = (List<Map<String, Object>>) req.get("productList");
    	
    	session.setAttribute("productList", productList);
    	session.setAttribute("amount", amount);
        String referer1 = "http://c2d2410t2p2.itwillbs.com/UNIPICK/orderDetail" ;
        String referer2 = "http://c2d2410t2p2.itwillbs.com/UNIPICK/productOrder" ;
        
        // item_name은 대표 상품 + 외 n건 식으로 표기
        String itemName = (String) productList.get(0).get("prd_cd");
        if (productList.size() > 1) {
            itemName += " 외 " + (productList.size() - 1) + "건";
        }
        Map<String, String> shippingDetails = new HashMap<>();
        shippingDetails.put("shipping_name", (String) req.get("shipping_name"));
        shippingDetails.put("shipping_telephone", (String) req.get("shipping_telephone"));
        shippingDetails.put("shipping_zipcode", (String) req.get("shipping_zipcode"));
        shippingDetails.put("shipping_address", (String) req.get("shipping_address"));
        shippingDetails.put("shipping_addDetail", (String) req.get("shipping_addDetail"));
        shippingDetails.put("shipping_memo", (String) req.get("shipping_memo"));
        
        // 들고온 값들을 세션에 저장
        for (Map.Entry<String, String> entry : shippingDetails.entrySet()) {
            session.setAttribute(entry.getKey(), entry.getValue());
        }

        
        // 카카오페이 결제 요청 파라미터 설정
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "order_" + System.currentTimeMillis());
        params.add("partner_user_id", "user1234");
        params.add("item_name", itemName);
        params.add("quantity", String.valueOf(productList.size())); 
        params.add("total_amount", amount);
        params.add("tax_free_amount", "0");
        params.add("approval_url", "http://c2d2410t2p2.itwillbs.com/UNIPICK/pay/success?returnUrl=" + referer1);
        params.add("cancel_url", "http://c2d2410t2p2.itwillbs.com/UNIPICK/pay/cancel?returnUrl=" + referer2 + itemName);
        params.add("fail_url", "http://c2d2410t2p2.itwillbs.com/UNIPICK/pay/fail?returnUrl=" + referer2 + itemName);
        
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
        System.out.println("responseBody" + responseBody);
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
    	
    	System.out.println("tid!@@!" + (String)session.getAttribute("tid"));
    	
        // 결제 승인 요청
    	MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    	params.add("cid", "TC0ONETIME");
    	params.add("tid", (String)session.getAttribute("tid"));
    	params.add("partner_order_id", (String)session.getAttribute("partner_order_id"));
    	params.add("partner_user_id", (String)session.getAttribute("partner_user_id"));
    	params.add("pg_token", pgToken);
    	
    	System.out.println("params: " + params.toString());
    	
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
        
        
        // 주문& 주문 상세등록
        buyService.insertOrder(orderData);
        Object ordIdObj = orderData.get("ord_id");
        String ordId = String.valueOf(ordIdObj);
        
        
        if (response.getStatusCode() == HttpStatus.OK) {
        	List<Map<String, Object>> productList = (List<Map<String, Object>>) session.getAttribute("productList");
        	 String odd_am = (String)session.getAttribute("amount");
        	 System.out.println("productList" + productList);
        	 for (Map<String, Object> product : productList) {
	    		 String prdCd = (String) product.get("prd_cd");
	 	         String sizNm = (String) product.get("siz_nm");
	 	         String clrNm = (String) product.get("clr_nm");
	 	         String qty = String.valueOf(product.get("qty")); 

    	        // 옵션 ID 찾기
    	        Map<String, Object> optIdMap = buyService.getOptionId(sizNm, clrNm, prdCd);
    	        Object optId = optIdMap.get("opt_id");
    	        System.out.println("optId" + optId);

    	        // 주문 상세 저장
    	        Map<String, Object> detailMap = new HashMap<>();
    	        detailMap.put("ord_id", ordId);
    	        detailMap.put("prd_cd", prdCd);
    	        detailMap.put("opt_id", optId);
    	        detailMap.put("qty", qty);
    	        detailMap.put("odd_am", odd_am);
    	        
    	        buyService.insertOrderDetail(detailMap);
        	 }
            
        	String realreturnUrl = returnUrl + "?ord_id=" + ordId;
        	return ResponseEntity.ok("<script>window.opener.location.href='" + realreturnUrl + "'; window.close();</script>");
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
