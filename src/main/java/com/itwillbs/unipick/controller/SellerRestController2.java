package com.itwillbs.unipick.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.service.SellerService2;

@RestController
@RequestMapping("/seller")
public class SellerRestController2 {

    @Autowired
    private SellerService2 sellerService;

    // ✅ 상품 등록 (상품 정보 + 이미지 + 재고 + 색상 + 사이즈)
    @PostMapping("/registerProduct")
    public ResponseEntity<?> registerProduct(
            @RequestPart("productData") Map<String, Object> productData, // JSON 데이터
            @RequestPart(value = "imageFiles", required = false) List<MultipartFile> imageFiles) { // 이미지들

        try {
            // null 체크: 이미지 리스트가 없을 경우 빈 리스트로 처리
            if (imageFiles == null) {
                imageFiles = List.of();
            }

            // 상품 등록 서비스 호출
            sellerService.registerProduct(productData, imageFiles);

            return ResponseEntity.ok(Map.of("message", "상품이 등록되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.status(500).body("상품 등록 중 오류 발생: " + e.getMessage());
        }
    }

    // 카테고리 조회 API
    @GetMapping("/productCategory")
    public List<Map<String, Object>> getProductCategory(@RequestParam(required = false) String parentCode) {
        return sellerService.getCategories(parentCode);
    }

//    // 배송 옵션 조회 API
//    @GetMapping("/deliveryOptions")
//    public ResponseEntity<?> getDeliveryOptions() {
//        List<Map<String, Object>> options = sellerService.getDeliveryOptions();
//        return ResponseEntity.ok(options);
//    }

    // 재고 옵션 조회 API
    @GetMapping("/stockOptions")
    public List<Map<String, Object>> getStockOptions() {
        return sellerService.getStockOptions();
    }

    @GetMapping("/sizeOptions")
    public List<Map<String, Object>> getSizeOptions(){
    	return sellerService.getSizeOptions();
    }
    
    
}
