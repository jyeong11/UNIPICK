package com.itwillbs.unipick.controller;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.SellerService2;

@Controller
public class SellerController2 {

	@Autowired
	SellerService2 service;
	
    @GetMapping("prdRegister")
    public String prdRegister() {
        return "seller/productRegister";
    }
    
    @GetMapping("selProductList")
    public String getPrdouctList() {
    	return "seller/productList";
    }
    
    @GetMapping("selOrderList")
    public String getSelOrderList() {
    	return "seller/sellerOrdList";
    }
    
	// 회원수정페이지 이동
	@GetMapping("selModifyForm")
	public String modify() {
		return "seller/sellerModifyForm";
	}
    
	@ResponseBody
    @PostMapping("selModifyForm")
    public Map<String, Object> getSelModifyForm(HttpSession session) {
           	
    	Map<String, Object> sell = new HashMap<>();
        sell.put("sel_id", session.getAttribute("storeId"));
        return service.selModifyForm(sell); 
    }
    
	// 구매자 정보 수정
	@ResponseBody
	@PostMapping("sellermodify")
	public void sellermodify(HttpSession session, @RequestBody Map<String, Object> selModifyForm) {
		
		Map<String, Object> sell = new HashMap<>();
		sell.put("sel_id", session.getAttribute("storeId"));
		
		service.sellerModify(sell);
	}
    
	// 회원 탈퇴
	@ResponseBody
	@GetMapping("sellerWithdraw")
	public void sellerWithdraw(HttpSession session, Map<String, Object> seller) {
		seller.put("sel_id", session.getAttribute("sel_id"));
		
		service.Withdraw(seller);
		session.invalidate();
	}
}