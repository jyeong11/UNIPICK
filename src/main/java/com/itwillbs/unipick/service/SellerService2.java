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
	SellerMapper2 mapper;
	
	// 실제 파일이 저장되는 경로 (환경변수나 프로퍼티로 관리할 것을 권장)
    private final String realPath = "upload/images";
    // 클라이언트가 접근할 때 사용하는 가상 경로
    private final String virtualPath = "/resources/uploads";

    public Map<String, Object> uploadImage(MultipartFile imageFile, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        if (imageFile == null || imageFile.isEmpty()) {
            result.put("error", "업로드할 파일이 없습니다.");
            return result;
        }
        
        // 날짜 기반 하위 디렉토리 생성 (예: "2025/02/11")
        String subDir = UtilityController.createDirectories(realPath);
        String newRealPath = realPath + "/" + subDir;
        System.out.println("실제 파일 저장 경로: " + newRealPath);

        String originalFileName = imageFile.getOriginalFilename();
        String fileName = "";
        
        try {
            if (originalFileName != null && !originalFileName.trim().isEmpty()) {
                // UUID를 접두사로 추가하여 파일명 중복 문제 해결
                fileName = UUID.randomUUID().toString() + "_" + originalFileName;
                File targetFile = new File(newRealPath, fileName);
                // 저장할 디렉토리가 없으면 생성
                if (!targetFile.getParentFile().exists()) {
                    targetFile.getParentFile().mkdirs();
                }
                // 실제 파일 저장
                imageFile.transferTo(targetFile);
                // 클라이언트 접근용 가상 경로 생성 (예: "/resources/uploads/2025/02/11/UUID_파일명")
                String fileVirtualPath = virtualPath + "/" + subDir + "/" + fileName;
                result.put("filePath", fileVirtualPath);
               
                String productId = (String) session.getAttribute("productId"); // 또는 request.getParameter("productId")
                String sellerId = (String) session.getAttribute("sellerId");   // 또는 request.getParameter("sellerId")

             // DB에 이미지 정보 등록을 위한 파라미터 설정
                Map<String, Object> paramMap = new HashMap<>();
                paramMap.put("imageId", UUID.randomUUID().toString()); // 혹은 DB가 자동생성하는 경우 생략 가능
                // productId, sellerId 등은 폼의 다른 파라미터 또는 세션 정보를 통해 받아와야 합니다.
                paramMap.put("productId","TEST_PRODUCT_ID" );
                paramMap.put("sellerId", "TEST_SELLER_ID" );
                paramMap.put("fileName", fileName);
                paramMap.put("filePath", fileVirtualPath);

                // 매퍼의 insertProductImage 메서드 호출
                mapper.insertProductImage(paramMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("error", "파일 업로드 실패: " + e.getMessage());
        }
        
        return result;
    }
	
	
    // 상품 등록: productData에 포함된 정보를 PRODUCTS 테이블에 삽입
    public void insertProduct(Map<String, Object> product) {
        // product.get("prd_cd")는 이미 최종 카테고리 코드가 설정되어 있어야 함
        mapper.insertProduct(product);
    }

    // 카테고리 조회
    public List<Map<String, Object>> getCategories(String parentCode) {
        return mapper.selectCategories(parentCode);
    }
    public void saveCategorySelection(Map<String, Object> selection) {
    	mapper.insertCategorySelection(selection);
    }
	
}
