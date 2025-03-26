package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class BankingController {
	
    @Value("${openbank.client_id}")
    private String clientId;

    @Value("${openbank.client_secret}")
    private String clientSecret;
    
    @GetMapping("close")
    public String close() {
    	return "<script>window.close();</script>";
    }
    @PostMapping("/getToken")
    public ResponseEntity<Map<String, Object>> getAccessToken(@RequestBody Map<String, String> request) {
        // 인증 코드 출력
        String code = request.get("code");
        System.out.println("saDDDDGDSFFASD: " + code);

        // RestTemplate 객체 생성
        RestTemplate restTemplate = new RestTemplate();

        // HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        System.out.println("shdkdfshiahsd" + clientId);
        System.out.println("kolknkjo" + clientSecret);

        // 요청 바디 설정
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("grant_type", "authorization_code");
        body.add("client_id", clientId);
        body.add("client_secret", clientSecret);
        body.add("redirect_uri", "http://localhost:8080/UNIPICK/close");
        body.add("code", code);

        // HTTP 요청 엔티티 생성
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(body, headers);

        // API 요청 및 응답 받기
        try {
            ResponseEntity<Map> response = restTemplate.exchange(
                    "https://testapi.openbanking.or.kr/oauth/2.0/token",
                    HttpMethod.POST,
                    requestEntity,
                    Map.class
            );

            if (response.getStatusCode().is2xxSuccessful()) {
                Map<String, Object> responseBody = response.getBody();
                System.out.println("ASDFGHJHKSARSTERTEEWFDSDS: " + responseBody);
                System.out.println("서버 응답: " + responseBody);  // 서버에서 반환한 응답 출력

                // Access Token이 있는지 확인
                if (responseBody != null && responseBody.containsKey("access_token")) {
                    System.out.println("Access Token: " + responseBody.get("access_token"));
                } else {
                    System.out.println("응답에 Access Token이 포함되지 않았습니다.");
                }

                // ResponseEntity로 반환
                return ResponseEntity.ok(responseBody);
            } else {
                // 응답 실패 시 상태 코드와 응답 메시지를 로그로 남깁니다.
                System.out.println("응답 오류: " + response.getStatusCode() + " 응답 내용: " + response.getBody());
                return ResponseEntity.status(response.getStatusCode()).body(Map.of("error", "API 호출 실패"));
            }
        } catch (Exception e) {
            System.out.println("API 요청 중 오류 발생: " + e.getMessage());
            e.printStackTrace();  // 예외의 상세 스택 트레이스를 출력
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error", "API 요청 실패"));
        }
    }
    
 // 인증된 계좌 들고오기
    @PostMapping("/getAccount")
    public ResponseEntity<Map<String, Object>> getAccountInfo(@RequestHeader("Authorization") String authorization) {
        
        // Bearer 토큰에서 실제 Access Token 추출
        String accessToken = authorization.replace("Bearer ", "");

        // user_seq_no 추출 (getToken에서 전달한 값)
//        String userSeqNo = requestBody.get("user_seq_no");

        // OpenBanking API 요청 URL
        String apiUrl = "https://testapi.openbanking.or.kr/v2.0/transfer/withdraw/fin_num";

        // HTTP 요청 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + accessToken);
        
        // 요청 본문 내용 
        Map<String, Object> reqtBodyData = new HashMap<>();
        
        reqtBodyData.put("bank_tran_id", "F123456789U4BC34239Z");
        reqtBodyData.put("cntr_account_type", "N");  
        reqtBodyData.put("cntr_account_num", "1101230000678");
        reqtBodyData.put("dps_print_content", "유니픽");
        reqtBodyData.put("fintech_use_num", "123456789012345678901234");
        reqtBodyData.put("tran_amt", "50000");
        reqtBodyData.put("tran_dtime", "20190910101921");
        reqtBodyData.put("req_client_name", "배지영");
        reqtBodyData.put("req_client_account_num", "1101230000678");
        reqtBodyData.put("req_client_num", "HONGGILDONG1234");
        reqtBodyData.put("transfer_purpose", "TR");

        // HTTP 요청 객체 생성
        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(reqtBodyData, headers);

        // RestTemplate을 이용해 API 호출
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity, Map.class);
        System.out.println("response: "+response);
        // 응답 확인 후 프론트엔드에 전달
        if (response.getStatusCode().is2xxSuccessful()) {
            System.out.println("response.getStatusCode()" + response.getStatusCode());
        	Map<String, Object> responseBody = response.getBody();
            
            if (responseBody != null && responseBody.containsKey("res_list")) {
                // OpenBanking API에서 받아온 계좌 정보
                List<Map<String, Object>> resList = (List<Map<String, Object>>) responseBody.get("res_list");
                
                // 계좌 정보가 없으면 에러 처리
                if (resList.isEmpty()) {
                    Map<String, Object> errorResponse = new HashMap<>();
                    errorResponse.put("success", false);
                    errorResponse.put("message", "계좌 정보가 존재하지 않습니다.");
                    return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
                }

                // 첫 번째 계좌 정보
                Map<String, Object> accData = resList.get(0);

                // 프론트엔드로 보낼 데이터 가공
                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("bank_nm", accData.get("bank_name"));
                result.put("acc_num", accData.get("account_num_masked")); // 계좌번호 (마스킹된 값)
//                result.put("user_seq_no", userSeqNo);

                return ResponseEntity.ok(result);
            }
        }

        // 실패 시 반환할 응답
        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("success", false);
        errorResponse.put("message", "계좌 정보를 불러오지 못했습니다.");
        return ResponseEntity.status(response.getStatusCode()).body(errorResponse);
    }

}
