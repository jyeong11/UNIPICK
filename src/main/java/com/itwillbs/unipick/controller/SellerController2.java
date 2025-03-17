package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.unipick.service.SellerService2;

@Controller
public class SellerController2 {

	@Autowired
	SellerService2 sellerservice;
	
	@GetMapping("prdRegister")
	public String prdRegister() {
		return "seller/productRegister";
	}
	
	@GetMapping("productList")
	public String prdList() {
		return "seller/productList";
	}
	
    @PostMapping("productInsert")
    public String uploadImage(MultipartHttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes) {
        Map<String, MultipartFile> fileMap = request.getFileMap();
        Map<String, Object> result = new HashMap<>();
        
        // 각 파일에 대해 업로드 처리
        for (String key : fileMap.keySet()) {
            MultipartFile file = fileMap.get(key);
            Map<String, Object> uploadResult = sellerservice.uploadImage(file, session);
            // 예: key: 파일 입력 필드 이름, value: 업로드된 가상 경로
            result.put(key, uploadResult.get("filePath"));
        }
        
        // 필요 시 업로드 결과를 FlashAttribute로 전달할 수 있습니다.
        redirectAttributes.addFlashAttribute("uploadResult", result);
        
        // 상품 등록 후 productList.jsp로 리다이렉트
        return "redirect:/productList";
    }
}
