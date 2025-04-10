package com.itwillbs.unipick.handler;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.itwillbs.unipick.service.BuyerService;
import com.itwillbs.unipick.service.SellerService2;

@Component
public class ProductViewInterceptor implements HandlerInterceptor {

    @Autowired
    private SellerService2 service;
    @Autowired
    private BuyerService buyservice;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("=== 상품 조회 인터셉터 동작 시작 ===");
        
        // URL에서 상품 코드와 판매자 이름 추출
        String productId = request.getParameter("prd_cd");
        String sellerNm = request.getParameter("sel_nm");
        
        if (productId != null && sellerNm != null) {
            // 상품 코드와 판매자 이름이 모두 있는 경우에만 처리
            Map<String, Object> params = new HashMap<>();
            params.put("productId", productId);
            params.put("sellerNm", sellerNm);
            
            // 로그용 출력
            System.out.println("=== 방문 기록 저장 시도 ===");
            System.out.println("상품코드: " + productId);
            System.out.println("판매자명: " + sellerNm);
            
            try {
                // 서비스를 통해 판매자 ID 조회 및 방문 기록
                service.logProductVisit(params);
                System.out.println("방문 기록 저장 성공");
                
                // 최근 본 상품 저장
                buyservice.registerRecentlyPrd(request, params);
                System.out.println("최근 본 상품 저장 성공");
            } catch (Exception e) {
                System.err.println("방문 기록 저장 실패: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.out.println("방문 기록 저장 실패: 상품코드 또는 판매자명 누락");
            if (productId == null) System.out.println("상품코드가 null입니다.");
            if (sellerNm == null) System.out.println("판매자명이 null입니다.");
        }
        
        System.out.println("=== 상품 조회 인터셉터 동작 완료 ===");
        return true;
    }
}
