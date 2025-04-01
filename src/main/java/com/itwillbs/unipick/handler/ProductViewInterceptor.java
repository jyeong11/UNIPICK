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
        System.out.println("인터셉터 동작 시작");
        String productId = request.getParameter("prd_cd");
        String sellerId = request.getParameter("sel_nm");
        
        System.out.println("상품 ID: " + productId);
        System.out.println("판매자 ID: " + sellerId);

        if (productId != null && sellerId != null) {
            Map<String, Object> params = new HashMap<>();
            params.put("sellerId", sellerId);
            params.put("productId", productId);
            params.put("ipAddress", request.getRemoteAddr());

            System.out.println("방문 로그 저장 시작");
            // 방문 로그 저장
            service.logProductVisit(params);
            System.out.println("방문 로그 저장 완료");
        } else {
            System.out.println("필수 파라미터 누락");
        }
        return true;
    }
}
