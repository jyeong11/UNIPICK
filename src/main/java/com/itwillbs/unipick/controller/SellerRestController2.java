package com.itwillbs.unipick.controller;

import java.util.HashMap;
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
    private SellerService2 sellerService;

    // 이미지 업로드 및 DB 저장
    @PostMapping("productInsert")
    public String uploadImage(MultipartHttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes) {
        Map<String, MultipartFile> fileMap = request.getFileMap();
        Map<String, Object> result = new HashMap<>();

        for (String key : fileMap.keySet()) {
            MultipartFile file = fileMap.get(key);
            Map<String, Object> uploadResult = sellerService.uploadImage(file, session);
            result.put(key, uploadResult.get("filePath"));
        }
        redirectAttributes.addFlashAttribute("uploadResult", result);
        return "redirect:/productList";
    }

    // 카테고리 조회 (드롭다운용)
    @GetMapping("productCategory")
    public List<Map<String, Object>> getProductCategory(@RequestParam(required = false) String parentCode) {
        return sellerService.getCategories(parentCode);
    }

    // 상품 등록 API (상품 ID는 서버에서 생성)
    @PostMapping("/api/insertProduct")
    public ResponseEntity<?> insertProduct(@RequestBody Map<String, Object> productData) {
        productData.put("prd_id", UUID.randomUUID().toString());
        sellerService.insertProduct(productData);
        return ResponseEntity.ok(Map.of("message", "상품 등록 성공"));
    }
    
    // 배송 옵션 조회 API
    @GetMapping("deliveryOptions")
    public ResponseEntity<?> getDeliveryOptions() {
        List<Map<String, Object>> options = sellerService.getDeliveryOptions();
        return ResponseEntity.ok(options);
    }
}
