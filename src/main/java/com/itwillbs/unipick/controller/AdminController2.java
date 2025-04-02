package com.itwillbs.unipick.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.itwillbs.unipick.service.AdminService;
import com.itwillbs.unipick.service.AdminService2;

@Controller
public class AdminController2 {
	
	@Autowired
	AdminService2 adminservice;
	
	// 관리자 등록 페이지 화면이동
	@GetMapping("adminRegister")
	public String adminRegister() {
		return "admin/adminRegister";
	}
	
	// 관리자 리스트 페이지 화면이동
	@GetMapping("adminList")
	public String adminList() {
		return "admin/adminList";
	}
	
	// 관리자 등록
	@ResponseBody
	@PostMapping("adminRegister")
	public Map<String, Object> adminRegister(@RequestBody Map<String, Object> admin) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			adminservice.registerAdmin(admin);
			response.put("success", true);
			response.put("msg", "관리자가 등록되었습니다.");
		} catch (Exception e) {
			response.put("success", false);
			response.put("msg", "관리자 등록 중 오류가 발생했습니다.");
		}
		return response;
	}
	
	// 관리자 목록 조회
	@ResponseBody
	@GetMapping("getAdminList")
	public List<Map<String, Object>> getAdminList() {
		return adminservice.getAdminList();
	}
	
	// 판매자 검색
	@ResponseBody
	@GetMapping("searchSellers")
	public List<Map<String, Object>> searchSellers(@RequestParam("keyword") String keyword) {
		return adminservice.searchSellers(keyword);
	}
	
	// 관리자 스토어 업데이트
	@ResponseBody
	@PostMapping("updateAdminStores")
	public Map<String, Object> updateAdminStores(@RequestBody Map<String, Object> data) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			adminservice.updateAdminStores(data);
			response.put("success", true);
			response.put("msg", "스토어가 업데이트되었습니다.");
		} catch (Exception e) {
			response.put("success", false);
			response.put("msg", "스토어 업데이트 중 오류가 발생했습니다.");
		}
		return response;
	}
	
	// 관리자 권한 업데이트
	@ResponseBody
	@PostMapping("updateAdminRole")
	public Map<String, Object> updateAdminRole(@RequestBody Map<String, Object> data) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			adminservice.updateAdminRole(data);
			response.put("success", true);
			response.put("msg", "권한이 업데이트되었습니다.");
		} catch (Exception e) {
			response.put("success", false);
			response.put("msg", "권한 업데이트 중 오류가 발생했습니다.");
		}
		return response;
	}
}
