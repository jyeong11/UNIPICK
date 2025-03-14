package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	Map<String, Object> memberLogins(Map<String, Object> memberlogin);

}
