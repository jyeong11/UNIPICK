package com.itwillbs.unipick.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;


@Component
public class BuyerLoginIntercepter implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession(false);

        String email = (session != null) ? (String) session.getAttribute("buyEm") : null;

        if (email == null || email.isEmpty()) {
            String requestedWith = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(requestedWith);
            
            if (isAjax) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            } else {
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
            }
            return false;
        }
        
        return true;
    }
}
