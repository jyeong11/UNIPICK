package com.itwillbs.unipick.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.unipick.mapper.NaverMapper;

@Service
public class NaverLoginService {

    @Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;

    @Value("${naver.redirect.uri}")
    private String redirectUri;
    
    @Autowired
    private NaverMapper naverMapper;

    public String getAccessToken(String code, String state) throws Exception {
        String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&code=" + code
                + "&state=" + state;

        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String response = br.lines().collect(Collectors.joining());
        br.close();

        // access_token 추출
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.readValue(response, new TypeReference<>() {});
        return (String) map.get("access_token");
    }

    public Map<String, Object> getUserInfo(String accessToken) throws Exception {
        String apiURL = "https://openapi.naver.com/v1/nid/me";

        HttpURLConnection con = (HttpURLConnection) new URL(apiURL).openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String response = br.lines().collect(Collectors.joining());
        br.close();

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> result = mapper.readValue(response, new TypeReference<>() {});
        return (Map<String, Object>) result.get("response"); // 사용자 정보만 반환
    }
    
    @Transactional
    public Map<String, Object> processNaverLogin(Map<String, Object> userInfo) {
        String email = (String) userInfo.get("email");
        
        System.out.println("네이버 로그인 정보: " + userInfo);
        
        // 이메일로 회원 조회
        Map<String, Object> buyer = naverMapper.findByEmail(email);
        
        // 회원이 없으면 회원 가입 처리
        if (buyer == null) {
            System.out.println("네이버 로그인: 신규 회원 가입 진행");
            Map<String, Object> newUser = new HashMap<>();
            newUser.put("buy_em", email);
            newUser.put("buy_nm", userInfo.get("name"));
            
            // mobile 값이 없을 경우 처리
            String mobile = "";
            if (userInfo.get("mobile") != null) {
                mobile = userInfo.get("mobile").toString().replaceAll("-", "");
            }
            newUser.put("buy_ph", mobile);
            
            // 임시 비밀번호 생성 (UUID 앞 8자리 사용)
            String tempPassword = UUID.randomUUID().toString().substring(0, 8);
            newUser.put("buy_pw", tempPassword); // 비밀번호 암호화 없이 저장
            
            // 회원 등록
            try {
                naverMapper.insertNaverUser(newUser);
                System.out.println("네이버 로그인: 신규 회원 등록 성공");
            } catch (Exception e) {
                System.out.println("네이버 로그인: 신규 회원 등록 실패 - " + e.getMessage());
                e.printStackTrace();
            }
            
            // 새로 생성된 회원 정보 조회
            buyer = naverMapper.findByEmail(email);
        } else {
            System.out.println("네이버 로그인: 기존 회원 로그인");
        }
        
        System.out.println("네이버 로그인: 최종 반환 정보 - " + buyer);
        return buyer;
    }
}