package com.itwillbs.unipick.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
	public List<Map<String, Object>> getSearchPrd(String query) {
		return mapper.getSearchPrd(query);
	}
	//상품 상세 조회
	public Map<String, Object> getPrdDetail(String prdCd) {
		return mapper.getPrdDetail(prdCd);
	}
	// 상품 상세 이미지
	public List<String> getPrdImg(String prdCd) {
		return mapper.getPrdImg(prdCd);
	}
	//상품 상세 옵션 
	public List<Map<String, Object>> getPrdOption(String prdCd) {
		return mapper.getPrdOption(prdCd);
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
	@Transactional
	public void insertOrder (Map<String, Object> orderData) {
		mapper.insertOrder(orderData);
		mapper.insertOrderDetail(orderData);
		mapper.minusPrdqt(orderData);
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
	
}
