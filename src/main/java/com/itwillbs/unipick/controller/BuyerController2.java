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
import org.springframework.stereotype.Service;
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
	
	// 로그인 상태 확인 API
	@GetMapping("/check-login")
	@ResponseBody
	public Map<String, Object> checkLogin(HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    String buyEm = (String) session.getAttribute("buyEm");
	    result.put("loggedIn", buyEm != null);
	    return result;
	}
	
	
	//바이어 로그인
	@ResponseBody
	@PostMapping("buyerlogin")
	public Map<String, Object> buyerLogin(@RequestBody Map<String, Object> logindata,
			@RequestParam(value = "returnUrl", required = false) String returnUrl,
										   HttpSession session,
										   HttpServletResponse res) {
		System.out.println("로그인 요청 데이터: " + logindata); // 요청 데이터 출력
		
		Map<String, Object> buyerinfo = buyerService.BuyerLogin(logindata);
		
		System.out.println("로그인 결과 데이터: " + buyerinfo); // 결과 데이터 출력
		
		boolean success = false;
		String msg = "아이디 또는 비밀번호가 틀렸습니다.";
		
		if (buyerinfo != null) {
			success = true;
	        session.setAttribute("buyEm", buyerinfo.get("buy_em"));
	        session.setAttribute("buyNm", buyerinfo.get("buy_nm"));
	        System.out.println("세션에 저장된 buyEm: " + session.getAttribute("buyEm"));
	        System.out.println("세션에 저장된 buyNm: " + session.getAttribute("buyNm"));
	        
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
		
		 if (success) {
		        if (returnUrl != null && !returnUrl.isEmpty()) {
		            response.put("returnUrl", returnUrl);
		        }
		    }
		
		return response;
	}
	
	@GetMapping("buyerJoin")
	public String buyerJoin() {
	
		return "buyer/buyerJoin";
	}
	
    @PostMapping("buyerJoin")
    @ResponseBody
    public Map<String, Object> saveBuyerAgreement(
            @RequestParam boolean acc_ta, 
            @RequestParam boolean acc_pa, 
            @RequestParam boolean acc_ma,
            HttpSession session) {
    	
    	

        // 세션에 약관 동의 정보 저장
        session.setAttribute("acc_ta", acc_ta);
        session.setAttribute("acc_pa", acc_pa);
        session.setAttribute("acc_ma", acc_ma);
        
        System.out.println(acc_ta);
        System.out.println(acc_pa);
        System.out.println(acc_ma);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        return response;
    }
	
	@GetMapping("buyerAuthentication")
	public String buyerAuthentication() {
		return "buyer/buyerAuthentication";
	}
	
	@PostMapping("buyerAuthentication")
	@ResponseBody
	public Map<String, Object> saveBuyerPhone(@RequestParam("phone") String phone, HttpSession session) {
	    // 세션에서 약관 동의 정보 가져오기
		
		Boolean acc_ta = (Boolean) session.getAttribute("acc_ta");
		Boolean acc_pa = (Boolean) session.getAttribute("acc_pa");
		Boolean acc_ma = (Boolean) session.getAttribute("acc_ma");
		
		  // 세션 값이 null이면 기본값 설정
	    if (acc_ta == null) acc_ta = false;
	    if (acc_pa == null) acc_pa = false;
	    if (acc_ma == null) acc_ma = false;
	    
	    
	    session.setAttribute("acc_ta", acc_ta);
	    session.setAttribute("acc_pa", acc_pa);
	    session.setAttribute("acc_ma", acc_ma);
	    session.setAttribute("userPhone", phone);

	    
	    // 세션에 휴대폰 번호 저장
	    session.setAttribute("userPhone", phone);

	    // 확인을 위한 로그 출력
	    System.out.println("약관 동의 여부: " + acc_ta + ", " + acc_pa + ", " + acc_ma);
	    
	    // 확인을 위한 로그 출력
	    System.out.println("userPhone: " + phone);
	    System.out.println("acc_ta: " + session.getAttribute("acc_ta"));
	    System.out.println("acc_pa: " + session.getAttribute("acc_pa"));
	    System.out.println("acc_ma: " + session.getAttribute("acc_ma"));
	    
	    System.out.println("acc_ta: " + session.getAttribute("acc_ta") + " (" + session.getAttribute("acc_ta").getClass().getSimpleName() + ")");
	    System.out.println("acc_pa: " + session.getAttribute("acc_pa") + " (" + session.getAttribute("acc_pa").getClass().getSimpleName() + ")");
	    System.out.println("acc_ma: " + session.getAttribute("acc_ma") + " (" + session.getAttribute("acc_ma").getClass().getSimpleName() + ")");
	    
	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    return response;
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
	
	@PostMapping("buyerregister")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> register(
	        @RequestParam("buyer_em") String email,
	        @RequestParam("buyer_pw") String password,
	        @RequestParam("phone") String phone,
	        @RequestParam("acc_ta") String accTa,
	        @RequestParam("acc_pa") String accPa,
	        @RequestParam("acc_ma") String accMa,
	        HttpSession session) {

	    // 세션에서 값을 가져옴
	    String sessionPhone = (String) session.getAttribute("userPhone");
	    Boolean sessionAccTa = (Boolean) session.getAttribute("acc_ta");
	    Boolean sessionAccPa = (Boolean) session.getAttribute("acc_pa");
	    Boolean sessionAccMa = (Boolean) session.getAttribute("acc_ma");

	    // 세션 값이 null이면 기본값 false로 설정
	    if (sessionAccTa == null) sessionAccTa = false;
	    if (sessionAccPa == null) sessionAccPa = false;
	    if (sessionAccMa == null) sessionAccMa = false;

	    // 이메일 유효성 검사
	    if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
	        Map<String, Object> response = new HashMap<>();
	        response.put("success", false);
	        response.put("msg", "유효한 이메일을 입력해주세요.");
	        return ResponseEntity.badRequest().body(response);
	    }

	    // 비밀번호 유효성 검사 (최소 8자 이상)
	    if (password == null || password.isEmpty() || password.length() < 8) {
	        Map<String, Object> response = new HashMap<>();
	        response.put("success", false);
	        response.put("msg", "비밀번호는 8자 이상이어야 합니다.");
	        return ResponseEntity.badRequest().body(response);
	    }

	    // 파라미터 준비
	    Map<String, Object> param = new HashMap<>();
	    param.put("buy_em", email);
	    param.put("buy_pw", password);
	    param.put("buy_ph", phone);
	    param.put("acc_ta", accTa);
	    param.put("acc_pa", accPa);
	    param.put("acc_ma", accMa);

	    // 서비스 호출
	    boolean success = buyerService.registerBuyer(param);

	    // 응답 준비
	    Map<String, Object> response = new HashMap<>();
	    if (success) {
	        // 사용자 등록 성공시 세션 종료
	        session.invalidate();
	        response.put("success", true);
	        response.put("msg", "사용자 등록이 성공적으로 완료되었습니다.");
	    } else {
	        response.put("success", false);
	        response.put("msg", "사용자 등록에 실패했습니다.");
	    }

	    return ResponseEntity.ok(response);
	}


	@GetMapping("buyerId")
	public String buyerId() {
		return "buyer/buyerId";
	}

	@ResponseBody
	@PostMapping("buyerId")
	public ResponseEntity<Map<String, Object>> findEmpId(
	        @RequestParam("buy_nm") String buyEm,
	        @RequestParam("buy_ph") String buyPh) {
	    
	    if (buyEm == null || buyEm.isBlank() || buyPh == null || buyPh.isBlank()) {
	        return ResponseEntity.badRequest()
	                .body(Map.of("error", "이름과 휴대폰 번호를 모두 입력해 주세요."));
	    }
	    
	    Map<String, Object> result = buyerService.findEmployeeByNameAndPhone(buyEm, buyPh);
	    
	    if (result.containsKey("buy_em")) {
	        // Success: Return the email
	        return ResponseEntity.ok(Map.of("message", "아이디는 " + result.get("buy_em")));
	    } else {
	        // Error: No matching user found
	        return ResponseEntity.status(HttpStatus.NOT_FOUND)
	                .body(Map.of("error", "이름과 휴대폰 번호가 일치하는 계정이 없습니다."));
	    }
	}
	
	
	// 비밀번호찾기 페이지 이동
		@GetMapping("buyerPw")
		public String buyerPw() {
			return "buyer/buyerPw";
		}
		
		
		//비밀번호 찾기	
	    @PostMapping("/reset")
	    public ResponseEntity<Map<String, String>> resetPassword(
	            @RequestParam String buyNm,
	            @RequestParam String buyEm) {

	        if (buyNm.isBlank() || buyEm.isBlank()) {
	            return ResponseEntity.badRequest().body(Map.of("error", "이름과 이메일을 모두 입력해 주세요."));
	        }

	        // 비동기 처리를 위한 쓰레드 생성
	        Thread resetThread = new Thread(() -> {
	            try {
	                buyerService.resetPassword(buyNm, buyEm);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        });
	        resetThread.start();

	        // 즉시 응답 반환
	        return ResponseEntity.ok(Map.of("message", "임시 비밀번호가 이메일로 전송되었습니다. 이메일을 확인해주세요."));
	    }


}
