package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BuyerMapper {
	// 방문자 수 증가
	public void visitCount();
	//상단 메뉴바
	public List<Map<String, Object>> getAllMenu();
	//상품검색
	public List<Map<String, Object>> getSearchPrd(String query);
	//상품 상세조회
	public Map<String, Object> getPrdDetail(String prdCd);
	//상품 상세이미지
	public List<String> getPrdImg(String prdCd);
	// 상품 옵션조회
	public List<Map<String, Object>> getPrdOption(String prdCd);
	// 카테고리 메뉴
	public List<Map<String, Object>> getCategory();
	// 상품 정렬 종류 
	public List<Map<String, Object>> getProductSortKind();
	// 상품 정렬
	public List<Map<String, Object>> productSort(Map<String, Object> option);
	// 상품컬러
	public List<Map<String, Object>> getColors(Map<String, Object> option);
	// 찜 등록
	public void wishInsert(Map<String, Object> wish);
	// 찜 해제
	public void wishDelete(Map<String, Object> wish);
	// 사용자 정보
	public Map<String, Object> buyerInfo(Map<String, Object> buy);
	// 마이페이지 데이터
	public List<Map<String, Object>> myIcon();
	// 상품 주문 
	public List<Map<String, Object>> getPrdOrder(Map<String, Object> prd_cd);
	// 구매자 정보 수정
	public void buyerModify(Map<String, Object> buyerInfo);
	// 리뷰 정보
	public List<Map<String, Object>> reviewInfo(Map<String, Object> buyer);
	// 리뷰 이미지
	public List<Map<String, Object>> reviewImage(Map<String, Object> buyer);
	// 주문 정보
	public List<Map<String, Object>> OrderListInfo(Map<String, Object> buyer);
	// 회원 탈퇴
	public void Withdraw(Map<String, Object> buyer);
	// 주문 등록
	public void insertOrder(Map<String, Object> orderData);
	// 주문 상세 등록
	public void insertOrderDetail(Map<String, Object> orderData);
	// 주문시 상품 재고 빼기
	public void minusPrdqt(Map<String, Object> orderData);
	// 상품 썸네일, 이미지
	public Map<String, Object> prdInfo(Map<String, Object> prd);
	// 리뷰 등록
	public void registerReview(Map<String, Object> rev);
	// 리뷰 이미지 등록
	public void registerReviewImage(Map<String, Object> paramMap);
	// 옵션 id 들고옴 
	public Map<String, Object> getOptionId(@Param("sizNm") String sizNm,@Param("clrNm") String clrNm,@Param("prdCd") String prdCd);
	// 최근 본 상품 등록
	public void registerRecentlyPrd(Map<String, Object> prd);
}
