package com.itwillbs.unipick.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.mapper.SellerMapper2;

@Service
public class SellerService2 {

    @Autowired
    private SellerMapper2 mapper;
    
 // 검색 조건과 페이징 정보를 전달받아 상품 리스트 조회
    public List<Map<String, Object>> getProductList(Map<String, String> searchParams, int startRow, int listLimit) {
        // 페이징 정보 추가
        List<Object> pageList = new ArrayList<>();
        pageList.add(startRow);
        pageList.add(listLimit);

        // 파라미터를 Map에 넣어 매퍼에 전달
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("map", searchParams);  // 검색 조건
        paramMap.put("pageList", pageList); // 페이징 정보

        return mapper.getProductList(paramMap);  // 매퍼 호출
    }

    public int getProductListCount(Map<String, String> searchParams) {
        return mapper.getProductListCount(searchParams);  // 상품 개수 조회
    }
    
 
    public List<Map<String, Object>> getOrderList(Map<String, String> search, int startRow, int listLimit) {
    	List<Object> pageList = new ArrayList<>();
    	pageList.add(startRow);
    	pageList.add(listLimit);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("map", search);  
        paramMap.put("pageList", pageList); 

        return mapper.getOrderList(paramMap);
    }

    public int getOrderListCount(Map<String, String> search) {
        return mapper.getOrderListCount(search);
    }
    
    
    

    // 파일 업로드 및 검증
    public Map<String, Object> uploadImage(HttpServletRequest req, MultipartFile imageFile) {
        Map<String, Object> imageData = new HashMap<>();
     // HttpServletRequest에서 ServletContext 가져오기
        ServletContext servletContext = req.getServletContext();

        if (imageFile == null || imageFile.isEmpty()) {
            imageData.put("error", "이미지 파일이 없습니다.");
            return imageData;
        }

        try {
            // 파일 원본 이름 가져오기
            String originalFilename = imageFile.getOriginalFilename();
            System.out.println("✅ 원본 파일명: " + originalFilename);

            if (originalFilename == null || originalFilename.trim().isEmpty()) {
                imageData.put("error", "파일명이 올바르지 않습니다.");
                return imageData;
            }

            // 고유한 파일명 생성 (중복 방지)
            String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;

            // 실제 저장할 경로 (로컬 파일 시스템)
            String uploadDir = servletContext.getRealPath("/resources/productImg/");
            File folder = new File(uploadDir);
            if (!folder.exists()) {
                folder.mkdirs(); // 폴더가 없으면 생성
            }

            // 파일 저장 경로 설정
            String fullPath = uploadDir + uniqueFilename;
            File destFile = new File(fullPath);
            imageFile.transferTo(destFile); // 파일 저장

            // DB에 저장할 가상 경로
            String filePath = "/resources/productImg/" + uniqueFilename;

            // 필수 데이터 저장
            imageData.put("fil_nm", uniqueFilename); // 파일명 추가
            imageData.put("fil_pt", filePath); // 가상 경로 추가

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

    // 트랜잭션 적용하여 상품, 이미지, 재고, 색상, 사이즈 한 번에 저장
    @Transactional
    public void registerProduct(HttpServletRequest req, Map<String, Object> productData, List<MultipartFile> imageFiles) {
    	
    	
    	
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
            if (imageFile == null || imageFile.isEmpty()) {
                continue;
            }

            // 이미지 업로드
            Map<String, Object> imageData = uploadImage(req, imageFile);
            if (imageData.containsKey("error")) {
                continue;
            }

            imageData.put("prd_cd", productData.get("prd_cd"));
            imageData.put("sel_id", productData.get("sel_id"));

            try {
                mapper.insertProductImage(imageData);
            } catch (Exception e) {
                System.out.println("❌ 이미지 데이터 삽입 실패: " + e.getMessage());
                e.printStackTrace();
            }
        }
  
        List<String> colors = (List<String>) productData.get("colors");
        List<String> sizes = (List<String>) productData.get("sizes");
        List<String> stocks = (List<String>) productData.get("stocks");
        List<String> colorsnm = (List<String>) productData.get("colorsnm");
        List<String> prds = new ArrayList<String>();
        for(int i = 0; i < sizes.size(); i++) {
        	prds.add((String)productData.get("prd_cd"));
        }

        List<Map<String, Object>> optionList = new ArrayList<>();

        for (int i = 0; i < prds.size(); i++) {
            Map<String, Object> option = new HashMap<>();
            option.put("prd_cd", prds.get(i));
            option.put("siz_nm", sizes.get(i));
            option.put("clr_cd", colors.get(i));
            option.put("prd_qt", stocks.get(i));
            option.put("clr_nm", colorsnm.get(i));
            optionList.add(option);
        }

        Map<String, Object> param = new HashMap<>();
        param.put("options", optionList);

        System.out.println("🔥 최종 데이터: " + param);  // 확인용 로그

        mapper.insertProductOptions(param);

    }

    // 카테고리 조회
    public List<Map<String, Object>> getCategories(String parentCode) {
        return mapper.selectCategories(parentCode);
    }

    public void saveCategorySelection(Map<String, Object> selection) {
        mapper.insertCategorySelection(selection);
    }

//    // 배송 옵션 조회 (공통코드 그룹 "SHIPPING" 사용)
//    public List<Map<String, Object>> getDeliveryOptions() {
//        return mapper.selectDeliveryOptions("SHIPPING");
//    }

    // 재고 관리 옵션 조회 (공통코드 그룹 "STOCK_MANAGEMENT" 사용)
    public List<Map<String, Object>> getStockOptions() {
        return mapper.selectStockOptions("STOCK_MANAGEMENT");
    }

    public List<Map<String, Object>> getSizeOptions() {
        return mapper.selectSizeOptions("SIZE");
    }
    
    
	public Map<String, Object> selModifyForm(Map<String, Object> sell) {
		return mapper.selModifyForm(sell);
	}
	
	// 구매자 정보수정
	public void sellerModify(Map<String, Object> selModifyForm) {
		mapper.sellerModify(selModifyForm);
	}
	
	// 회원 탈퇴
	public void Withdraw(Map<String, Object> seller) {
		mapper.Withdraw(seller);
	}
}