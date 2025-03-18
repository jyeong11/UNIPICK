package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SellerMapper2 {

	public Map<String, Object> prdList(Map<String, Object> prdList);

	public void insertProductImage(Map<String, Object> paramMap);
	
	void insertProduct(Map<String, Object> product);
    
    List<Map<String, Object>> selectCategories(String parentCode);
	
	public void insertCategorySelection(Map<String, Object> selection);
}
