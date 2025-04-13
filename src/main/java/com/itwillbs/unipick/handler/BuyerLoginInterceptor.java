package com.itwillbs.unipick.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;


@Component
public class BuyerLoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession(false);

        // buyEm 또는 buy_em 속성 중 하나라도 있으면 로그인된 것으로 처리
        Object emailObj = (session != null) ? session.getAttribute("buyEm") : null;
        if (emailObj == null) {
            emailObj = (session != null) ? session.getAttribute("buy_em") : null;
        }
        
        // isLoggedIn 플래그도 체크
        Boolean isLoggedIn = (session != null) ? (Boolean) session.getAttribute("isLoggedIn") : null;
        
        if ((emailObj == null || (emailObj instanceof String && ((String) emailObj).isEmpty())) 
                && (isLoggedIn == null || !isLoggedIn)) {
            
            System.out.println("비로그인 상태 - 인터셉터에 의해 차단됨");
            
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
        
        System.out.println("로그인 상태 - 인터셉터 통과");
        return true;
    }
}
