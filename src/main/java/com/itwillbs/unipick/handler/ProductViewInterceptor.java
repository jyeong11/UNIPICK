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
        String productId = request.getParameter("productId");
        String sellerId = request.getParameter("sellerId");

        if (productId != null && sellerId != null) {
            Map<String, Object> params = new HashMap<>();
            params.put("sellerId", sellerId);
            params.put("productId", productId);
            params.put("ipAddress", request.getRemoteAddr());

            // 방문 로그 저장
            service.logProductVisit(params);
        }
        return true;
    }
}
