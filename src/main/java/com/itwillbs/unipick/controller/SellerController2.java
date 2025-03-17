package com.itwillbs.unipick.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.unipick.service.SellerService2;

@Controller
public class SellerController2 {

	@Autowired
	SellerService2 sellerservice;
	
	@GetMapping("prdRegister")
	public String prdRegister() {
		return "seller/productRegister";
	}
	
//	@GetMapping("prdList")
//	public Map<String, Object> prdList(Map<String, Object> prdList) {
//		
//		sellerservice.getsellerService();
//		
//		return "prdList";
//	}
//	
	
}
