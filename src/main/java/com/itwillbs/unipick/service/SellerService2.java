package com.itwillbs.unipick.service;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
    public void registerProduct(HttpSession session, HttpServletRequest req, Map<String, Object> productData, List<MultipartFile> imageFiles, List<String> imageIndexs) {
    	
    	   String selId = (String) session.getAttribute("selId");  // 세션 키 확인 필요

    	    // productData에 sel_id 추가
    	    productData.put("sel_id", selId);
    	
    	// 1. 상품 정보 저장
        mapper.insertProduct(productData);
        System.out.println("상품 등록 후 productData: " + productData);
        System.out.println("상품 코드 (prd_cd): " + productData.get("prd_cd"));

        if (productData.get("prd_cd") == null) {
            System.out.println("❌ prd_cd가 NULL입니다! 상품이 정상적으로 저장되지 않았습니다.");
            return;
        }

        // 2. 상품 이미지 저장
        for (int i = 0; i < imageFiles.size(); i++) {
        	MultipartFile imageFile = imageFiles.get(i);
        	String fil_nb = imageIndexs.get(i);
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
            imageData.put("fil_nb", fil_nb);

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
    
    public List<Map<String,Object>> getBadgeOptions(){
    	return mapper.selectBadgeOptions("BADGE");
    }
    
    public void saveBadgeSelection(Map<String, Object> selection) {
        mapper.insertBadgeSelection(selection);
    }
    
	public Map<String, Object> selModifyForm(Map<String, Object> sell) {
		return mapper.selModifyForm(sell);
	}
	
	public void sellerModify(Map<String, Object> selModifyForm) {
	    // 파일과 관련된 추가 로직이 필요한 경우 여기서 처리 가능
	    mapper.sellerModify(selModifyForm);
	}
	
	// 회원 탈퇴
	public void Withdraw(Map<String, Object> seller) {
		mapper.Withdraw(seller);
	}

	// 파일 업로드 및 검증
	public Map<String, Object> uploadProfileImage(HttpServletRequest req, MultipartFile profileImageFile) {
	    Map<String, Object> imageData = new HashMap<>();
	    ServletContext servletContext = req.getServletContext();

	    if (profileImageFile == null || profileImageFile.isEmpty()) {
	        imageData.put("error", "프로필 이미지 파일이 없습니다.");
	        return imageData;
	    }

	    try {
	        String originalFilename = profileImageFile.getOriginalFilename();
	        System.out.println("✅ 프로필 원본 파일명: " + originalFilename);

	        String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;

	        String uploadDir = servletContext.getRealPath("/resources/profile/");
	        File folder = new File(uploadDir);
	        if (!folder.exists()) {
	            folder.mkdirs();
	        }

	        String fullPath = uploadDir + uniqueFilename;
	        File destFile = new File(fullPath);
	        profileImageFile.transferTo(destFile);

	        String filePath = "/resources/profile/" + uniqueFilename;

	        imageData.put("sel_pp", filePath);

	        System.out.println("📂 프로필 이미지 저장된 파일명: " + uniqueFilename);
	        System.out.println("📂 프로필 이미지 실제 저장 경로: " + fullPath);
	        System.out.println("📂 프로필 이미지 DB 저장 경로: " + filePath);

	    } catch (Exception e) {
	        System.out.println("❌ 프로필 이미지 업로드 중 오류 발생: " + e.getMessage());
	        imageData.put("error", "프로필 이미지 업로드 실패");
	        e.printStackTrace();
	    }

	    return imageData;
	}

	public Map<String, Object> uploadBackgroundImage(HttpServletRequest req, MultipartFile backgroundImageFile) {
	    Map<String, Object> imageData = new HashMap<>();
	    ServletContext servletContext = req.getServletContext();

	    if (backgroundImageFile == null || backgroundImageFile.isEmpty()) {
	        imageData.put("error", "배경 이미지 파일이 없습니다.");
	        return imageData;
	    }

	    try {
	        String originalFilename = backgroundImageFile.getOriginalFilename();
	        System.out.println("✅ 배경 원본 파일명: " + originalFilename);

	        String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;

	        String uploadDir = servletContext.getRealPath("/resources/background/");
	        File folder = new File(uploadDir);
	        if (!folder.exists()) {
	            folder.mkdirs();
	        }

	        String fullPath = uploadDir + uniqueFilename;
	        File destFile = new File(fullPath);
	        backgroundImageFile.transferTo(destFile);

	        String filePath = "/resources/background/" + uniqueFilename;

	        imageData.put("sel_bp", filePath);

	        System.out.println("📂 배경 이미지 저장된 파일명: " + uniqueFilename);
	        System.out.println("📂 배경 이미지 실제 저장 경로: " + fullPath);
	        System.out.println("📂 배경 이미지 DB 저장 경로: " + filePath);

	    } catch (Exception e) {
	        System.out.println("❌ 배경 이미지 업로드 중 오류 발생: " + e.getMessage());
	        imageData.put("error", "배경 이미지 업로드 실패");
	        e.printStackTrace();
	    }

	    return imageData;
	}
	

    public List<Map<String, Object>> getSettlementList(Map<String, Object> params) {
        return mapper.getSettlementList(params);
    }

    public void generateExcel(List<Map<String, Object>> settlementList, OutputStream outputStream) throws IOException {
        // Apache POI 라이브러리를 사용하여 Excel 파일 생성
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("정산내역");

        // 헤더 스타일 설정
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setBorderTop(BorderStyle.THIN);
        headerStyle.setBorderBottom(BorderStyle.THIN);
        headerStyle.setBorderLeft(BorderStyle.THIN);
        headerStyle.setBorderRight(BorderStyle.THIN);

        // 헤더 생성
        Row headerRow = sheet.createRow(0);
        String[] headers = {"기간", "주문수", "판매수량", "교환건수", "반품건수", "매출액", "수수료", "순이익", "정산일자"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

        // 데이터 입력
        int rowNum = 1;
        for (Map<String, Object> data : settlementList) {
            Row row = sheet.createRow(rowNum++);
            
            row.createCell(0).setCellValue(String.valueOf(data.get("기간")));
            row.createCell(1).setCellValue(String.valueOf(data.get("주문수")));
            row.createCell(2).setCellValue(String.valueOf(data.get("판매수량")));
            row.createCell(3).setCellValue(String.valueOf(data.get("교환건수")));
            row.createCell(4).setCellValue(String.valueOf(data.get("반품건수")));
            row.createCell(5).setCellValue(String.valueOf(data.get("매출액")));
            row.createCell(6).setCellValue(String.valueOf(data.get("수수료")));
            row.createCell(7).setCellValue(String.valueOf(data.get("순이익")));
            row.createCell(8).setCellValue(String.valueOf(data.get("정산일자")));
        }

        // 열 너비 자동 조정
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // 파일 저장
        workbook.write(outputStream);
        workbook.close();
    }
    

    // 날짜별 방문자 수 조회
    public List<Map<String, Object>> getDailyVisits(String sellerId) {
        return mapper.getDailyVisits(sellerId);
    }
    
//  public List<Map<String, Object>> getDetailedVisits(String sellerId) {
//  return mapper.getDetailedVisits(sellerId);
//}

    // 인기 상품 조회
    public List<Map<String, Object>> getPopularProducts(String sellerId) {
        return mapper.getPopularProducts(sellerId);
    }
    
    // 상품이 해당 판매자의 것인지 확인
    public boolean isSellerProduct(Map<String, Object> params) {
        return mapper.countBySellerAndProduct(params) > 0;
    }

    // 방문자 로그 저장
    public void logProductVisit(Map<String, Object> params) {
        try {
            System.out.println("=== 방문자 로그 저장 시도 ===");
            System.out.println("요청 파라미터: " + params);
            
            // 필요한 파라미터 확인
            if (params.get("productId") == null) {
                System.err.println("상품 ID가 null입니다.");
                return;
            }
            
            if (params.get("sellerNm") == null) {
                System.err.println("판매자 이름이 null입니다.");
                return;
            }
            
            // 방문 로그 저장 (오늘 날짜로 자동 설정)
            mapper.insertProductVisitLog(params);
            System.out.println("방문자 로그 저장 성공: 상품ID=" + params.get("productId") + ", 판매자=" + params.get("sellerNm"));
        } catch (Exception e) {
            System.err.println("방문자 로그 저장 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }
    

    
    public List<Map<String, Object>> getVisitsByPeriod(Map<String, Object> params) {
        return mapper.getVisitsByPeriod(params);
    }

    public List<Map<String, Object>> getPopularProductsByPeriod(Map<String, Object> params) {
        return mapper.getPopularProductsByPeriod(params);
    }
    
    // 공통코드 조회
    public List<Map<String, Object>> getCommonCode(String comCd) {
        return mapper.getCommonCode(comCd);
    }
    
    // 주문상태 업데이트
    public void updateOrderStatus(Map<String, Object> params) {
        mapper.updateOrderStatus(params);
    }
}