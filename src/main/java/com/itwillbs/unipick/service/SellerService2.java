package com.itwillbs.unipick.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.SellerMapper2;

@Service
public class SellerService2 {
	@Autowired
	SellerMapper2 mapper;
	
//	public Map<String, Object> getPrdList(Map<String, Object> prdList) {
//		return mapper.getPrdList(prdList);
//	}
}
