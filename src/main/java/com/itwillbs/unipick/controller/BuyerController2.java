package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.BuyerService2;

@Controller
public class BuyerController2 {
	
	@Autowired
	BuyerService2 buyerService;

	@GetMapping("buyerlogin")
	public String buyerLogin(HttpServletRequest request, Model model) {
		
	    // 저장된 쿠키 확인
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("rememberedBuyerId".equals(cookie.getName())) {
	                model.addAttribute("savedBuyerId", cookie.getValue());
	            }
	        }
	    }
		
		return "buyer/buyerLogin";
	}
	
	//바이어 로그인
	@ResponseBody
	@PostMapping("buyerlogin")
	public Map<String, Object> buyerLogin(@RequestBody Map<String, Object> logindata,
										   HttpSession session,
										   HttpServletResponse res) {
		Map<String, Object> buyerinfo = buyerService.BuyerLogin(logindata);
		
		boolean success = false;
		String msg = "아이디 또는 비밀번호가 틀렸습니다.";
		
		if (buyerinfo != null) {
			success = true;
	        session.setAttribute("buyEm", buyerinfo.get("buy_em"));
	        boolean rememberMe = (boolean) logindata.getOrDefault("rememberMe", false);

	        if (rememberMe) {
	            // 30일 동안 유지되는 쿠키 생성
	            Cookie cookie = new Cookie("rememberedBuyerId", buyerinfo.get("buy_em").toString());
	            cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
	            cookie.setPath("/"); // 사이트 전체에서 접근 가능
	            res.addCookie(cookie); // 쿠키 저장
	        } else {
	            // 체크 안 했으면 기존 쿠키 삭제 (만료 시간 0)
	            Cookie cookie = new Cookie("rememberedBuyerId", "");
	            cookie.setMaxAge(0); 
	            cookie.setPath("/");
	            res.addCookie(cookie);
	        }
	    }
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("success", success);
		response.put("msg", msg);
		
		return response;
	}
	
	@GetMapping("buyerJoin")
	public String buyerJoin() {
	
		return "buyer/buyerJoin";
	}
	@GetMapping("buyerAuthentication")
	public String buyerAuthentication() {
		return "buyer/buyerAuthentication";
	}
	
	@GetMapping("buyerEmail")
	public String buyerEamil() {
		return "buyer/buyerEmail";
	}
	
	@ResponseBody
    @PostMapping("checkEmail")
	public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestParam("buy_em") String buyEm) {
	    boolean exists = buyerService.BuyEmail(buyEm);
	    Map<String, Boolean> response = new HashMap<>();
	    response.put("exists", exists);
	    return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@PostMapping("register")
	public ResponseEntity<Map<String, Object>> register(@RequestParam("buyer_em") String email,
	        @RequestParam("buyer_pw") String password, HttpSession session) {
	    
	    // 비밀번호 유효성 검사
	    if (!buyerService.validatePassword(password)) {
	        Map<String, Object> response = new HashMap<>();
	        response.put("success", false);
	        response.put("msg", "비밀번호가 유효하지 않습니다.");
	        return ResponseEntity.badRequest().body(response);
	    }

	    String phone = (String) session.getAttribute("userPhone"); // 세션에서 phone 값 가져오기
	    boolean success = buyerService.registerBuyer(email, password, phone); // 서비스 호출
	    Map<String, Object> response = new HashMap<>();
	    response.put("success", success);
	    return ResponseEntity.ok(response);
	}

	
	// 비밀번호찾기 페이지 이동
		@GetMapping("empPass")
		public String empPass() {
			return "login/login_pass";
		}
		
		
		// 비밀번호 찾기
		
//		@ResponseBody
//		@PostMapping("rest")
//		public ResponseEntity<Map<String, String>> resetPassword(
//				@RequestParam String empNo, @RequestParam String empEm){
//			
//			if (empNo == null || empNo.isBlank() || empEm == null || empEm.isBlank()) {
//		        return ResponseEntity.badRequest().body(Map.of("error", "사원번호와 이메일을 모두 입력해 주세요."));
//		    }
//			
//			boolean success = buyerService.resetPassword(empNo, empEm);
//			
//			if (success) {
//		        return ResponseEntity.ok(Map.of("message", "임시 비밀번호가 이메일로 전송되었습니다."));
//		    } else {
//		        return ResponseEntity.status(HttpStatus.NOT_FOUND)
//		                .body(Map.of("error", "사원번호 또는 이메일이 일치하지 않습니다."));
//		    }
//		
//		}
}
