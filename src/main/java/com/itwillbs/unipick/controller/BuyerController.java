package com.itwillbs.unipick.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	    session.invalidate();
		return "redirect:buyerLogin";
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
	
	
	// 상품 상세조회 (조회)
	@GetMapping("productDetail")
	public String productDetail(@RequestParam("prd_cd") String prdCd, Model model) {
		Map<String, Object> prdList = buyService.getPrdDetail(prdCd);
		List<String> prdImg = buyService.getPrdImg(prdCd);
		List<Map<String, Object>> optionList = buyService.getPrdOption(prdCd); 
		
		model.addAttribute("prd", prdList);
		model.addAttribute("prdImg", prdImg);
		model.addAttribute("optionList", optionList);
		
		return "buyer/productDetail";
	}
	
	// 상품 리스트 페이지 이동
	@GetMapping("productList")
	public String productList() {
		return "buyer/buyerProductList";
	}
	
	// 리뷰 페이지 이동
	@GetMapping("myReview")
	public String myReview() {
		return "buyer/buyerReview";
	}
	
	// 주문/배송 페이지 이동
	@GetMapping("myOrderList")
	public String myOrderList() {
		return "buyer/buyerOrderList";
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
	public List<Map<String, Object>> searchProduct(@RequestParam("query") String query) {
		List<Map<String, Object>> selectPrd = buyService.getSearchPrd(query);
		return selectPrd;
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
		session.setAttribute("id", "dol12@naver.com");
		option.put("buy_em", session.getAttribute("id"));
		
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
	public String wishList(@RequestBody Map<String, Object> wish, HttpSession session) {
		
		// 임시 아이디
		session.setAttribute("id", "dol12@naver.com");
		wish.put("buy_em", session.getAttribute("id"));
		
		String msg = "";
		
		System.out.println(wish.get("action"));
		
		if(wish.get("action").equals("insert")) {
			buyService.wishInsert(wish);
			msg = "insert";
		} else {
			buyService.wishDelete(wish);
			msg = "delete";
		}
		
		return msg;
	}
	
	// 마이페이지 데이터
	@ResponseBody
	@GetMapping("myPageData")
	public Map<String, Object> myPageData(HttpSession session, Map<String, Object> myPage) {
	
		// 임시 아이디
		session.setAttribute("id", "dol12@naver.com");
		myPage.put("buy_em", session.getAttribute("id"));
		
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
		
		// 임시 아이디
		session.setAttribute("id", "dol12@naver.com");
		buy.put("buy_em", session.getAttribute("id"));
		
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
	@GetMapping("reviewData")
	public List<Map<String, Object>> reviewData(HttpSession session, Map<String, Object> buyer) {
		// 임시 아이디
		session.setAttribute("id", "dol12@naver.com");
		buyer.put("buy_em", session.getAttribute("id"));
		
		return buyService.reviewInfo(buyer);
	}
	
	// 주문 정보
	@ResponseBody
	@PostMapping("OrderListData")
	public List<Map<String, Object>> OrderListData(HttpSession session, @RequestBody Map<String, Object> buyer) {
		// 임시 아이디
		session.setAttribute("id", "sadsa@naver.com");
		buyer.put("buy_em", session.getAttribute("id"));
		
		return buyService.OrderListInfo(buyer);
	}
	
}
