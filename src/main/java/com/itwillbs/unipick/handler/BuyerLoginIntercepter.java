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
public class BuyerLoginIntercepter implements HandlerInterceptor {

    @Autowired
    private SellerService2 service;
    @Autowired
    private BuyerService buyservice;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession(false);

        String email = (session != null) ? (String) session.getAttribute("buyEm") : null;

        if (email == null || email.isEmpty()) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write(
                "<script>" +
                    "if(confirm('로그인 후 이용 가능한 서비스입니다. 로그인 페이지로 이동할까요?')) {" +
                        "location.href='buyerlogin';" +
                    "} else {" +
                        "history.back();" +
                    "}" +
                "</script>"
            );
            response.getWriter().flush();
            return false;
        }

        return true;
    }
}
