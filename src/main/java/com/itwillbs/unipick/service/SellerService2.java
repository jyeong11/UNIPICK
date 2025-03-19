package com.itwillbs.unipick.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.mapper.SellerMapper2;

@Service
public class SellerService2 {

    @Autowired
    private SellerMapper2 mapper;

    private static final String UPLOAD_DIR = "/upload/images"; // application.properties에서 관리 가능

    // 파일 업로드 및 검증
    public Map<String, Object> uploadImage(MultipartFile imageFile) {
        Map<String, Object> result = new HashMap<>();
        if (imageFile == null || imageFile.isEmpty()) {
            result.put("error", "업로드할 파일이 없습니다.");
            return result;
        }

        // 확장자 검사 (jpg, png만 허용)
        String originalFilename = imageFile.getOriginalFilename();
        if (originalFilename == null || !originalFilename.matches(".*\\.(jpg|png)$")) {
            result.put("error", "허용되지 않는 파일 형식입니다. (jpg, png만 가능)");
            return result;
        }

        // 고유 파일명 생성
        String uniqueFileName = UUID.randomUUID() + "_" + originalFilename;
        String savePath = Paths.get(UPLOAD_DIR, uniqueFileName).toString();

        // 파일 저장
        try {
            imageFile.transferTo(new File(savePath));
            result.put("imagePath", savePath);
            result.put("imageName", uniqueFileName);
        } catch (IOException e) {
            result.put("error", "파일 저장 실패: " + e.getMessage());
        }

        return result;
    }

    // ✅ 트랜잭션 적용하여 상품, 이미지, 재고, 색상, 사이즈 한 번에 저장
    @Transactional
    public void registerProduct(Map<String, Object> productData, List<MultipartFile> imageFiles) {
        // 1. 상품 정보 저장
        mapper.insertProduct(productData);
        Integer productId = (Integer) productData.get("product_id"); // DB에서 생성된 ID 가져오기

        if (productId == null) {
            throw new RuntimeException("상품 등록 실패: product_id가 생성되지 않음");
        }

        // 2. 상품 이미지 저장
        for (MultipartFile imageFile : imageFiles) {
            Map<String, Object> imageData = uploadImage(imageFile);
            if (imageData.containsKey("error")) continue; // 오류 발생 시 해당 이미지 스킵
            
            imageData.put("product_id", productId);
            mapper.insertProductImage(imageData);
        }

        // 3. 재고 저장
        List<Map<String, Object>> stockList = (List<Map<String, Object>>) productData.get("stockList");
        if (stockList != null) {
            for (Map<String, Object> stock : stockList) {
                stock.put("product_id", productId);
                mapper.insertStock(stock);
            }
        }

        // 4. 색상 저장
        List<String> colorList = (List<String>) productData.get("colorList");
        if (colorList != null) {
            for (String color : colorList) {
                Map<String, Object> colorData = new HashMap<>();
                colorData.put("product_id", productId);
                colorData.put("color", color);
                mapper.insertColor(colorData);
            }
        }

        // 5. 사이즈 저장
        List<String> sizeList = (List<String>) productData.get("sizeList");
        if (sizeList != null) {
            for (String size : sizeList) {
                Map<String, Object> sizeData = new HashMap<>();
                sizeData.put("product_id", productId);
                sizeData.put("size", size);
                mapper.insertSize(sizeData);
            }
        }
    }

    // 카테고리 조회
    public List<Map<String, Object>> getCategories(String parentCode) {
        return mapper.selectCategories(parentCode);
    }
    
    public void saveCategorySelection(Map<String, Object> selection) {
        mapper.insertCategorySelection(selection);
    }
    
    // 배송 옵션 조회 (공통코드 그룹 "SHIPPING" 사용)
    public List<Map<String, Object>> getDeliveryOptions() {
        return mapper.selectDeliveryOptions("SHIPPING");
    }
    
    // 재고 관리 옵션 조회 (공통코드 그룹 "STOCK_MANAGEMENT" 사용)
    public List<Map<String, Object>> getStockOptions() {
        return mapper.selectStockOptions("STOCK_MANAGEMENT");
    }
        
    
    public List<Map<String, Object>> getSizeOptions() {
        return mapper.selectSizeOptions("SIZE");
    }
}