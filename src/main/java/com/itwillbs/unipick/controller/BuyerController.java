package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.service.AdminService;
import com.itwillbs.unipick.service.BuyerService;

@Controller
public class BuyerController {
	@Autowired
	AdminService admService;
	
	@Autowired
	BuyerService buyService;
	
	// 카테고리 페이지 이동
	@GetMapping("category")
	public String category() {
		return "buyer/buyerCategory";
	}
	
	// 신상품 페이지 이동
	@GetMapping("new")
	public String buyerNew() {
		return "buyer/buyerNew";
	}
	
	// 베스트 페이지 이동
	@GetMapping("best")
	public String buyerBest() {
		return "buyer/buyerBest";
	}
	
	// 장바구니 페이지 이동
	@GetMapping("cart")
	public String buyerCart() {
		return "buyer/buyerCart";
	}
	
	//상품검색
	@GetMapping("productSearch")
	public String productSearch() {
		return "buyer/productSearch";
	}
	
	// 마이페이지
	@GetMapping("myPage")
	public String myPage() {
		return "buyer/buyerMyPage";
	}
	// 주문페이지
	@GetMapping("productOrder")
	public String productOrder() {
		return "buyer/productOrder";
	}
	
	// 회원수정페이지 이동
	@GetMapping("modify")
	public String modify() {
		return "buyer/buyerModify";
	}
	
