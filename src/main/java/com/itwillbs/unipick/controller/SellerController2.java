package com.itwillbs.unipick.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.unipick.service.SellerService2;

@Controller
public class SellerController2 {

	@Autowired
	SellerService2 service;
	
    @GetMapping("prdRegister")
    public String prdRegister() {
        return "seller/productRegister";
    }
    
   // 상품 목록을 JSP로 렌더링하기 위한 메소드
//@GetMapping("/seller/selProductList")
//public String getProductList(
//        @RequestParam(value = "prd_nm", required = false, defaultValue = "") String prdNm,
//        @RequestParam(value = "prd_ca", required = false, defaultValue = "") String prdCa,
//        @RequestParam(value = "startRow", required = false, defaultValue = "0") int startRow,
//        @RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit,
//        Model model) {
//
//    // 검색 조건 Map 생성
//    Map<String, String> searchParams = new HashMap<>();
//    searchParams.put("prd_nm", prdNm);
//    searchParams.put("prd_ca", prdCa);
//
//    // 상품 리스트 조회
//    List<Map<String, Object>> productList = service.getProductList(searchParams, startRow, listLimit);
//    int totalCount = service.getProductListCount(searchParams);
//
//    // JSP로 데이터 전달
//    model.addAttribute("productList", productList);
//    model.addAttribute("totalCount", totalCount);
//
//    return "seller/productList";  // productList.jsp로 이동
//}
    
}