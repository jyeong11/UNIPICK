package com.itwillbs.unipick.controller;

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

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminservice;
	
	// 로그인 페이지 화면이동
	@GetMapping("adminlogin")
	public String adminlogin() {
		return "admin/adminLogin";
	}
	
	// 마이 페이지 화면이동
	@GetMapping("adminmypage")
	public String adminmypage() {
		return "admin/adminMyPage";
	}
	
	// 관리자 메인 페이지 화면이동
	@GetMapping("admin")
	public String adminMain() {
		return "admin/adminMain";
	}
	
	// 공통코드 화면이동
	@GetMapping("commonCode")
	public String admincommoncode() {
		return "admin/commonCode";
	}
	
	// 상세 공통코드 화면이동
	@GetMapping("commonCodeDetail")
	public String admincommoncodedetail() {
		return "admin/NewFile";
	}
	
	// 공통코드 화면 List 
	@ResponseBody
	@GetMapping("cmCodeList")
	public List<Map<String, Object>> commoncode(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		return adminservice.codeList(map);
	}
	
	// 코드 등록시 insert
	@ResponseBody
	@PostMapping("cmcodeRegister")
	public void cmcoderegister(@RequestParam Map<String, Object> code) {
		
		adminservice.registerDB(code);
		
		Map<String, Object> insertDBcode = new HashMap<String, Object>();
		insertDBcode.put("codeList", adminservice.codeList(code));
		
	}
	
	//코드 수정
	@ResponseBody
	@PostMapping("cmcodeUpdate")
	public void cmcodeupdate(@RequestParam Map<String, Object> code) {
		
		adminservice.updateDB(code);
	
	}
	
	//코드 삭제
	@ResponseBody
	@PostMapping("cmcodeDelete")
	public Map<String, Object> cmcodedelete(@RequestParam Map<String, Object> code) {
		adminservice.deleteDB(code);
		
		return code;
	}
	
	// 관리자 로그인
	@ResponseBody
	@PostMapping("adminLogin")
	public Map<String, Object> adminLogin(
			@RequestBody Map<String, Object> admin,
			HttpSession session,
			HttpServletResponse res) {
		Map<String, Object> adminInfo = adminservice.adminInfo(admin);
		
		boolean success = false;
		String msg = "아이디 또는 비밀번호가 틀렸습니다.";
		
		if (adminInfo != null) {
			success = true;
	        // 로그인 성공 시 세션에 저장'
	        session.setAttribute("admId", adminInfo.get("adm_id"));
	        // "아이디 기억하기" 체크 여부 확인
	        boolean rememberMe = (boolean) admin.getOrDefault("rememberMe", false);

	        if (rememberMe) {
	            // 30일 동안 유지되는 쿠키 생성
	            Cookie cookie = new Cookie("rememberedAdminId", adminInfo.get("adm_id").toString());
	            cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
	            cookie.setPath("/"); // 사이트 전체에서 접근 가능
	            res.addCookie(cookie); // 쿠키 저장
	        } else {
	            // 체크 안 했으면 기존 쿠키 삭제 (만료 시간 0)
	            Cookie cookie = new Cookie("rememberedAdminId", "");
	            cookie.setMaxAge(0);
	            cookie.setPath("/");
	            res.addCookie(cookie);
	        }
	    }
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("success", success);
		response.put("msg", msg);
		
		return response;
	}
	
	// 관리자 마이페이지 수정
	@ResponseBody
	@PostMapping("adminMyPageEdit")
	public Map<String, Object> adminmypageedit(
			@RequestBody Map<String, Object> admin) {
		int UpdateCnt = adminservice.adminEdit(admin);
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("msg", "비밀번호가 수정되었습니다.");
		
		return response;
	}
	
	// 관리자 정보
	@ResponseBody
	@GetMapping("adminInfo")
	public Map<String, Object> adminInfo(HttpSession session) {
		
		String admId = String.valueOf(session.getAttribute("admId"));
		
		Map<String, Object> admin = new HashMap<String, Object>();
		admin.put("admId", admId);
		
		return adminservice.adminInfo(admin);
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
