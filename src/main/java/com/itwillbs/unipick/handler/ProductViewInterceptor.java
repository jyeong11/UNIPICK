package com.itwillbs.unipick.handler;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.itwillbs.unipick.service.SellerService2;

@Component
public class ProductViewInterceptor implements HandlerInterceptor {

    @Autowired
    private SellerService2 service;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("인터셉터 동작 테스트");
        String productId = request.getParameter("prd_cd");
        
        if (productId != null) {
            // 상품 코드로 판매자 ID 조회
            Map<String, Object> params = new HashMap<>();
            params.put("productId", productId);
            
            // 로그용 출력
            System.out.println("상품코드: " + productId);
            
            // 서비스를 통해 판매자 ID 조회 및 방문 기록
            service.logProductVisit(params);
        }
        return true;
    }
}
