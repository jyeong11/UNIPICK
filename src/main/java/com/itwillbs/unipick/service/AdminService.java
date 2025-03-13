package com.itwillbs.unipick.service;

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
}
