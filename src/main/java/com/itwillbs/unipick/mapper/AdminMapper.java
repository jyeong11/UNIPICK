package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	public Map<String, Object> adminInfo(Map<String, Object> admin);
}
