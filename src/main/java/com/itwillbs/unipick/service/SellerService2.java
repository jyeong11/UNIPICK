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

 // 파일 업로드 및 검증
    public Map<String, Object> uploadImage(MultipartFile imageFile) {
        Map<String, Object> imageData = new HashMap<>();

        if (imageFile == null || imageFile.isEmpty()) {
            imageData.put("error", "이미지 파일이 없습니다.");
            return imageData;
        }

        try {
            // ✅ 파일 원본 이름 가져오기
            String originalFilename = imageFile.getOriginalFilename();
            System.out.println("✅ 원본 파일명: " + originalFilename);

            if (originalFilename == null || originalFilename.trim().isEmpty()) {
                imageData.put("error", "파일명이 올바르지 않습니다.");
                return imageData;
            }

            // ✅ 고유한 파일명 생성 (중복 방지)
            String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;

            // ✅ 실제 저장할 경로 (로컬 파일 시스템)
            String uploadDir = "D:/Person/workspace/UNIPICK-PROJECT/UNIPICK/src/main/webapp/resources/productImg/";
            File folder = new File(uploadDir);
            if (!folder.exists()) {
                folder.mkdirs(); // 폴더가 없으면 생성
            }

            // ✅ 파일 저장 경로 설정
            String fullPath = uploadDir + uniqueFilename;
            File destFile = new File(fullPath);
            imageFile.transferTo(destFile); // 파일 저장

            // ✅ DB에 저장할 가상 경로
            String filePath = "/productImg/" + uniqueFilename;

            // ✅ 필수 데이터 저장
            imageData.put("fil_nm", uniqueFilename); // ✅ 파일명 추가
            imageData.put("fil_pt", filePath); // ✅ 가상 경로 추가

            System.out.println("📂 저장된 파일명: " + uniqueFilename);
            System.out.println("📂 실제 저장 경로: " + fullPath);
            System.out.println("📂 DB 저장 경로: " + filePath);

        } catch (Exception e) {
            System.out.println("❌ 이미지 업로드 중 오류 발생: " + e.getMessage());
            imageData.put("error", "파일 업로드 실패");
            e.printStackTrace();
        }

        return imageData;
    }

    // ✅ 트랜잭션 적용하여 상품, 이미지, 재고, 색상, 사이즈 한 번에 저장
    @Transactional
    public void registerProduct(Map<String, Object> productData, List<MultipartFile> imageFiles) {
        // 1. 상품 정보 저장
        mapper.insertProduct(productData);
        System.out.println("상품 등록 후 productData: " + productData);
        System.out.println("상품 코드 (prd_cd): " + productData.get("prd_cd"));

        if (productData.get("prd_cd") == null) {
            System.out.println("❌ prd_cd가 NULL입니다! 상품이 정상적으로 저장되지 않았습니다.");
            return;
        }

     // 2. 상품 이미지 저장
        for (MultipartFile imageFile : imageFiles) {
            System.out.println("🔥 이미지 처리 시작 - 파일명: " + (imageFile != null ? imageFile.getOriginalFilename() : "null"));

            if (imageFile == null || imageFile.isEmpty()) {
                System.out.println("🚨 이미지 파일이 비어 있음, 처리 스킵!");
                continue;
            }

            System.out.println("🛠 `uploadImage()` 함수 호출 전");

            Map<String, Object> imageData = uploadImage(imageFile);
            System.out.println("🔥 업로드된 이미지 데이터: " + imageData);

            if (imageData.containsKey("error")) {
                System.out.println("🚨 이미지 업로드 중 오류 발생, 스킵! (에러: " + imageData.get("error") + ")");
                continue;
            }

            // ✅ 여기서 `sel_id` 추가!
            imageData.put("prd_cd", productData.get("prd_cd"));
            imageData.put("sel_id", productData.get("sel_id"));  // 추가 ✅

            System.out.println("📤 이미지 삽입 직전 imageData: " + imageData);

            try {
                mapper.insertProductImage(imageData);
                System.out.println("✅ 이미지 데이터 삽입 성공");
            } catch (Exception e) {
                System.out.println("❌ 이미지 데이터 삽입 실패: " + e.getMessage());
                e.printStackTrace();
            }
        }

        // 3. 재고 저장
        List<Map<String, Object>> stockList = (List<Map<String, Object>>) productData.get("stockList");
        if (stockList != null) {
            System.out.println("stockList: " + stockList);
            for (Map<String, Object> stock : stockList) {
                stock.put("prd_cd", productData.get("prd_cd"));
                System.out.println("옵션 데이터 삽입 전: " + stock);

                try {
                    mapper.insertStock(stock);
                    System.out.println("옵션 데이터 삽입 성공");
                } catch (Exception e) {
                    System.out.println("옵션 데이터 삽입 실패: " + e.getMessage());
                    e.printStackTrace();
                }
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