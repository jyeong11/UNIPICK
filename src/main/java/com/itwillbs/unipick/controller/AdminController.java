package com.itwillbs.unipick.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@GetMapping
	public String adminMain() {
		
		return "admin/admin_main";
	}
	
	@GetMapping("commoncode")
	public String commoncode() {
		return "admin/commoncode";
	}
	
	@GetMapping("detailcommoncode")
	public String detailcommoncode() {
		return "admin/detail_commoncode";
	}
}
