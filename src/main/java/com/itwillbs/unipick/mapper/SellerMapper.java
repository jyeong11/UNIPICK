package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SellerMapper {

	public Map<String, Object> sellerjoin(Map<String, Object> sellerinfo);
}
