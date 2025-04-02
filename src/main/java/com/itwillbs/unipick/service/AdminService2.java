package com.itwillbs.unipick.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.unipick.mapper.AdminMapper;
import com.itwillbs.unipick.mapper.AdminMapper2;

@Service
public class AdminService2 {
	@Autowired
	AdminMapper2 mapper;
	
	// 관리자 등록
	public void registerAdmin(Map<String, Object> admin) {
		// 관리자 기본 정보 등록
		mapper.registerAdmin(admin);
		
		// 스토어 매핑 등록
		@SuppressWarnings("unchecked")
		List<String> sellerIds = (List<String>) admin.get("seller_ids");
		if (sellerIds != null && !sellerIds.isEmpty()) {
			Map<String, Object> mapping = new HashMap<>();
			mapping.put("adm_id", admin.get("adm_id"));
			mapping.put("seller_ids", sellerIds);
			mapper.registerAdminStores(mapping);
		}
	}
	
	// 관리자 목록 조회
	public List<Map<String, Object>> getAdminList() {
		List<Map<String, Object>> adminList = mapper.getAdminList();
		
		// 각 관리자별 스토어 정보 조회
		for (Map<String, Object> admin : adminList) {
			String admId = (String) admin.get("adm_id");
			List<Map<String, Object>> stores = mapper.getAdminStores(admId);
			admin.put("stores", stores);
		}
		
		return adminList;
	}
	
	// 판매자 검색
	public List<Map<String, Object>> searchSellers(String keyword) {
		return mapper.searchSellers(keyword);
	}
	
	// 관리자 스토어 업데이트
	public void updateAdminStores(Map<String, Object> data) {
		String admId = (String) data.get("adm_id");
		
		// 기존 스토어 매핑 삭제
		mapper.deleteAdminStores(admId);
		
		// 새로운 스토어 매핑 등록
		@SuppressWarnings("unchecked")
		List<String> sellerIds = (List<String>) data.get("seller_ids");
		if (sellerIds != null && !sellerIds.isEmpty()) {
			Map<String, Object> mapping = new HashMap<>();
			mapping.put("adm_id", admId);
			mapping.put("seller_ids", sellerIds);
			mapper.registerAdminStores(mapping);
		}
	}
	
	// 관리자 권한 업데이트
	public void updateAdminRole(Map<String, Object> admin) {
		mapper.updateAdminRole(admin);
	}
		
}
