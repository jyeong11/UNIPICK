package com.itwillbs.unipick.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.BuyerMapper;
import com.itwillbs.unipick.mapper.SellerMapper;

@Service
public class SellerService {
	@Autowired
	SellerMapper mapper;
	@Autowired
	BuyerMapper buyerMapper;
	
	public int sellerjoin(Map<String, Object> sellerinfo) {
		return mapper.sellerjoin(sellerinfo);
	}
	
	public Map<String, Object> sellerselect(Map<String, Object> seldata) {
		return mapper.sellerselect(seldata);
	}
	
	// 상품 상세 조회
	public Map<String, Object> productDetail(Map<String, Object> prdData){
		
		Map<String, Object> productDetail = new HashMap<String, Object>();
		
		productDetail.put("prdData", mapper.productDetail(prdData));
		productDetail.put("cate", buyerMapper.getCategory());
		
		return productDetail;
	}
}
