package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SellerMapper {
	// 셀러 회원가입
	public int sellerjoin(Map<String, Object> sellerinfo);
	
	public Map<String, Object> sellerselect(Map<String, Object> seldata);
	// 상품 상세 조회
	public Map<String, Object> productDetail(Map<String, Object> prdData);
	// 주문 상세 조회
	public List<Map<String, Object>> sellerOrdPrdDetail(Map<String, Object> ord_id);
	// 계정 찾기
	public Map<String, Object> otpSellerInfo(@Param("userPhone") String userPhone, @Param("sel_id") String sel_id);
	// 로그인시 셀러 이름 들고옴
	public String getSellerNameById(String sel_id);
	
}
