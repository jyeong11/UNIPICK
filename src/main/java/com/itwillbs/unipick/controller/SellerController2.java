package com.itwillbs.unipick.controller;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
    
	// 회원수정페이지 이동
	@GetMapping("selModifyForm")
	public String modify() {
		return "seller/sellerModifyForm";
	}
	
//    // ✅ 판매자 정보 조회 (JSON 반환)
//    @PostMapping("/getSellerInfo")
//    public ResponseEntity<Map<String, Object>> getSellerInfo(HttpSession session) {
//        String sellerId = (String) session.getAttribute("selId");
//        
//        // sellerId 값 확인
//        System.out.println("✅ 현재 로그인된 판매자 ID: " + sellerId);
//        
//        Map<String, Object> sellerInfo = service.getSellerInfo(sellerId);
//
//        if (sellerInfo == null) {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
//        }
//
//        // 기존 이미지 경로 추가
//        sellerInfo.put("storePpPath", sellerInfo.get("sel_pp")); // 프로필 이미지 경로
//        sellerInfo.put("storeBpPath", sellerInfo.get("sel_bp")); // 배경 이미지 경로
//
//        System.out.println("✅ 프로필 이미지 경로: " + sellerInfo.get("storePpPath"));
//        System.out.println("✅ 배경 이미지 경로: " + sellerInfo.get("storeBpPath"));
//
//        return ResponseEntity.ok(sellerInfo);
//    }
    
	@ResponseBody
    @PostMapping("selModifyForm")
    public Map<String, Object> getSelModifyForm(HttpSession session) {
           	
    	Map<String, Object> sell = new HashMap<>();
        sell.put("sel_id", session.getAttribute("storeId"));
        return service.selModifyForm(sell); 
    }
    
	@PostMapping("sellermodify")
	public ResponseEntity<?> sellermodify(HttpSession session,
			HttpServletRequest req,
	        @RequestParam("sel_pw") String selPw,
	        @RequestParam("sel_nm") String selNm,
	        @RequestParam("sel_rn") String selRn,
	        @RequestParam("sel_br") String selBr,
	        @RequestParam("sel_ad") String selAd,
	        @RequestParam("sel_cs") String selCs,
	        @RequestParam("sel_mn") String selMn,
	        @RequestParam("sel_mp") String selMp,
	        @RequestParam(value="storePpFile", required=false) MultipartFile storePpFile,
	        @RequestParam(value="storeBpFile", required=false) MultipartFile storeBpFile,
	        @RequestParam(value="existingStorePp", required=false) String existingStorePp,
	        @RequestParam(value="existingStoreBp", required=false) String existingStoreBp) {

	    Map<String, Object> selModifyForm = new HashMap<>();
	    selModifyForm.put("sel_id", session.getAttribute("storeId"));
	    selModifyForm.put("sel_pw", selPw);
	    selModifyForm.put("sel_nm", selNm);
	    selModifyForm.put("sel_rn", selRn);
	    selModifyForm.put("sel_br", selBr);
	    selModifyForm.put("sel_ad", selAd);
	    selModifyForm.put("sel_cs", selCs);
	    selModifyForm.put("sel_mn", selMn);
	    selModifyForm.put("sel_mp", selMp);

	    // 스토어 프로필 이미지 저장
	    if (storePpFile != null && !storePpFile.isEmpty()) {
	        String savedStorePp = (String) service.uploadProfileImage(req, storePpFile).get("sel_pp");
	        selModifyForm.put("storePpFile", savedStorePp);
	    } else {
	        selModifyForm.put("storePpFile", existingStorePp);
	    }

	    // 스토어 배경 이미지 저장
	    if (storeBpFile != null && !storeBpFile.isEmpty()) {
	        String savedStoreBp = (String) service.uploadBackgroundImage(req, storeBpFile).get("sel_bp");
	        selModifyForm.put("storeBpFile", savedStoreBp);
	    } else {
	        selModifyForm.put("storeBpFile", existingStoreBp);
	    }

	    
	    service.sellerModify(selModifyForm);
	    return ResponseEntity.ok().build();
	}


 
	// 회원 탈퇴
	@ResponseBody
	@GetMapping("sellerWithdraw")
	public void sellerWithdraw(HttpSession session, Map<String, Object> seller) {
		seller.put("sel_id", session.getAttribute("sel_id"));
		
		service.Withdraw(seller);
		session.invalidate();
	}
}