package com.itwillbs.unipick.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.mapper.BuyerMapper;

@Service
public class BuyerService {
	
	@Autowired
	BuyerMapper mapper;
	@Autowired
	SellerService2 sellerservice2;
	
	// 방문자 수 증가
	public void visitCount() {
        mapper.visitCount();
    }
	//상단메뉴바
	public List<Map<String, Object>> getAllMenu(){
		return mapper.getAllMenu();
	}
	//상품검색
	public List<Map<String, Object>> getSearchPrd(Map<String, Object> data) {
		return mapper.getSearchPrd(data);
	}
	//상품 상세 조회
	public Map<String, Object> getPrdDetail(Map<String, Object> prdData) {
		return mapper.getPrdDetail(prdData);
	}
	// 상품 상세 이미지
	public List<Map<String, Object>> getPrdImg(String prdCd) {
		return mapper.getPrdImg(prdCd);
	}
	// 판매자 상세 페이지
	public List<Map<String, Object>> getselDetail(Map<String, Object> data) {
		return mapper.getselDetail(data);
	}
	// 판매자 카테고리 
	public List<Map<String, Object>> categoryList() {
		return mapper.categoryList();
	}
	//상품 상세 옵션 
	public List<Map<String, Object>> getPrdOption(String prdCd) {
		return mapper.getPrdOption(prdCd);
	}
	// 상품 리뷰 조회 
	public List<Map<String, Object>> getPrdReviews(Map<String, Object> prd_cd) {
		return mapper.getPrdReviews(prd_cd);
	}
	// 상품 상세 판매자 다른 상품
	public List<Map<String, Object>> getselanother(String selNm) {
		return mapper.getselanother(selNm);
	}
	// 카테고리 메뉴
	public List<Map<String, Object>> getCategory() {
		return mapper.getCategory();
	}
	// 상품정렬종류
	public Map<String, Object> productListData() {
		Map<String, Object> productListData = new HashMap<String, Object>();
		productListData.put("cate", mapper.getCategory());
		productListData.put("kind", mapper.getProductSortKind());
		return productListData;
	}
	// 상품정렬
	public List<Map<String, Object>> productSort(Map<String, Object> option) {
		return mapper.productSort(option);
	}
	//상품 컬러
	public List<Map<String, Object>> getColors(Map<String, Object> option) {
		return mapper.getColors(option);
	}
	// 찜 등록
	public void wishInsert(Map<String, Object> wish) {
		mapper.wishInsert(wish);
	}
	// 찜 해제
	public void wishDelete(Map<String, Object> wish) {
		mapper.wishDelete(wish);
	}
	// 마이페이지 데이터
	public Map<String, Object> myPageData(Map<String,Object> myPage) {
		Map<String, Object> myPageDatas = new HashMap<String, Object>();
		myPageDatas.put("buyer", mapper.buyerInfo(myPage));
		myPageDatas.put("myIcon", mapper.myIcon());
		return myPageDatas;
	}
	// 상품 주문
	public List<Map<String, Object>> getPrdOrder(Map<String, Object> prd_cd) {
		return mapper.getPrdOrder(prd_cd);
	}
	// 구매자 데이터
	public Map<String, Object> buyerInfo(Map<String, Object> buy) {
		return mapper.buyerInfo(buy);
	}
	// 구매자 정보수정
	public void buyerModify(Map<String, Object> buyerInfo) {
		mapper.buyerModify(buyerInfo);
	}
	// 리뷰 정보
	public Map<String,Object> reviewInfo(Map<String, Object> buyer) {
		Map<String, Object> reviewData = new HashMap<String, Object>();
		reviewData.put("data", mapper.reviewInfo(buyer));
		reviewData.put("image", mapper.reviewImage(buyer));
		return reviewData;
	}
	// 주문 정보
	public List<Map<String,Object>> OrderListInfo(Map<String, Object> buyer) {
		return mapper.OrderListInfo(buyer);
	}
	// 회원 탈퇴
	public void Withdraw(Map<String, Object> buyer) {
		mapper.Withdraw(buyer);
	}
	// 주문 등록
	public void insertOrder (Map<String, Object> orderData) {
		mapper.insertOrder(orderData);
	}
	@Transactional
	public void insertOrderDetail(Map<String, Object> detailData) {
	    mapper.insertOrderDetail(detailData);
	    mapper.minusPrdqt(detailData);
	}
	// 옵션 id 들고옴
	public Map<String, Object> getOptionId(String sizNm, String clrNm, String prdCd){
		return mapper.getOptionId(sizNm, clrNm, prdCd);
	}
	// 상품 썸네일, 이름
	public Map<String, Object> prdInfo(Map<String, Object> prd) {
		return mapper.prdInfo(prd);
	}
	// 리뷰 등록
	@Transactional
	public void registerReview(HttpServletRequest req, Map<String, Object> rev, List<MultipartFile> imageFiles) {
		// 1. 리뷰 저장
		mapper.registerReview(rev);
		
		// 2. 리뷰 이미지 저장
        for (MultipartFile imageFile : imageFiles) {
            if (imageFile == null || imageFile.isEmpty()) {
                continue;
            }

            // 이미지 업로드
            Map<String, Object> imageData = sellerservice2.uploadImage(req, imageFile);
            if (imageData.containsKey("error")) {
                continue;
            }
            
            imageData.put("rev_id", rev.get("rev_id"));

            try {
            	mapper.registerReviewImage(imageData);
            } catch (Exception e) {
                System.out.println("❌ 이미지 데이터 삽입 실패: " + e.getMessage());
                e.printStackTrace();
            }
        }
	}
	
