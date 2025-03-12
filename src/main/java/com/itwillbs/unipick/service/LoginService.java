package com.itwillbs.unipick.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.LoginMapper;

@Service
public class LoginService {

	@Autowired
	LoginMapper mapper;
	
	public Map<String, Object> SellerLogin(Map<String, Object> logindata) {
		return mapper.SellerLogin(logindata);
	}
	
}
