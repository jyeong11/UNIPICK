package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BuyerMapper {
	// 방문자 수 증가
	public void visitCount();
	//상단 메뉴바
	public List<Map<String, Object>> getAllMenu();
	//상품검색
	public List<Map<String, Object>> getSearchPrd(String query);
	//상품 상세조회
	public Map<String, Object> getPrdDetail(String prdCd);
	//상품 상세이미지
	public List<String> getPrdImg(String prdCd);
	// 상품 옵션조회
	public List<Map<String, Object>> getPrdOption(String prdCd);
	// 카테고리 메뉴
	public List<Map<String, Object>> getCategory();
	// 상품 정렬 종류 
	public List<Map<String, Object>> getProductSortKind();
	// 상품 정렬
	public List<Map<String, Object>> productSort(Map<String, Object> option);
	// 상품컬러
	public List<Map<String, Object>> getColors(Map<String, Object> option);
}
