package com.itwillbs.unipick.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.itwillbs.unipick.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminservice;
	
	@GetMapping("admin")
	public String adminMain() {
		return "admin/admincopy";
	}
	@GetMapping("commonCode")
	public String admincommoncode() {
		return "admin/commonCode";
	}
	
	@GetMapping("commoncode")
	public String commoncode() {
		return "admin/commoncode";
	}
	
	@GetMapping("/detailcommoncode")
	public String detailcommoncode() {
		return "admin/detailCommoncode";
	}
	
	@ResponseBody
	@GetMapping("adminInfo")
	public Map<String, Object> adminInfo(Map<String, Object> admin) {
		
		Map<String, Object> map =  adminservice.adminInfo(admin);
		
		return map;
	}
	
	// 상세 공통코드 화면이동
	@GetMapping("commonCodeDetail")
	public String commoncodedetail() {
		return "admin/commoncodedetail";
	}
	
	// 상세 공통코드 조회
	@ResponseBody
	@GetMapping("cmDetailCodeList")
	public List<Map<String, Object>> cmdetailcodelist(@RequestParam Map<String, Object> map) {	
		System.out.println(map);
		return adminservice.detailCodeList(map);
	}
	
	// 상세 공통코드 등록
	@ResponseBody
	@PostMapping("cmDatailCodeRegister")
	public void detailCodeRegister(@RequestParam Map<String, Object> map,
														HttpSession session) {
		map.put("cd_register", (Integer)session.getAttribute("sId"));
		adminservice.detailcoderegister(map);
		
	}
	
	//상세 코드 수정
	@ResponseBody
	@PostMapping("cmcdDetailUpdate")
	public void cmcdDetailUpdate(@RequestParam Map<String, Object> map,
												HttpSession session) {
		int sId = (int)session.getAttribute("sId");
		map.put("sId", sId);
		adminservice.updateDBcodeDetail(map);
	
	}
	
	//상세 코드 삭제
	@ResponseBody
	@PostMapping("cmcdDetailDelete")
	public void cmcdDetailDelete(@RequestParam Map<String, Object> map){
	
		adminservice.updateDBcodeDelete(map);
	}
	
}
