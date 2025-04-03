package com.itwillbs.unipick.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.mapper.BuyerMapper;
import com.itwillbs.unipick.mapper.SellerMapper;
import com.itwillbs.unipick.mapper.SellerMapper2;

@Service
public class SellerService {
	@Autowired
	SellerMapper mapper;
	@Autowired
	SellerService2 service2;
	@Autowired
	SellerMapper2 mapper2;
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
		productDetail.put("size", mapper2.selectSizeOptions("SIZE"));
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
	
	// 상품 업데이트
	@Transactional
	public void productUpdate(HttpServletRequest req,
			  Map<String, String> formData,  // 텍스트 데이터를 Map으로 받기
			  List<MultipartFile> files,
			  List<String> imageIndexes,
			  List<String> opt_id,
			  List<String> colorNumbers,
			  List<String> colorNames,
			  List<String> sizeOptions,
			  List<Integer> stockNumbers,
			  List<Integer> delOption) {
		// 상품 업데이트
		mapper.productUpdate(formData);
		
		List<Map<String, Object>> InsertList = new ArrayList<>();
		List<Map<String, Object>> UpdateList = new ArrayList<>();
		for (int i = 0; i < colorNumbers.size(); i++) {
            Map<String, Object> option = new HashMap<>();
            option.put("opt_id", opt_id.get(i));
            option.put("clr_cd", colorNumbers.get(i));
            option.put("clr_nm", colorNames.get(i));
            option.put("siz_nm", sizeOptions.get(i));
            option.put("prd_qt", stockNumbers.get(i));
            option.put("prd_cd", formData.get("prd_cd"));
            
            if (opt_id.get(i).equals("undefined")) {
            	InsertList.add(option);
            } else {
            	UpdateList.add(option);
            }
        }
		
        // 상품 옵션 삭제
        if(delOption != null && !delOption.isEmpty()) {
            mapper.productOptionDelete(delOption);
        }
		// 상품 옵션 등록
        if(!InsertList.isEmpty()) {
        	mapper.productOptionInsert(InsertList);
        }
		// 상품 옵션 업데이트
        mapper.productOptionUpdate(UpdateList);
        
        
		// 상품 이미지 업데이트
        if(files != null) {
	        for (int i = 0; i < files.size(); i++) {
	        	MultipartFile imageFile = files.get(i);
	        	String fil_nb = imageIndexes.get(i);
	            if (imageFile == null || imageFile.isEmpty()) {
	                continue;
	            }
	            	
	            // 이미지 업로드
	            Map<String, Object> imageData = service2.uploadImage(req, imageFile);
	            if (imageData.containsKey("error")) {
	                continue;
	            }
	
	            imageData.put("prd_cd", formData.get("prd_cd"));
	            imageData.put("fil_nb", fil_nb);
	
	            try {
	            	mapper.productImageUpdate(imageData);
	            } catch (Exception e) {
	                System.out.println("❌ 이미지 데이터 삽입 실패: " + e.getMessage());
	                e.printStackTrace();
	            }
	        }
        }
       
	}
	
	// 상품 삭제
	public void productDelete(Map<String, Object> prd) {
		mapper.productDelete(prd);
		mapper.productImgDelete(prd);
	}
	
	// 판매자 메인 신규주문
	public int newOrdCount(String sel_id){
		return mapper.newOrdCount(sel_id);
	}
	
	// 판매자 메인 이번달 매출액
	public Map<String, Object> revenue(String sel_id) {
		return mapper.revenue(sel_id);
	}
}
