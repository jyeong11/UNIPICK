package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SellerMapper {

	public int sellerjoin(Map<String, Object> sellerinfo);
	
	public Map<String, Object> sellerselect(Map<String, Object> seldata);
}
