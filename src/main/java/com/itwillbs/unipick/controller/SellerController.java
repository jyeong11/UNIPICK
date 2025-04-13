package com.itwillbs.unipick.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.service.LoginService;
import com.itwillbs.unipick.service.SellerService;
import com.mysql.cj.Session;

@Controller
public class SellerController {

	@Autowired
	LoginService loginService;
	@Autowired
	SellerService selService;
	
	String virtualPath = "/resources/businessLicense";
	
	// 셀러 회원가입
	@GetMapping("sellerjoin")
	public String sellerJoin() {
		return "seller/sellerJoinForm";
	}
	
	// 메인
	@GetMapping("seller")
	public String sellerMain(HttpSession session, Model model) {
		String sel_id = (String) session.getAttribute("selId");
		String sellerName = selService.getSellerNameById(sel_id);
		model.addAttribute("sel_nm", sellerName);
		return "seller/sellerMain";
	}
	
	// 셀러 상품 상세 조회
	@GetMapping("sellerPrdDetail")
	public String sellerPrdDetail() {
		return "seller/sellerPrdDetail";
	}
	
	// 상품 주문 상세 조회
	@GetMapping("sellerOrdDetail")
	public String sellerOrdDetail() {
		return "seller/sellerOrdDetail";
	}
	
	// 셀러 계정찾기
	@GetMapping("sellerFindAcc")
	public String sellerFindAcc() {
		return "seller/sellerFindAcc";
	}
	
	// 판매자 기간별 분석
	@GetMapping("sellerTemporal")
	public String sellerTemporal() {
		return "seller/sellerTemporal";
	}
	
