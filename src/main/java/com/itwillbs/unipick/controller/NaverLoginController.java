package com.itwillbs.unipick.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.BuyerService2;
import com.itwillbs.unipick.service.NaverLoginService;

@Controller
public class NaverLoginController {

    @Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;

    @Value("${naver.redirect.uri}")
    private String redirectUri;

    @Autowired
    private NaverLoginService naverLoginService;

    // 로그인 버튼 눌렀을 때 이동할 URL
    @GetMapping("naver/login")
    public void naverLogin(HttpServletResponse response) throws IOException {
        String state = UUID.randomUUID().toString();
        String loginUrl = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
                + "&client_id=" + clientId
                + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8")
                + "&state=" + state;

        response.sendRedirect(loginUrl);
    }

    // 로그인 완료 후 콜백 처리
    @GetMapping("naver/callback")
    public String naverCallback(@RequestParam String code, @RequestParam String state, HttpSession session, Model model) {
        try {
            System.out.println("네이버 콜백 처리 시작");
            // access token 요청
            String accessToken = naverLoginService.getAccessToken(code, state);
            System.out.println("액세스 토큰 획득: " + accessToken);
    
            // 사용자 정보 요청
            Map<String, Object> userInfo = naverLoginService.getUserInfo(accessToken);
            System.out.println("사용자 정보 획득: " + userInfo);
            
            // DB 처리 - 회원가입 또는 로그인
            Map<String, Object> buyer = naverLoginService.processNaverLogin(userInfo);
            System.out.println("DB 처리 완료, 최종 정보: " + buyer);
    
            // 세션에 필요한 정보만 개별적으로 저장
            try {
                if (buyer != null) {
                    // 세션 저장 전에 타입 확인
                    Object buyNoObj = buyer.get("buy_no");
                    Object buyEmObj = buyer.get("buy_em");
                    Object buyNmObj = buyer.get("buy_nm");
                    
                    System.out.println("세션 저장 전 타입 확인:");
                    System.out.println("buy_no 타입: " + (buyNoObj != null ? buyNoObj.getClass().getName() : "null"));
                    System.out.println("buy_em 타입: " + (buyEmObj != null ? buyEmObj.getClass().getName() : "null"));
                    System.out.println("buy_nm 타입: " + (buyNmObj != null ? buyNmObj.getClass().getName() : "null"));
                    
                    // 값이 null이 아닌 경우에만 세션에 저장
                    if (buyNoObj != null) session.setAttribute("buy_no", buyNoObj);
                    if (buyEmObj != null) {
                        session.setAttribute("buy_em", buyEmObj); // 네이버 로그인용
                        session.setAttribute("buyEm", buyEmObj.toString()); // 기존 로그인 인터셉터용
                    }
                    if (buyNmObj != null) session.setAttribute("buy_nm", buyNmObj);
                    session.setAttribute("isLoggedIn", true);
                    
                    System.out.println("세션에 정보 저장 완료");
                } else {
                    System.out.println("buyer 객체가 null임");
                }
            } catch (Exception e) {
                System.out.println("세션 저장 중 오류 발생: " + e.getMessage());
                e.printStackTrace();
            }
            
            System.out.println("네이버 콜백 처리 완료, naverLoginSuccess 뷰로 이동");
            return "buyer/naverLoginSuccess"; // 바로 팝업 창 관리 페이지로 이동
        } catch (Exception e) {
            System.out.println("네이버 로그인 처리 중 예외 발생: " + e.getClass().getName() + " - " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("msg", "로그인 처리 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("url", "/buyer/buyerLogin");
            return "redirect";
        }
    }
    
    // 네이버 로그인 팝업 창 닫기 처리
    @GetMapping("naver/loginSuccess")
    public String naverLoginSuccess() {
        return "buyer/naverLoginSuccess"; // 팝업 창 닫고 부모 창 새로고침하는 페이지
    }
}
