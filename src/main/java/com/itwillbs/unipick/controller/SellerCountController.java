package com.itwillbs.unipick.controller;



import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.service.SellerService2;

@Controller
public class SellerCountController {

	@Autowired
	SellerService2 service;
	
	@GetMapping("/account")
	public String sellerAccount(Model model, HttpSession session) {
	    String sellerId = (String) session.getAttribute("selId");
	    if (sellerId == null) {
	        return "redirect:/seller/sellerLogin";
	    }
	    return "seller/sellerAccount";
	}

	@GetMapping("/account/search")
	@ResponseBody
	public List<Map<String, Object>> searchSettlement(
	        @RequestParam String periodType,
	        @RequestParam(required = false) String startDate,
	        @RequestParam(required = false) String endDate,
	        HttpSession session) {
	    String sellerId = (String) session.getAttribute("selId");
	    if (sellerId == null) {
	        return new ArrayList<>();
	    }
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("sellerId", sellerId);
	    params.put("periodType", periodType);
	    params.put("startDate", startDate);
	    params.put("endDate", endDate);
	    
	    return service.getSettlementList(params);
	}

	@GetMapping("/account/excel")
	public void downloadExcel(
	        @RequestParam String periodType,
	        @RequestParam(required = false) String startDate,
	        @RequestParam(required = false) String endDate,
	        HttpServletResponse response,
	        HttpSession session) throws IOException {
	    String sellerId = (String) session.getAttribute("selId");
	    if (sellerId == null) {
	        return;
	    }
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("sellerId", sellerId);
	    params.put("periodType", periodType);
	    params.put("startDate", startDate);
	    params.put("endDate", endDate);
	    
	    List<Map<String, Object>> settlementList = service.getSettlementList(params);
	    
	    response.setContentType("application/vnd.ms-excel");
	    response.setHeader("Content-Disposition", "attachment; filename=settlement.xlsx");
	    
	    service.generateExcel(settlementList, response.getOutputStream());
	}
}