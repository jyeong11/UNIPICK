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
import org.springframework.web.bind.annotation.RequestMapping;
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
        
        String[] colors = request.getParameterValues("color_number");
        if (colors != null && colors.length > 0) {
            String productId = "TEST_PRODUCT_ID"; // 실제 등록 후 생성된 상품ID 사용
            String sellerId = "TEST_SELLER_ID";     // 세션 또는 인증정보에서 가져오기
            
            for (String colorHex : colors) {
                // 예시: 색상 정보 객체 생성 후 DB 저장 메서드 호출
                Map<String, Object> colorData = new HashMap<>();
                colorData.put("sel_id", sellerId);
                colorData.put("prd_id", productId);
                colorData.put("clr_nm", "");  // 사용자가 선택한 색상의 이름은 선택 사항
                colorData.put("clr_hx", colorHex);
                
                sellerService.insertProductColor(colorData);
            }
        }
        
        redirectAttributes.addFlashAttribute("uploadResult", result);
        return "redirect:/productList";
    }

    // 상품 등록 API
    @PostMapping("/insertProduct")  
    public ResponseEntity<?> insertProduct(@RequestBody Map<String, Object> productData) {
        productData.put("prd_id", UUID.randomUUID().toString());
        sellerService.insertProduct(productData);
        return ResponseEntity.ok(Map.of("message", "상품 등록 성공"));
    }

    // 카테고리 조회 API
    @GetMapping("/productCategory")
    public List<Map<String, Object>> getProductCategory(@RequestParam(required = false) String parentCode) {
        return sellerService.getCategories(parentCode);
    }

    // 배송 옵션 조회 API
    @GetMapping("/deliveryOptions")
    public ResponseEntity<?> getDeliveryOptions() {
        List<Map<String, Object>> options = sellerService.getDeliveryOptions();
        return ResponseEntity.ok(options);
    }

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
