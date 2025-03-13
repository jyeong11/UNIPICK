package com.itwillbs.unipick.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.AdminService;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	AdminService adminservice;
	
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
	
	@ResponseBody
	@GetMapping("adminInfo")
	public Map<String, Object> adminInfo(Map<String, Object> admin) {
		
		Map<String, Object> map =  adminservice.adminInfo(admin);
		
		return map;
	}
}
