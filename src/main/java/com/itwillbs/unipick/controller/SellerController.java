package com.itwillbs.unipick.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.LoginService;

@Controller
public class SellerController {

	@Autowired
	LoginService loginService;
	
	@GetMapping("sellerlogin")
	public String Login() {
		return "seller/sellerLogin";
	}
	
	//셀러 로그인
	@ResponseBody
	@PostMapping("sellerlogin")
	public Map<String, Object> sellerLogin(@RequestBody Map<String, Object> logindata,
										   HttpSession session) {
		Map<String, Object> sellerinfo = loginService.SellerLogin(logindata);
//		session.setAttribute("id",logindata.get(sellerId));
		return sellerinfo;
	}
	
	@GetMapping("seller")
	public String sellerMain(HttpSession sellerid) {
//		map.put("sellerId",(String)sellerid.getAttribute("id"));
//		Map<String, Object> sellerinfo = loginService.SellerLogin(sellerid);
		return "seller/sellerMain";
	}
}
