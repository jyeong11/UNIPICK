package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.BuyerService2;

@Controller
public class BuyerController2 {
	
	@Autowired
	BuyerService2 buyerService;

	@GetMapping("buyerLogin")
	public String buyerLogin() {
		
		return "buyer/buyerLogin";
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
	
//	@ResponseBody
//	@PostMapping("checkEmail")
//    public Map<String, Object> checkEmail(@RequestBody Map<String, Object> email) {
//        String email = (String) email.get("email");
//        boolean check = memberService.checkEmail(email);
//        Map<String, Object> response = new HashMap<>();
//        response.put("isDuplicated", check);
//        return response;
//    }
//	
//    @ResponseBody
//    @PostMapping("/memberJoin")
//    public Map<String, Object> memberJoin(@RequestBody Member member) {
//        boolean success = memberService.registerMember(member);
//        Map<String, Object> response = new HashMap<>();
//        response.put("result", success ? "회원가입 완료" : "중복된 이메일 존재");
//        return response;
//    }
}
