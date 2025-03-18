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
import java.util.Map;
import java.util.UUID;

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
	
	//셀러 회원가입
	@GetMapping("sellerjoin")
	public String sellerJoin() {
		return "seller/sellerJoinForm";
	}
	
	//메인
	@GetMapping("seller")
	public String sellerMain(HttpSession sellerid) {
//		map.put("sellerId",(String)sellerid.getAttribute("id"));
//		Map<String, Object> sellerinfo = loginService.SellerLogin(sellerid);
		return "seller/sellerMain";
	}
	
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
       
		// 1. 실제 배포 경로 가져오기 (톰캣 내 실제 저장될 경로)
	    String uploadDir = req.getServletContext().getRealPath("/resources/businessLicense/");
	    System.out.println("업로드 경로: " + uploadDir);
		
	    String subDir = createDirectories(uploadDir);
	    uploadDir += "/" + subDir;
		
	    // 파일저장
		String fileName = "";
		String origin = businessLicense.getOriginalFilename();
		if(!origin.equals("")) {
			fileName = UUID.randomUUID().toString() + "_" + origin;
			File file = new File(uploadDir, fileName);
			System.out.println("파일이 저장될 위치: " + file.getAbsolutePath());
			try {
	            businessLicense.transferTo(file); // 파일 저장
	            System.out.println("파일 저장 완료: " + file.getAbsolutePath());
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
		if (selId != null) {
			msg = "중복된 아이디입니다.";
		}
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("msg", msg);
		return response;
	}
	
	//마이페이지
	@ResponseBody
	@GetMapping("selMypage")
	public Map<String, Object> sellerMypage(@RequestBody Map<String, Object> seldata,
											HttpSession ses){
		System.out.println(ses.getAttribute("selId"));
//		selService.selinfo();
		
		return seldata;
	}
	
	private String createDirectories(String realPath) {
		// Date 클래스 또는 LocalXXX 클래스 활용
		// 실제 날자 및 시간 관련 정보 생성 시에는 LocalXXX 클래스를 사용하고
		// 기존에 있는 라이브러리를 사용할 때 Date를 요구하는 경우에 Date 타입 활용
		
		// 1. LocalXXX 클래스 활용
		// => 날짜 정보: LocalDate, 시간정보: LocalTime, 날짜 및 시간: LocalDateTime
		LocalDate today = LocalDate.now(); // 현재 시스템의 날짜 정보 생성
		// 2025-02-05
		
		// 2. 날짜 포멧을 디렉토리 형식에 맞게 변경(ex. 2025-01-06 => 2025/01/06)
		String datePattern = "yyyy/MM/dd";
		
		// 3. 지정한 포멧을 적용하여 날짜 형식 변경
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		String subDir = today.format(dtf);
		
		// 4. 기존 실제 업로드 경로에 서브디렉토리 결합
		realPath += "/" + subDir;
		
		try {
			// 5. 해당 디렉토리를 실제 경로상에 생성
			// 5-1) java.nio.file.Paths 클래스의 get() 메서드 호출하여 Path 객체 리턴받기
			Path path = Paths.get(realPath);
			
			// 5-2) Files 클래스의 static 메서드 createDirectories() 호출하여 실제 경로 생성
			// => 파라미터로 Path 타입 객체 전달
			// => 이때, 경로 상에서 생성되지 않은 모든 디렉토리를 생성해준다!
			//   (만약, 서브디렉토리 상의 최종 디렉토리 1개만 생성 시 createDirectory() 메서드 사용가능)
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return subDir;
	}	
}

