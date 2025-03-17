package com.itwillbs.unipick.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.AdminService;

@Controller
public class BuyerController {
	@Autowired
	AdminService admService;
	
	
	@GetMapping("new")
	public String memberNew() {
		return "buyer/buyerNew";
	}
		
	// 급여 메뉴 공통코드
//	@ResponseBody
//	@GetMapping("getSalMenu")
//	public List<Map<String,Object>> getSalMenu(@RequestParam Map<String,String> map, HttpSession session) {
//		
//		int dId = (int)session.getAttribute("dId");
//		List<Map<String,Object>> result= admService.getSalMenuList(map, dId);
//		return map;
//	}
}
