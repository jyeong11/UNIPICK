package com.itwillbs.unipick.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.unipick.service.SellerService2;

@RestController
public class SellerRestController2 {

    @Autowired
    SellerService2 sellerservice;
    
    @PostMapping("productInsert")
    public String uploadImage(MultipartHttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes) {
        Map<String, MultipartFile> fileMap = request.getFileMap();
        Map<String, Object> result = new java.util.HashMap<>();
        
        // 각 파일에 대해 업로드 처리
        for (String key : fileMap.keySet()) {
            MultipartFile file = fileMap.get(key);
            Map<String, Object> uploadResult = sellerservice.uploadImage(file, session);
            result.put(key, uploadResult.get("filePath"));
        }
        
        redirectAttributes.addFlashAttribute("uploadResult", result);
        return "redirect:/productList";
    }
    
 // GET: 카테고리 조회 (드롭다운용)
    @GetMapping("productCategory")
    public List<Map<String, Object>> getProductCategory(@RequestParam(required = false) String parentCode) {
        return sellerservice.getCategories(parentCode);
    }

    // POST: 상품 등록 API
    @PostMapping("/api/insertProduct")
    public ResponseEntity<?> insertProduct(@RequestBody Map<String, Object> productData) {
        // 생성된 상품 ID 설정 (예: UUID)
        productData.put("prd_id", UUID.randomUUID().toString());
        sellerservice.insertProduct(productData);
        return ResponseEntity.ok(Map.of("message", "상품 등록 성공"));
    }
}