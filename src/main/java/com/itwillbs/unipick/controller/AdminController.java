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

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminservice;
	
	// 로그인 페이지 화면이동
	@GetMapping("adminLogin")
	public String adminLogin() {
		return "admin/adminLogin";
	}
	
	// 마이 페이지 화면이동
	@GetMapping("adminMyPage")
	public String adminmypage() {
		return "admin/adminMyPage";
	}
	
	// 관리자 메인 페이지 화면이동
	@GetMapping("admin")
	public String adminMain() {
		return "admin/adminMain";
	}
	//상품 목록 화면이동
	@GetMapping("admProductList")
	public String AdmProductList() {
		return "admin/admProductList";
	}
	
	// 공통코드 화면이동
	@GetMapping("commonCode")
	public String admincommoncode() {
		return "admin/commonCode";
	}
	
	// 상세 공통코드 화면이동
	@GetMapping("commonCodeDetail")
	public String admincommoncodedetail() {
		return "admin/commonCodeDetail";
	}
	
	// 계층코드 화면이동
	@GetMapping("commonCodeLevel")
	public String commoncodelevel() {
		return "admin/commonCodeLevel";
	}
	
	// 판매자 회원 화면
	@GetMapping("adminSellerList")
	public String adminSellerList() {
		return "admin/adminSellerList";
	}
	
	// 판매자 회원 상세조회
	@GetMapping("adminSellerDetail")
	public String adminSellerDetail() {
		return "admin/adminSellerDetail";
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
	        session.setAttribute("admId", adminInfo.get("adm_id"));
	        boolean rememberMe = (boolean) admin.getOrDefault("rememberMe", false);

	        if (rememberMe) {
	            // 30일 동안 유지되는 쿠키 생성
	            Cookie cookie = new Cookie("rememberedAdminId", adminInfo.get("adm_id").toString());
	            cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
	            cookie.setPath("/"); // 사이트 전체에서 접근 가능
	            res.addCookie(cookie);
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
	public void detailCodeRegister(@RequestParam Map<String, Object> map) {
		adminservice.detailcoderegister(map);
		
	}
	
	//상세 코드 수정
	@ResponseBody
	@PostMapping("cmcdDetailUpdate")
	public void cmcdDetailUpdate(@RequestParam Map<String, Object> map) {
		adminservice.updateDBcodeDetail(map);
	
	}
	
	//상세 코드 삭제
	@ResponseBody
	@PostMapping("cmcdDetailDelete")
	public void cmcdDetailDelete(@RequestParam Map<String, Object> map){
	
		adminservice.updateDBcodeDelete(map);
	}
	
	// 계층코드 조회
	@ResponseBody
	@GetMapping("lvCodeList")
	public List<Map<String, Object>> lvCodeList(@RequestParam Map<String, Object> map) {	
		return adminservice.selectLvCode(map);
	}
	
	// 계층 코드 등록
	@ResponseBody
	@PostMapping("lvCodeRegister")
	public void lvCodeRegister(@RequestBody Map<String, Object> map) {
		adminservice.insertLvCode(map);
	}
	
	//계층 코드 수정
	@ResponseBody
	@PostMapping("lvCodeUpdate")
	public void lvCodeUpdate(@RequestParam Map<String, Object> map) {
		adminservice.updateLvCode(map);
	}
	
	// 계층 코드 삭제
	@ResponseBody
	@PostMapping("lvCodeDelete")
	public void lvCodeDelete(@RequestParam Map<String, Object> map){
		adminservice.deleteLvCode(map);
	}
	
	// 사이드 메뉴
	@ResponseBody
	@PostMapping("sideMenu")
	public List<Map<String,Object>> sideMenu(@RequestParam Map<String, Object> map){
		
		return adminservice.MenuList(map);
	}
	
	// 관리자 상품관리
	@ResponseBody
	@PostMapping("admproductList")
	public List<Map<String, Object>> admproductList(@RequestParam Map<String, Object> map) {
		return adminservice.getPrdList(map);
	}
	
	// 상품 상세조회
	@ResponseBody
	@PostMapping("admprdListDetail")
	public List<Map<String, Object>> admprdListDetail(@RequestParam Map<String, Object> prdCd) {
		return adminservice.getprdListDetail(prdCd);
	}
	
	// 방문자 수 증가
	@ResponseBody
	@GetMapping("visitCount")
	public Map<String, Object> visitCount() {
		return adminservice.visitCount();
	}
	
	//상품 접수 상태값 바꾸기
	@ResponseBody
	@PostMapping("selectPrdstatus")
	public void selectPrdstatus(@RequestParam("status") String status,
	        					@RequestParam("prd_cd") String prdCd) {
		System.out.println("status!@#$%^&*(" + status);
		System.out.println("status!@#$%^&*(" + prdCd);
		adminservice.updateStatus(status, prdCd);
	}
	
	// 메인 페이지 출력
	@ResponseBody
	@GetMapping("mainPrint")
	public Map<String, Object> mainPrint() {
		return adminservice.mainPrint();
	}
	
	// 판매자 회원 조회
	@ResponseBody
	@PostMapping("getSellerInfo")
	public List<Map<String, Object>> getSellerInfo(@RequestParam Map<String, Object> data) {
		return adminservice.getSellerInfo(data);
	}
	
	// 판매자 회원 상세 조회
	@ResponseBody
	@PostMapping("getSellerInfoDeatil")
	public List<Map<String, Object>> getSellerInfoDeatil(@RequestParam Map<String, Object> sel_nm) {
		return adminservice.getSellerInfoDeatil(sel_nm);
	}
}