	// 셀러 로그인
	@GetMapping("sellerlogin")
	public String Login(HttpServletRequest request, Model model) {
	    // 저장된 쿠키 확인
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("rememberedSellerId".equals(cookie.getName())) {
	                model.addAttribute("savedSellerId", cookie.getValue());
	            }
	        }
	    } 
		return "seller/sellerLogin";
	}
	
	// 셀러 로그아웃
	 @GetMapping("sellerLogout")
    public String logout(HttpSession session) {
		 session.removeAttribute("selId");
        return "redirect:/sellerlogin";
    }
	
	//셀러 로그인
	@ResponseBody
	@PostMapping("sellerlogin")
	public Map<String, Object> sellerLogin(@RequestBody Map<String, Object> logindata,
										   HttpSession session,
										   HttpServletResponse res) {
		Map<String, Object> sellerinfo = loginService.SellerLogin(logindata);
		
		boolean success = false;
		String msg = "아이디 또는 비밀번호가 틀렸습니다.";
		
		if (sellerinfo != null) {
			success = true;
	        session.setAttribute("selId", sellerinfo.get("sel_id"));
	        session.setAttribute("storeId", sellerinfo.get("sel_id")); 
	        session.setAttribute("sel_nm", sellerinfo.get("sel_nm"));
	        boolean rememberMe = (boolean) logindata.getOrDefault("rememberMe", false);

	        if (rememberMe) {
	            // 30일 동안 유지되는 쿠키 생성
	            Cookie cookie = new Cookie("rememberedSellerId", sellerinfo.get("sel_id").toString());
	            cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
	            cookie.setPath("/"); // 사이트 전체에서 접근 가능
	            res.addCookie(cookie); // 쿠키 저장
	        } else {
	            // 체크 안 했으면 기존 쿠키 삭제 (만료 시간 0)
	            Cookie cookie = new Cookie("rememberedSellerId", "");
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
	
	//셀러가입
	@ResponseBody
	@PostMapping("joinSucess")
	public Map<String, Object> joinSucess(@RequestParam Map<String, Object> sellerInfo,
										  @RequestParam("businessLicense") MultipartFile businessLicense,
										  HttpServletRequest req) {
       System.out.println("sellerInfo" + sellerInfo);
		 ServletContext servletContext = req.getServletContext();
		// 1. 실제 배포 경로 가져오기 (톰캣 내 실제 저장될 경로)
		String uploadDir = servletContext.getRealPath("/resources/businessLicense/");
		
	    String subDir = createDirectories(uploadDir);
	    uploadDir += "/" + subDir;
		
	    // 파일저장
		String fileName = "";
		String origin = businessLicense.getOriginalFilename();
		if(!origin.equals("")) {
			fileName = UUID.randomUUID().toString() + "_" + origin;
			File file = new File(uploadDir, fileName);
			try {
	            businessLicense.transferTo(file); // 파일 저장
	        } catch (IOException e) {
	            e.printStackTrace();
	            System.out.println("파일 저장 실패");
	        }
	        sellerInfo.put("sel_bf", "/resources/businessLicense/" + fileName);
	    }
		selService.sellerjoin(sellerInfo);
		
		return sellerInfo;
	}
	// 아이디 중복체크
	@ResponseBody
	@PostMapping("selinfo")
	public Map<String, Object> selInfo(@RequestBody Map<String, Object> seldata) {
		Map<String, Object> selId = selService.sellerselect(seldata);
		String msg = "사용가능한 아이디입니다.";
		boolean success = true;
		if (selId != null) {
			msg = "중복된 아이디입니다.";
			success = false;
		}
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("msg", msg);
		response.put("success", success);
		
		return response;
	}
	
	// 상품 상세 조회
	@ResponseBody
	@PostMapping("selproductDetail")
	public Map<String, Object> selproductDetail(@RequestBody Map<String, Object> prdData){
		
		return selService.productDetail(prdData);
	}
	
	// 주문 상세 조회
	@ResponseBody
	@PostMapping("sellerOrdDetail")
	public List<Map<String, Object>> sellerOrdPrdDetail(@RequestBody Map<String, Object> ord_id) {
		return selService.sellerOrdPrdDetail(ord_id);
	}
	
	// 사업자등록증 파일 함수 
	private String createDirectories(String realPath) {
		LocalDate today = LocalDate.now();
		
		String datePattern = "yyyy/MM/dd";
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		String subDir = today.format(dtf);
		realPath += "/" + subDir;
		
		try {
			Path path = Paths.get(realPath);
			
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return subDir;
	}
	
	// 상품 수정
	@ResponseBody
	@PostMapping("productUpdate")
	public void productUpdate(HttpServletRequest req,
							  @RequestParam Map<String, String> formData,  // 텍스트 데이터를 Map으로 받기
							  @RequestPart(value = "updateFiles", required = false) List<MultipartFile> files,
							  @RequestParam(value = "imageIndexes", required = false) List<String> imageIndexes,
							  @RequestParam(value = "opt_id", required = false) List<String> opt_id,
							  @RequestParam(value = "color_number", required = false) List<String> colorNumbers,
							  @RequestParam(value = "color_name", required = false) List<String> colorNames,
							  @RequestParam(value = "size_option", required = false) List<String> sizeOptions,
							  @RequestParam(value = "stock_number", required = false) List<Integer> stockNumbers,
							  @RequestParam(value = "opt_id_del", required = false) List<Integer> delOption) {
		selService.productUpdate(req, formData, files, imageIndexes, opt_id, colorNumbers, colorNames, sizeOptions, stockNumbers, delOption);
	}
	
	// 상품 삭제
	@ResponseBody
	@PostMapping("productDelete")
	public void productDelete(@RequestBody Map<String, Object> prd) {
		selService.productDelete(prd);
	}
	
	// 판매자 메인 신규 주문 
	@ResponseBody
	@PostMapping("newOrdCount")
	public int newOrdCount(HttpSession session){
		String sel_id = (String) session.getAttribute("selId");
		int cnt = selService.newOrdCount(sel_id);
		return cnt;
	}
	
	// 판매자 메인 이번달 매출액
	@ResponseBody
	@PostMapping("Revenue")
	public Map<String, Object> Revenue(HttpSession session) {
		String sel_id = (String) session.getAttribute("selId");
		return selService.revenue(sel_id);
	}
}


