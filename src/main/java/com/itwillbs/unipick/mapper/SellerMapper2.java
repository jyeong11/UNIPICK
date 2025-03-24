package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SellerMapper2 {

    public Map<String, Object> prdList(Map<String, Object> prdList);

    void insertProduct(Map<String, Object> product);
    void insertProductImage(Map<String, Object> paramMap);
    void insertProductOptions(Map<String, Object> productData);
    List<Map<String, Object>> selectCategories(String parentCode);

    public void insertCategorySelection(Map<String, Object> selection);
    
    List<Map<String, Object>> selectDeliveryOptions(String comCd);
    
    // 재고 관리 옵션을 위한 상세 공통코드 조회 (공통코드 그룹: STOCK_MANAGEMENT)
    List<Map<String, Object>> selectStockOptions(String comCd);
    
    List<Map<String, Object>>selectSizeOptions(String comCd);

	
    
}
