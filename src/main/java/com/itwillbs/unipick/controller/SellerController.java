package com.itwillbs.unipick.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.LoginService;

@Controller
@RequestMapping("seller")
public class SellerController {

	@Autowired
	LoginService loginService;
	
	@GetMapping("/login")
	public String Login() {
		return "seller/sellerLogin";
	}
	
	@ResponseBody
	@PostMapping("/login")
	public String sellerLogin(Map<String, String> logindata) {
		
		return "seller/seller";
	}
	
	@GetMapping
	public String sellerMain() {
		return "seller/sellerMain";
	}
}
