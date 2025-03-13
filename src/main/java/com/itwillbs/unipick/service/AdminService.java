package com.itwillbs.unipick.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.AdminMapper;

@Service
public class AdminService {
	@Autowired
	AdminMapper mapper;
	
	public Map<String, Object> adminInfo(Map<String, Object> admin) {
		return mapper.adminInfo(admin);
	}
	// 상세 코드 조회
	public List<Map<String, Object>> detailCodeList(Map<String, Object> map) {
		return mapper.detailCodeList(map);
	}
	
	// 상세 코드 등록
	public int detailcoderegister(Map<String, Object> map) {
		return mapper.detailcoderegister(map);
	}
	
	// 상세 코드 수정
	public int updateDBcodeDetail(Map<String, Object> map) {
		return mapper.updateDBcodeDetail(map);
	}
	
	// 상세 코드 삭제
	public int updateDBcodeDelete(Map<String, Object> map) {
		return mapper.updateDBcodeDelete(map);
	}
		
}
