package com.itwillbs.unipick.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.AdminService;
import com.itwillbs.unipick.service.BuyerService;

@Controller
public class BuyerController {
	@Autowired
	AdminService admService;
	
	@Autowired
	BuyerService buyService;
	
	
	@GetMapping("new")
	public String buyerNew() {
		return "buyer/buyerNew";
	}
	
	@GetMapping("best")
	public String buyerBest() {
		return "buyer/buyerBest";
	}
	@GetMapping("cart")
	public String buyerCart() {
		return "buyer/buyerCart";
	}
		
	// 상단 메뉴바 공통코드
	@ResponseBody
	@GetMapping("menu")
	public List<Map<String, Object>> getAllMenu() {
		List<Map<String, Object>> menu = buyService.getAllMenu();
		return menu;
	}
}
