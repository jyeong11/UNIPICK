package com.itwillbs.unipick.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.controller.UtilityController;
import com.itwillbs.unipick.mapper.SellerMapper2;

@Service
public class SellerService2 {

    @Autowired
    private SellerMapper2 mapper;

    // 파일 저장 경로 (프로퍼티 파일 등으로 관리 권장)
    private static final String REAL_PATH = "upload/images";
    private static final String VIRTUAL_PATH = "/resources/uploads";

    public Map<String, Object> uploadImage(MultipartFile imageFile, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (imageFile == null || imageFile.isEmpty()) {
            result.put("error", "업로드할 파일이 없습니다.");
            return result;
        }
        String subDir = UtilityController.createDirectories(REAL_PATH);
        String newRealPath = REAL_PATH + "/" + subDir;

        String originalFileName = imageFile.getOriginalFilename();
        if (originalFileName != null && !originalFileName.trim().isEmpty()) {
            String fileName = UUID.randomUUID().toString() + "_" + originalFileName;
            try {
                File targetFile = new File(newRealPath, fileName);
                if (!targetFile.getParentFile().exists()) {
                    targetFile.getParentFile().mkdirs();
                }
                imageFile.transferTo(targetFile);
                String fileVirtualPath = VIRTUAL_PATH + "/" + subDir + "/" + fileName;
                result.put("filePath", fileVirtualPath);

                Map<String, Object> paramMap = new HashMap<>();
                paramMap.put("imageId", UUID.randomUUID().toString());
                paramMap.put("productId", "TEST_PRODUCT_ID");
                paramMap.put("sellerId", "TEST_SELLER_ID");
                paramMap.put("fileName", fileName);
                paramMap.put("filePath", fileVirtualPath);
                mapper.insertProductImage(paramMap);
            } catch (Exception e) {
                e.printStackTrace();
                result.put("error", "파일 업로드 실패: " + e.getMessage());
            }
        }
        return result;
    }

    // 상품 등록
    public void insertProduct(Map<String, Object> product) {
        mapper.insertProduct(product);
    }

    // 카테고리 조회
    public List<Map<String, Object>> getCategories(String parentCode) {
        return mapper.selectCategories(parentCode);
    }
    
    public void saveCategorySelection(Map<String, Object> selection) {
        mapper.insertCategorySelection(selection);
    }
    
    // 배송 옵션 조회 (공통코드 그룹 "DELIVERY" 사용)
    public List<Map<String, Object>> getDeliveryOptions() {
        return mapper.selectDeliveryOptions("SHIPPING");
    }
}
