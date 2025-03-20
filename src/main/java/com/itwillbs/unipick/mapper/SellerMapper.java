package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SellerMapper {

	public int sellerjoin(Map<String, Object> sellerinfo);
	
	public Map<String, Object> sellerselect(Map<String, Object> seldata);
	
	// 상품 상세 조회
	public Map<String, Object> productDetail(Map<String, Object> prdData);
}
