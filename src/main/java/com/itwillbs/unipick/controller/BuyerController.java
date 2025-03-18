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
	
	// 카테고리 페이지 이동
	@GetMapping("category")
	public String category() {
		return "buyer/buyerCategory";
	}
	
	// 신상품 페이지 이동
	@GetMapping("new")
	public String buyerNew() {
		return "buyer/buyerNew";
	}
	
	// 베스트 페이지 이동
	@GetMapping("best")
	public String buyerBest() {
		return "buyer/buyerBest";
	}
	
	// 장바구니 페이지 이동
	@GetMapping("cart")
	public String buyerCart() {
		return "buyer/buyerCart";
	}
	//상품검색
	@GetMapping("productSearch")
	public String productSearch() {
		return "buyer/productSearch";
	}
	//상세조회
	@GetMapping("productDetail")
	public String productDetail() {
		return "buyer/productDetail";
	}

	
	// 상단 메뉴바 공통코드
	@ResponseBody
	@GetMapping("menu")
	public List<Map<String, Object>> getAllMenu() {
		List<Map<String, Object>> menu = buyService.getAllMenu();
		return menu;
	}
	
	// 상단 메뉴바 공통코드
	@ResponseBody
	@GetMapping("firstCategory")
	public List<Map<String, Object>> firstCategory() {
		return buyService.getCategory();
	}
	
	// 상품검색
	@ResponseBody
	@GetMapping("searchProduct")
	public List<Map<String, Object>> searchProduct(@RequestParam("query") String query) {
		List<Map<String, Object>> selectPrd = buyService.getSearchPrd(query);
		return selectPrd;
	}
	
}
