package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SellerMapper2 {

	public Map<String, Object> prdList(Map<String, Object> prdList);
}
