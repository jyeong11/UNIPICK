package com.itwillbs.unipick.controller;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class BankingController {
	
    @Value("${openbank.client_id}")
    private String clientId;

    @Value("${openbank.client_secret}")
    private String clientSecret;
    
    @PostMapping("/getToken")
    public ResponseEntity<Map<String, Object>> getAccessToken(@RequestBody Map<String, String> request) {
        // 인증 코드 출력
        String code = request.get("code");
        System.out.println("saDDDDGDSFFASD: " + code);  // 클라이언트에서 받은 인증 코드

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
        body.add("redirect_uri", "http://localhost:8080/UNIPICK");
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

}
