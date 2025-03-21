package com.itwillbs.unipick.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.BuyerMapper;

@Service
public class BuyerService {
	
	@Autowired
	BuyerMapper mapper;
	
	// 방문자 수 증가
	public void visitCount() {
        mapper.visitCount();
    }
	//상단메뉴바
	public List<Map<String, Object>> getAllMenu(){
		return mapper.getAllMenu();
	}
	//상품검색
	public List<Map<String, Object>> getSearchPrd(String query) {
		return mapper.getSearchPrd(query);
	}
	//상품 상세 조회
	public Map<String, Object> getPrdDetail(String prdCd) {
		return mapper.getPrdDetail(prdCd);
	}
	// 상품 상세 이미지
	public List<String> getPrdImg(String prdCd) {
		return mapper.getPrdImg(prdCd);
	}
	//상품 상세 옵션 
	public List<Map<String, Object>> getPrdOption(String prdCd) {
		return mapper.getPrdOption(prdCd);
	}
	// 카테고리 메뉴
	public List<Map<String, Object>> getCategory() {
		return mapper.getCategory();
	}
	// 상품정렬종류
	public Map<String, Object> productListData() {
		Map<String, Object> productListData = new HashMap<String, Object>();
		productListData.put("cate", mapper.getCategory());
		productListData.put("kind", mapper.getProductSortKind());
		return productListData;
	}
	// 상품정렬
	public List<Map<String, Object>> productSort(Map<String, Object> option) {
		return mapper.productSort(option);
	}
	//상품 컬러
	public List<Map<String, Object>> getColors(Map<String, Object> option) {
		return mapper.getColors(option);
	}
}
