package com.itwillbs.unipick.controller;



import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
    
    @ResponseBody
    @GetMapping("selModifyForm")
    public Map<String, Object> getSelModifyForm(HttpSession session, Map<String, Object> sell) {
    	
    	sell.put("sel_id", session.getAttribute("selId"));
    	return service.selModifyForm(sell);
    }
}