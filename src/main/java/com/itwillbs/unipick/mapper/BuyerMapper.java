package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BuyerMapper {
		public List<Map<String, Object>> getAllMenu();
	
}
