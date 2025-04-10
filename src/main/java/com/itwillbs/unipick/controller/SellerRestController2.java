package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.service.SellerService2;

@RestController
@RequestMapping("/seller")
public class SellerRestController2 {

    @Autowired
    private SellerService2 sellerService;
    
    
  //AJAX를 통한 상품 리스트 조회
    @RequestMapping("/api/selProductList")
    public Map<String, Object> getProductList(
            HttpSession session,
            @RequestParam(value = "prd_nm", required = false, defaultValue = "") String prdNm,
            @RequestParam(value = "prd_ca", required = false, defaultValue = "") String prdCa,
            @RequestParam(value = "clr_nm", required = false, defaultValue = "") String clrNm,
            @RequestParam(value = "siz_nm", required = false, defaultValue = "") String sizNm,
            @RequestParam(value = "prd_cd", required = false, defaultValue = "") String prdCd,
            @RequestParam(value = "startRow", required = false, defaultValue = "0") int startRow,
            @RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit) {

        // 검색 조건 Map 생성
        Map<String, String> searchParams = new HashMap<>();
        // 현재 로그인한 판매자 ID 추가
        String sellerId = (String) session.getAttribute("selId");
        if (sellerId != null && !sellerId.isEmpty()) {
            searchParams.put("sel_id", sellerId);
        }
			if (!prdNm.isEmpty()) searchParams.put("prd_nm", prdNm);
			if (!prdCa.isEmpty()) searchParams.put("prd_ca", prdCa);
			if (!clrNm.isEmpty()) searchParams.put("clr_nm", clrNm);
			if (!sizNm.isEmpty()) searchParams.put("siz_nm", sizNm);
			if (!prdCd.isEmpty()) searchParams.put("prd_cd", prdCd);

        // 상품 리스트 조회
        List<Map<String, Object>> productList = sellerService.getProductList(searchParams, startRow, listLimit);

        // 상품 개수 조회
        int totalCount = sellerService.getProductListCount(searchParams);

        // 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        response.put("productList", productList);
        response.put("totalCount", totalCount);

        return response;
    }

    
  //AJAX를 통한 상품 리스트 조회
    @RequestMapping("/api/selOrderList")
    public Map<String, Object> getOrderList(
            HttpSession session,
            @RequestParam(value = "ord_id", required = false, defaultValue = "") String ordId,
            @RequestParam(value = "ord_at", required = false, defaultValue = "") String ordAt,
            @RequestParam(value = "buy_nm", required = false, defaultValue = "") String buyNm,
            @RequestParam(value = "buy_ph", required = false, defaultValue = "") String buyPh,
            @RequestParam(value = "odd_qt", required = false, defaultValue = "") String oddPt,
            @RequestParam(value = "odd_am", required = false, defaultValue = "") String oddAm,
            @RequestParam(value = "orderStatus", required = false, defaultValue = "all") String orderStatus,
            @RequestParam(value = "startRow", required = false, defaultValue = "0") int startRow,
            @RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit) {

        // 검색 조건 Map 생성
        Map<String, String> search = new HashMap<>();
        
        // 세션에서 판매자 ID 가져오기
        String selId = (String) session.getAttribute("selId");
        if (selId != null && !selId.isEmpty()) {
            search.put("sel_id", selId);
        }
        
        if (!ordId.isEmpty()) search.put("ord_id", ordId);
        if (!ordAt.isEmpty()) search.put("ord_at", ordAt);
        if (!buyNm.isEmpty()) search.put("buy_nm", buyNm);
        if (!buyPh.isEmpty()) search.put("buy_ph", buyPh);
        if (!oddPt.isEmpty()) search.put("odd_qt", oddPt);
        if (!oddAm.isEmpty()) search.put("odd_am", oddAm);

        // orderStatus 값이 "all"이 아니라면, 이를 DB의 odd_st 값에 맞게 변환하여 조건에 추가
        if (!"all".equals(orderStatus)) {
            search.put("odd_st", orderStatus);
        }
            
        // 상품 리스트 조회
        List<Map<String, Object>> orderList = sellerService.getOrderList(search, startRow, listLimit);
        System.out.println("검색 파라미터: " + search);
        System.out.println("조회된 주문 목록: " + orderList);

        // 상품 개수 조회
        int totalCount = sellerService.getOrderListCount(search);

        // 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        response.put("orderList", orderList);
        response.put("totalCount", totalCount);

        return response;
    }
    

    
    // ✅ 상품 등록 (상품 정보 + 이미지 + 재고 + 색상 + 사이즈)
    @PostMapping("/registerProduct")
    public ResponseEntity<?> registerProduct(
    		HttpSession session,
    		HttpServletRequest req,
            @RequestPart("productData") Map<String, Object> productData, // JSON 데이터
            @RequestPart(value = "imageFiles", required = false) List<MultipartFile> imageFiles,
            @RequestParam(value = "imageIndexs", required = false) List<String> imageIndexs) { // 이미지들

        try {
            // null 체크: 이미지 리스트가 없을 경우 빈 리스트로 처리
            if (imageFiles == null) {
                imageFiles = List.of();
            }
            
            System.out.println(imageIndexs);

            // 상품 등록 서비스 호출
            sellerService.registerProduct(session, req, productData, imageFiles, imageIndexs);

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
    
    @GetMapping("/badgeOptions")
    public List<Map<String, Object>> getBadgeOptions(){
    	return sellerService.getBadgeOptions();
    }
    
    
    // 공통코드 조회 API
    @GetMapping("/commonCode")
    public List<Map<String, Object>> getCommonCode(@RequestParam String comCd) {
        return sellerService.getCommonCode(comCd);
    }
    
    // 주문상태 업데이트 API
    @PostMapping("/updateOrderStatus")
    public ResponseEntity<?> updateOrderStatus(@RequestParam String ordId, @RequestParam String statusCode) {
        try {
            if (ordId == null || ordId.isEmpty() || statusCode == null || statusCode.isEmpty() || "undefined".equals(statusCode)) {
                return ResponseEntity.badRequest().body("주문 ID와 상태 코드는 필수이며, 유효한 값이어야 합니다.");
            }

            // DELIVERY01 ~ DELIVERY11 코드를 해당하는 짧은 상태명으로 변환
            String convertedStatus = convertStatusCode(statusCode);
            
            System.out.println("상태 코드 변환: " + statusCode + " -> " + convertedStatus);

            Map<String, Object> params = new HashMap<>();
            params.put("ord_id", ordId);
            params.put("odd_st", convertedStatus);
            
            sellerService.updateOrderStatus(params);
            
            return ResponseEntity.ok(Map.of(
                "message", "주문상태가 업데이트 되었습니다.",
                "ordId", ordId,
                "status", convertedStatus
            ));
        } catch (Exception e) {
            return ResponseEntity.status(500).body("주문상태 업데이트 중 오류 발생: " + e.getMessage());
        }
    }
    
    // 상태 코드를 짧은 형태로 변환하는 메소드
    private String convertStatusCode(String statusCode) {
        switch (statusCode) {
            case "DELIVERY01": return "상품준비중";
            case "DELIVERY02": return "배송준비중";
            case "DELIVERY03": return "배송시작";
            case "DELIVERY04": return "배송중";
            case "DELIVERY05": return "배송완료";
            case "DELIVERY06": return "교환접수";
            case "DELIVERY07": return "교환취소";
            case "DELIVERY08": return "교환완료";
            case "DELIVERY09": return "반품접수";
            case "DELIVERY10": return "반품취소";
            case "DELIVERY11": return "반품완료";
            default: return "상품준비중"; // 알 수 없는 코드는 기본값으로 설정
        }
    }
    
}
