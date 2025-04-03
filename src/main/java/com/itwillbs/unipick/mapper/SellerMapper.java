package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SellerMapper {
	// 셀러 회원가입
	public int sellerjoin(Map<String, Object> sellerinfo);
	// 셀러 정보 조회
	public Map<String, Object> sellerselect(Map<String, Object> seldata);
	// 상품 상세 조회
	public Map<String, Object> productDetail(Map<String, Object> prdData);
	// 상품 상세 옵션
	public List<Map<String, Object>> productOption(Map<String, Object> prdData);
	// 상품 이미지
	public List<Map<String, Object>> productImage(Map<String, Object> prdData);
	// 주문 상세 조회
	public List<Map<String, Object>> sellerOrdPrdDetail(Map<String, Object> ord_id);
	// 계정 찾기
	public Map<String, Object> otpSellerInfo(@Param("userPhone") String userPhone, @Param("sel_id") String sel_id);
	// 로그인시 셀러 이름 들고옴
	public String getSellerNameById(String sel_id);
	// 상품 업데이트
	public void productUpdate(Map<String, String> formData);
	// 상품 옵션 삭제
	public void productOptionDelete(List<Integer> delOption);
	// 상품 옵션 등록
	public void productOptionInsert(List<Map<String, Object>> InsertList);
	// 상품 옵션 업데이트
	public void productOptionUpdate(List<Map<String, Object>> UpdateList);
	// 상품 이미지 업데이트
	public void productImageUpdate(Map<String, Object> image);
	// 상품 삭제
	public void productDelete(Map<String, Object> prd);
	// 상품 이미지 삭제
	public void productImgDelete(Map<String, Object> prd);
	// 판매자 메인 신규주문
	public int newOrdCount(String sel_id);
	// 판매자 메인 이번달 매출액
	public Map<String, Object> revenue(String sel_id);
}