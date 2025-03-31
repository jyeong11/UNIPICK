package com.itwillbs.unipick.service;

import java.util.HashMap;
import java.util.List;
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
		productDetail.put("prdImg", mapper.productImage(prdData));
		productDetail.put("prdOpt", mapper.productOption(prdData));
		productDetail.put("cate", buyerMapper.getCategory());
		
		return productDetail;
	}
	
	// 주문 상세 조회
	public List<Map<String, Object>> sellerOrdPrdDetail(Map<String, Object> ord_id) {
		return mapper.sellerOrdPrdDetail(ord_id);
	}
	
	// 계정찾기 
	public Map<String, Object> otpSellerInfo(String userPhone, String sel_id) {
	    return mapper.otpSellerInfo(userPhone, sel_id);
	}
	// 로그인시 셀러 이름 가져옴
	public String getSellerNameById(String sel_id) {
		return mapper.getSellerNameById(sel_id);
	}
}
