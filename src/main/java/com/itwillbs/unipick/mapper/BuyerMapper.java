package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BuyerMapper {
	//상단 메뉴바
	public List<Map<String, Object>> getAllMenu();
	//상품검색
	public List<Map<String, Object>> getSearchPrd(String query);
	// 카테고리 메뉴
	public List<Map<String, Object>> getCategory();
	
	// 정렬 
	public List<Map<String, Object>> productSort();
	
	public List<Map<String, Object>> getProductSortKind();
}
