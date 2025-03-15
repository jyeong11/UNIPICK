package com.itwillbs.unipick.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.LoginService;
import com.itwillbs.unipick.service.SellerService;

@Controller
public class SellerController {

	@Autowired
	LoginService loginService;
	@Autowired
	SellerService selService;
	
	@GetMapping("sellerlogin")
	public String Login(HttpServletRequest request, Model model) {
	    // 저장된 쿠키 확인
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("rememberedSellerId".equals(cookie.getName())) {
	                model.addAttribute("savedSellerId", cookie.getValue());
	            }
	        }
	    } 
		return "seller/sellerLogin";
	}
	
	//셀러 로그인
	@ResponseBody
	@PostMapping("sellerlogin")
	public Map<String, Object> sellerLogin(@RequestBody Map<String, Object> logindata,
										   HttpSession session,
										   HttpServletResponse res) {
		Map<String, Object> sellerinfo = loginService.SellerLogin(logindata);
		
		boolean success = false;
		String msg = "아이디 또는 비밀번호가 틀렸습니다.";
		
		if (sellerinfo != null) {
			success = true;
	        // 로그인 성공 시 세션에 저장
	        session.setAttribute("selId", sellerinfo.get("sel_id"));
	        // "아이디 기억하기" 체크 여부 확인
	        boolean rememberMe = (boolean) logindata.getOrDefault("rememberMe", false);

	        if (rememberMe) {
	            // 30일 동안 유지되는 쿠키 생성
	            Cookie cookie = new Cookie("rememberedSellerId", sellerinfo.get("sel_id").toString());
	            cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
	            cookie.setPath("/"); // 사이트 전체에서 접근 가능
	            res.addCookie(cookie); // 쿠키 저장
	        } else {
	            // 체크 안 했으면 기존 쿠키 삭제 (만료 시간 0)
	            Cookie cookie = new Cookie("rememberedSellerId", "");
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
	//셀러 회원가입
	@GetMapping("sellerjoin")
	public String sellerJoin() {
		return "seller/sellerJoinForm";
	}
	
	@ResponseBody
	@PostMapping("joinSucess")
	public Map<String, Object> joinSucess(@RequestBody Map<String, Object> sellerinfo) {
		// Base64로 인코딩된 파일을 디코딩하여 파일 처리
        String base64File = (String) sellerinfo.get("businessLicense");
        byte[] decodedBytes = Base64.getDecoder().decode(base64File);

        // 디코딩된 데이터를 파일로 저장하는 로직 추가
        // 파일 저장 로직은 필요에 따라 구현
        System.out.println("Decoded File: " + decodedBytes);

		System.out.println("!@#$%^&&" + sellerinfo);
		Map<String, Object> insertSelInfo = selService.sellerjoin(sellerinfo);
		
		return sellerinfo;
	}
	
	//메인
	@GetMapping("seller")
	public String sellerMain(HttpSession sellerid) {
//		map.put("sellerId",(String)sellerid.getAttribute("id"));
//		Map<String, Object> sellerinfo = loginService.SellerLogin(sellerid);
		return "seller/sellerMain";
	}
	
	@GetMapping("prdRegister")
	public String prdRegister() {
		return "seller/prdRegister";
	}
	
	//마이페이지
	@ResponseBody
	@GetMapping("selMypage")
	public Map<String, Object> sellerMypage(@RequestBody Map<String, Object> seldata,
											HttpSession ses){
		System.out.println(ses.getAttribute("selId"));
//		selService.selinfo();
		
		return seldata;
	}
	
	
}
