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
	public List<Map<String, Object>> getSearchPrd(Map<String, Object> data);
	//상품 상세 조회
	public Map<String, Object> getPrdDetail(Map<String, Object> prdData);
	// 상품 상세 판매자 다른 상품
	public List<Map<String, Object>> getselanother(String selNm);
	//상품 상세이미지
	public List<Map<String, Object>> getPrdImg(String prdCd);
	// 상품 옵션 조회
	public List<Map<String, Object>> getPrdOption(String prdCd);
	// 상품 리뷰 조회
	public List<Map<String, Object>> getPrdReviews(Map<String, Object> prd_cd);
	// 판매자 상세페이지
	public List<Map<String, Object>> getselDetail(Map<String, Object> data);
	// 판매자 상세 카테고리
	public List<Map<String, Object>> categoryList();
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
	// 최근 본 상품 리스트
	public List<Map<String, Object>> myRecentlyPrd(Map<String, Object> buy);
	// 판매자 페이지 내에 검색
	public List<Map<String, Object>> selPrdsearch(Map<String, Object> data);
	// 추천 상품
	public List<Map<String, Object>> getRecommendPrd(Map<String, Object> prd_cd);
	// 판매자 상세 카테고리 클릭시 
	public List<Map<String, Object>> getCatePrd(Map<String, Object> cate);
	// 장바구니 
	public int updateCartQty(Map<String, Object> data);
	public void cartInsert(Map<String, Object> data);
	// 장바구니 조회
	public List<Map<String, Object>> cartSelect(String buy_em);
	// 찜 목록
	public List<Map<String, Object>> myWishPrd(Map<String, Object> buyer);
	// 장바구니 삭제
	void deleteCart(@Param("crt_id") int crt_id, @Param("buy_em") String buy_em);
	// 장바구니 수정
	public void updateCart(@Param("updataData") Map<String, Object> updataData, @Param("buy_em") String buy_em);
	// 상품 코드로 판매자 ID 조회
	public String getSellerIdByProductId(String prd_cd);
	// 메인 추천 상품
	public List<Map<String, Object>> recomProduct(Map<String, Object> data);
	// 메인 스토어 페이지
	public List<Map<String, Object>>sellerStore();
	// 메인 상단 장바구니 갯수
	public int cartCnt(String buy_em);
}
