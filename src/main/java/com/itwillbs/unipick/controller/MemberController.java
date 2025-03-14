package com.itwillbs.unipick.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

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
}