	// 최근 본 상품 등록
	public void registerRecentlyPrd(HttpServletRequest req, Map<String, Object> prd) {
		HttpSession session = req.getSession(false);

		if (session != null) {
		    Object buyEm = session.getAttribute("buyEm");
		    if (buyEm != null) {
		        // buyEm 값이 존재할 때만 처리
		        prd.put("buy_em", buyEm.toString());
		        mapper.registerRecentlyPrd(prd);
		    }
		}
	}
	
	// 최근 본 상품 리스트
	public List<Map<String, Object>> myRecentlyPrd(Map<String, Object> buy) {
		return mapper.myRecentlyPrd(buy);
	}
	
	// 판매자 페이지 내에 검색
	public List<Map<String, Object>> selPrdsearch(Map<String, Object> data) {
		return mapper.selPrdsearch(data);
	}
	
	// 추천 상품
	public List<Map<String, Object>> getRecommendPrd(Map<String, Object> prd_cd) {
		return mapper.getRecommendPrd(prd_cd);
	}
	
	// 판매자 상세 카테고리 클릭시
	public List<Map<String, Object>> getCatePrd(Map<String, Object> cate) {
		return mapper.getCatePrd(cate);
	}
	
	// 베스트 상품 리스트
	public Map<String, Object> productBestNew(Map<String, Object> prd) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prd", mapper.productSort(prd));
		map.put("cate", mapper.getCategory());
		return map;
	}
	
	// 장바구니
	public void cartInsert(Map<String, Object> data) {
		int updated = mapper.updateCartQty(data); // 수량 업데이트 먼저 시도

	    if (updated == 0) {
	        mapper.cartInsert(data);
	    }
	}
	
	// 장바구니 조회
	public List<Map<String, Object>> cartSelect(String buy_em) {
		return mapper.cartSelect(buy_em);
	}
	
	// 찜 목록
	public List<Map<String, Object>> myWishPrd(Map<String, Object> buyer) {
		return mapper.myWishPrd(buyer);
	}
	
	// 장바구니 삭제
	public void deleteCart(List<Map<String, Object>> deleteData, String buy_em) {
		
	    for (Map<String, Object> item : deleteData) {
	        Integer crt_id = Integer.parseInt(item.get("crt_id").toString());
	        mapper.deleteCart(crt_id, buy_em);
	    }
	}
	
	// 장바구니 수정
	public void updateCart(Map<String, Object> updataData, String buy_em) {
		mapper.updateCart(updataData, buy_em);
	}
	
	// 상품 코드로 판매자 ID 조회
	public String getSellerIdByProductId(String prd_cd) {
		return mapper.getSellerIdByProductId(prd_cd);
	}
	
	// 메인 추천 상품
	public List<Map<String, Object>> recomProduct(Map<String, Object> data) {
		return mapper.recomProduct(data);
	}
	
	// 메인 스토어 페이지
	public List<Map<String, Object>>sellerStore(){
		return mapper.sellerStore();
	}
	
	// 메인 상단 장바구니 갯수
	public int cartCnt(String buy_em) {
		return mapper.cartCnt(buy_em);
	}
}
