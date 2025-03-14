package com.itwillbs.unipick.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.SellerMapper;

@Service
public class SellerService {
	@Autowired
	SellerMapper mapper;
	
	public Map<String, Object> sellerjoin(Map<String, Object> sellerinfo) {
		return mapper.sellerjoin(sellerinfo);
	}
}
