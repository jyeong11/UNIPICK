package com.itwillbs.unipick.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

	@GetMapping("memberLogin")
	public String memberJoin() {
		
		return "member/memberLogin";
	}
}
