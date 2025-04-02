package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;


@Mapper
public interface AdminMapper2 {
	
	// 관리자 등록
	public int registerAdmin(Map<String, Object> admin);
	
	// 관리자 스토어 매핑 등록
	public int registerAdminStores(Map<String, Object> mapping);
	
	// 관리자 목록 조회
	public List<Map<String, Object>> getAdminList();
	
	// 관리자별 스토어 목록 조회
	public List<Map<String, Object>> getAdminStores(String admId);
	
	// 판매자 검색
	public List<Map<String, Object>> searchSellers(String keyword);
	
	// 관리자 스토어 매핑 삭제
	public int deleteAdminStores(String admId);
	
	// 관리자 권한 업데이트
	public int updateAdminRole(Map<String, Object> admin);

}
