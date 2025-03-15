package com.itwillbs.unipick.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.SellerMapper;

@Service
public class SellerService {
	@Autowired
	SellerMapper mapper;
	
	public int sellerjoin(Map<String, Object> sellerinfo) {
		return mapper.sellerjoin(sellerinfo);
	}
	
	public Map<String, Object> sellerselect(Map<String, Object> seldata) {
		return mapper.sellerselect(seldata);
	}
}
