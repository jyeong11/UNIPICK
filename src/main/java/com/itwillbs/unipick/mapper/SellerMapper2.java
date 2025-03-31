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
    
    
	public Map<String, Object> selModifyForm(Map<String, Object> sell);
	
	// 구매자 정보 수정
	public void sellerModify(Map<String, Object> selModifyForm);
	
	// 회원 탈퇴
	public void Withdraw(Map<String, Object> seller);
	
    
}
