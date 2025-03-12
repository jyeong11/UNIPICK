package com.itwillbs.unipick.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@GetMapping
	public String adminMain() {
		
		return "admin/adminMain";
	}
	
	@GetMapping("commoncode")
	public String commoncode() {
		return "admin/commoncode";
	}
	
	@GetMapping("detailcommoncode")
	public String detailcommoncode() {
		return "admin/detailCommoncode";
	}
}
