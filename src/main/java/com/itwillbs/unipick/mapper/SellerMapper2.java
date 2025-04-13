package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SellerMapper2 {
	
	
    // 검색 조건과 페이징 정보를 전달받아 상품 리스트 조회 (XML 매퍼의 <select id="getProductList">와 연동)
	List<Map<String, Object>> getProductList(Map<String, Object> paramMap);

    // 검색 조건에 따른 전체 상품 건수 조회 (XML 매퍼의 <select id="getProductListCount">와 연동)
    int getProductListCount(Map<String, String> map);
    
    
	List<Map<String, Object>> getOrderList(Map<String, Object> paramMap);

    int getOrderListCount(Map<String, String> map);

    
    public Map<String, Object> prdList(Map<String, Object> prdList);

    void insertProduct(Map<String, Object> product);
    void insertProductImage(Map<String, Object> paramMap);
    void insertProductOptions(Map<String, Object> productData);
    List<Map<String, Object>> selectCategories(String parentCode);  

    public void insertCategorySelection(Map<String, Object> selection);
    
    List<Map<String, Object>> selectDeliveryOptions(String comCd);
    
    List<Map<String, Object>> selectStockOptions(String comCd);
    
    List<Map<String, Object>>selectSizeOptions(String comCd);

    List<Map<String, Object>>selectBadgeOptions(String comCd);
    public void insertBadgeSelection(Map<String, Object> selection);
    
    //public Map<String, Object> getSellerInfo(String sellerId);
    
	public Map<String, Object> selModifyForm(Map<String, Object> sell);
	
	// 구매자 정보 수정
	public void sellerModify(Map<String, Object> selModifyForm);
	
	// 회원 탈퇴
	public void Withdraw(Map<String, Object> seller);
	
    List<Map<String, Object>> getSettlementList(Map<String, Object> params);
    
    // 날짜별 방문자 수 조회
    List<Map<String, Object>> getDailyVisits(@Param("sellerId") String sellerId);

    // 인기 상품 조회
    List<Map<String, Object>> getPopularProducts(@Param("sellerId") String sellerId);
    
    int countBySellerAndProduct(Map<String, Object> params); // 판매자의 상품인지 확인
    void insertProductVisitLog(Map<String, Object> params); // 방문 로그 저장
    List<Map<String, Object>> getDetailedVisits(@Param("sellerId") String sellerId);
    
    List<Map<String, Object>> getVisitsByPeriod(Map<String, Object> params);
    List<Map<String, Object>> getPopularProductsByPeriod(Map<String, Object> params);
    
    // 공통코드 조회 (ex: DELIVERY)
    List<Map<String, Object>> getCommonCode(String comCd);
    
    // 주문상태 업데이트
    void updateOrderStatus(Map<String, Object> params);
    
    // 상품 코드로 판매자 ID 조회
    public String getSellerIdByProductId(String productId);
}