	// 로그아웃 이동
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("buyEm");
		return "redirect:buyerlogin";
	}
	
	//주문시 페이 결제창 
	@GetMapping("payment")
	public String payment() {
		return "buyer/payment";
	}
	
	// 주문 상세 페이지 이동
	@GetMapping("orderDetail")
	public String orderDetail() {
		return "buyer/buyerOrderDetail";
	}
	
	// 회원 탈퇴 페이지 이동
	@GetMapping("withdraw")
	public String withdraw() {
		return "buyer/buyerWithdraw";
	}
	
	// 메인 스토어 페이지 이동
	@GetMapping("store")
	public String store() {
		return "buyer/buyerSellerStore";
	}
	
	// 판매자 상세 페이지 이동
	@GetMapping("sellerShopDetail")
	public String sellerShopDetail(HttpSession session, @RequestParam("sel_nm") String sel_nm, Model model) {
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		data.put("sel_nm", sel_nm);
		data.put("buy_em", session.getAttribute("buyEm"));
		
		List<Map<String, Object>> selList = buyService.getselDetail(data);
		List<Map<String, Object>> cateList = buyService.categoryList();
		
		model.addAttribute("cateList", cateList);
		model.addAttribute("selList", selList);
		return "buyer/sellerShopDetail";
	}
	// 상품 상세조회 (조회)
	@GetMapping("productDetail")
	public String productDetail(HttpSession session,
								@RequestParam("prd_cd") String prdCd,
								@RequestParam("sel_nm") String selNm,
								Model model) {
		Map<String, Object> prdData = new HashMap<String, Object>();
		prdData.put("prdCd", prdCd);
		prdData.put("buyEm", session.getAttribute("buyEm"));
		Map<String, Object> prdList = buyService.getPrdDetail(prdData);
		List<Map<String, Object>> prdImg = buyService.getPrdImg(prdCd);
		List<Map<String, Object>> selImg = buyService.getselanother(selNm);
		List<Map<String, Object>> optionList = buyService.getPrdOption(prdCd); 
		
		System.out.println("prdList : " + prdList);
		
		model.addAttribute("prd", prdList);
		model.addAttribute("prdImg", prdImg);
		model.addAttribute("selImg", selImg);
		model.addAttribute("optionList", optionList);
		
		return "buyer/productDetail";
	}
	
	// 상품 리스트 페이지 이동
	@GetMapping("productList")
	public String productList() {
		return "buyer/buyerProductList";
	}
	
	// 리뷰 페이지 이동
	@GetMapping("myReviewList")
	public String myReviewList() {
		return "buyer/buyerReviewList";
	}
	
	// 주문/배송 페이지 이동
	@GetMapping("myOrderList")
	public String myOrderList() {
		return "buyer/buyerOrderList";
	}
	
	// 리뷰 작성 페이지 이동
	@GetMapping("myReview")
	public String myReview() {
		return "buyer/buyerReview";
	}
	
	// 최근 본 상품 페이지 이동
	@GetMapping("myRecentlyProduct")
	public String myRecentlyProduct() {
		return "buyer/buyerRecentlyProduct";
	}
	
	// 리뷰 목록 이동
	@GetMapping("myWishList")
	public String myWishList() {
		return "buyer/buyerWishList";
	}
	
	// 상단 메뉴바 공통코드
	@ResponseBody
	@GetMapping("menu")
	public List<Map<String, Object>> getAllMenu() {
		List<Map<String, Object>> menu = buyService.getAllMenu();
		return menu;
	}
	
	// 카테고리
	@ResponseBody
	@GetMapping("firstCategory")
	public List<Map<String, Object>> firstCategory() {
		return buyService.getCategory();
	}
	
	// 상품검색
	@ResponseBody
	@GetMapping("searchProduct")
	public List<Map<String, Object>> searchProduct(HttpSession session, @RequestParam("query") String query) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("buy_em", session.getAttribute("buyEm"));
		data.put("query", query);
		return buyService.getSearchPrd(data);
	}

	// 상품 리스트(카테고리, 정렬종류)
	@ResponseBody
	@GetMapping("productListData")
	public Map<String, Object> productListData() {
		return buyService.productListData();
	}
	
	// 상품정렬
	@ResponseBody
	@PostMapping("productSort")
	public List<Map<String, Object>> productSort(@RequestBody Map<String,Object> option, HttpSession session) {
		option.put("buy_em", session.getAttribute("buyEm"));
		
		return buyService.productSort(option);
	}
	
	// 상품옵션
	@ResponseBody
	@PostMapping("getSizeByColor")
	public List<Map<String, Object>> getSizeByColor(@RequestBody Map<String, Object> option){
		return buyService.getColors(option); 
	}
	
	// 찜
	@ResponseBody
	@PostMapping("wishList")
	public void wishList(@RequestBody Map<String, Object> wish, HttpSession session) {
		
		wish.put("buy_em", session.getAttribute("buyEm"));
		
		if(wish.get("action").equals("insert")) {
			buyService.wishInsert(wish);
		} else if(wish.get("action").equals("delete")) {
			buyService.wishDelete(wish);
		}
		
	}
	
	// 마이페이지 데이터
	@ResponseBody
	@GetMapping("myPageData")
	public Map<String, Object> myPageData(HttpSession session, Map<String, Object> myPage) {
		// 먼저 "buyEm" 속성 확인
		Object buyEmObj = session.getAttribute("buyEm");
		
		// "buyEm"이 없으면 "buy_em" 속성 확인
		if (buyEmObj == null) {
			buyEmObj = session.getAttribute("buy_em");
		}
		
		// 디버그 로그
		System.out.println("마이페이지 세션 데이터: buyEm=" + buyEmObj);
		
		// 값이 있는 경우에만 세션 값 저장
		if (buyEmObj != null) {
			// String으로 변환하여 저장
			myPage.put("buy_em", buyEmObj.toString());
		} else {
			// 값이 없으면 빈 문자열 저장 (NPE 방지)
			myPage.put("buy_em", "");
			System.out.println("경고: 마이페이지 접근 시 로그인 세션 정보가 없습니다.");
		}
		
		return buyService.myPageData(myPage);
	}
	
	// 상품 주문
	@ResponseBody
	@PostMapping("productOrder")
	public List<Map<String, Object>> productOrder(@RequestBody Map<String, Object> prd_cd) {
		prd_cd.put("buy_em", "sadsa@naver.com");
		List<Map<String, Object>> prdList = buyService.getPrdOrder(prd_cd);
		return prdList;
	}
	
	// 구매자 정보
	@ResponseBody
	@GetMapping("buyerInfo")
	public Map<String, Object> buyerInfo(HttpSession session, Map<String, Object> buy) {
		
		buy.put("buy_em", session.getAttribute("buyEm"));
		
		return buyService.buyerInfo(buy);
	}
	
	// 구매자 정보 수정
	@ResponseBody
	@PostMapping("buyermodify")
	public void buyermodify(@RequestBody Map<String, Object> buyerInfo) {
		buyService.buyerModify(buyerInfo);
	}
	
	// 리뷰 정보
	@ResponseBody
	@PostMapping("reviewData")
	public Map<String, Object> reviewData(HttpSession session, @RequestBody Map<String, Object> buyer) {
		buyer.put("buy_em", session.getAttribute("buyEm"));
		
		return buyService.reviewInfo(buyer);
	}
	
	// 주문 정보
	@ResponseBody
	@PostMapping("OrderListData")
	public List<Map<String, Object>> OrderListData(HttpSession session, @RequestBody Map<String, Object> buyer) {
		buyer.put("buy_em", session.getAttribute("buyEm"));
		
		return buyService.OrderListInfo(buyer);
	}
	
	// 회원 탈퇴
	@ResponseBody
	@GetMapping("buyerWithdraw")
	public void buyerWithdraw(HttpSession session, Map<String, Object> buyer) {
		buyer.put("buy_em", session.getAttribute("buyEm"));
		
		buyService.Withdraw(buyer);
		session.removeAttribute("buyEm");
	}
	
	// 주문 상세 정보
	@ResponseBody
	@PostMapping("myOrderDetail")
	public List<Map<String, Object>> myOrderDetail(HttpSession session, @RequestBody Map<String, Object> buyer) {
		buyer.put("buy_em", session.getAttribute("buyEm"));
		
		return buyService.OrderListInfo(buyer);
	}
	
	// 상품 썸네일, 이름
	@ResponseBody
	@PostMapping("prdInfo")
	public Map<String, Object> prdInfo(@RequestBody Map<String, Object> prd) {
		return buyService.prdInfo(prd);
	}
	
	// 리뷰 등록
	@ResponseBody
	@PostMapping("registerReview")
	public boolean registerReview(
			HttpServletRequest req,
			HttpSession session,
	        @RequestParam("opt_id") String optId,
	        @RequestParam("rev_rt") String revRt,
	        @RequestParam("rev_ct") String revCt,
	        @RequestPart(value = "imageFiles", required = false) List<MultipartFile> imageFiles) {

	    try {
	        
	    	Map<String, Object> map = new HashMap<String, Object>();
	    	map.put("buy_em", session.getAttribute("buyEm"));
	    	map.put("opt_id", optId);
	    	map.put("rev_rt", revRt);
	    	map.put("rev_ct", revCt);
	    	
	    	if (imageFiles == null) {
                imageFiles = List.of();
            }
	    	
	        buyService.registerReview(req, map, imageFiles);

	        return true;

	    } catch (Exception e) {
	        return false;
	    }
	}
	
	// 최근 본 상품 리스트
	@ResponseBody
	@PostMapping("myRecentlyPrd")
	public List<Map<String, Object>> myRecentlyPrd(HttpSession session, Map<String, Object> buy) {
		buy.put("buy_em", session.getAttribute("buyEm"));
		return buyService.myRecentlyPrd(buy);
	}
	
	// 판매자 상세 페이지 카테고리 
	@ResponseBody
	@PostMapping("selPrdsearch")
	public List<Map<String, Object>> selPrdsearch(HttpSession session, @RequestBody Map<String, Object> data) {
		data.put("buy_em", session.getAttribute("buyEm"));
		return buyService.selPrdsearch(data);
	}
	
	//리뷰 조회
	@ResponseBody
	@PostMapping("getReviews")
	public List<Map<String, Object>> getReviews(@RequestBody Map<String, Object> prd_cd) {
		return buyService.getPrdReviews(prd_cd);
	}
	
	// 추천상품
	@ResponseBody
	@PostMapping("getRecommendPrd")
	public List<Map<String, Object>> getRecommendPrd(HttpSession session, @RequestBody Map<String, Object> prd_cd) {
		prd_cd.put("buy_em", session.getAttribute("buyEm"));
		return buyService.getRecommendPrd(prd_cd);
	}
	
	// 판매자 상세 카테고리 클릭시
	@ResponseBody
	@PostMapping("getCatePrd")
	public List<Map<String, Object>> getCatePrd(HttpSession session, @RequestBody Map<String, Object> cate) {
		cate.put("buy_em", session.getAttribute("buyEm"));
		return buyService.getCatePrd(cate);
	}
	
	// 신상, 베스트 상품 리스트
	@ResponseBody
	@PostMapping("productBestNew")
	public Map<String, Object> productBestNew(HttpSession session, @RequestBody Map<String, Object> prd) {
		prd.put("buy_em", session.getAttribute("buyEm"));
		return buyService.productBestNew(prd);
	}
	
	// 장바구니
	@ResponseBody
	@PostMapping("cartInsert")
	public void cartinsert(@RequestBody Map<String, Object> data,
										  HttpSession session) {
		data.put("buy_em", session.getAttribute("buyEm"));
		buyService.cartInsert(data);
	}
	
	// 장바구니 조회
	@ResponseBody
	@PostMapping("cartSelect")
	public List<Map<String, Object>> cartSelect(HttpSession session) {
		String buy_em = (String)session.getAttribute("buyEm");
		List<Map<String, Object>> cartList =  buyService.cartSelect(buy_em);
		return cartList;
	}
	
	// 찜 목록
	@ResponseBody
	@PostMapping("myWishPrd")
	public List<Map<String, Object>> myWishPrd(HttpSession session, Map<String, Object> buyer) {
		buyer.put("buy_em", session.getAttribute("buyEm"));
		return buyService.myWishPrd(buyer);
	}
	
	// 장바구니 삭제 
	@ResponseBody
	@PostMapping("deleteCart")
	public void deleteCart(@RequestBody List<Map<String, Object>> deleteData,
						 	HttpSession session) {
		String buy_em = (String)session.getAttribute("buyEm");
		buyService.deleteCart(deleteData, buy_em);
	}
	
	// 장바구니 수정
	@ResponseBody
	@PostMapping("updateCart")
	public void updateCart(@RequestBody Map<String, Object> updataData,
							HttpSession session) {
		String buy_em = (String)session.getAttribute("buyEm");
		buyService.updateCart(updataData, buy_em);
	}
	
	// 메인 추천 상품
	@ResponseBody
	@PostMapping("recomProduct")
	public List<Map<String, Object>> recomProduct(@RequestBody Map<String, Object> data) {
		return buyService.recomProduct(data);
	}
	
	// 메인 스토어 페이지
	@ResponseBody
	@PostMapping("buyerSellerStore")
	public List<Map<String, Object>> sellerStore(){
		return buyService.sellerStore();
	}
	
	// 메인 상단 장바구니 갯수
	@ResponseBody
	@PostMapping("cartCnt")
	public int cartCnt(HttpSession session) {
		String buy_em = (String)session.getAttribute("buyEm");
		return buyService.cartCnt(buy_em);
	}
}
