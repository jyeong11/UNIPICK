package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;

	@GetMapping("memberLogin")
	public String memberLogin() {
		
		return "member/memberLogin";
	}
	
	@GetMapping("memberJoin")
	public String memberJoin() {
	
		return "member/memberJoin";
	}
	@GetMapping("memberAuthentication")
	public String memberAuthentication() {
		return "member/memberAuthentication";
	}
	
	@GetMapping("memberEmail")
	public String memberEamil() {
		return "member/memberEmail";
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
