package com.itwillbs.unipick.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.unipick.service.SellerService2;

@Controller
public class SellerVisitController {
    
    @Autowired
    private SellerService2 service;

    // 기존 URL 매핑 유지
    @GetMapping("/sellerVisit")
    public String visit() {
        return "seller/sellerVisitorStats";
    }

    // 기간별 방문자 통계 API
    @GetMapping("/sellerVisit/stats/{sellerId}")
    @ResponseBody
    public Map<String, Object> getVisitStats(
        @PathVariable String sellerId,
        @RequestParam String periodType,
        @RequestParam(required = false) String startDate,
        @RequestParam(required = false) String endDate) {
        
        Map<String, Object> params = new HashMap<>();
        params.put("sellerId", sellerId);
        params.put("periodType", periodType);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        
        Map<String, Object> result = new HashMap<>();
        result.put("dailyVisits", service.getVisitsByPeriod(params));
        result.put("popularProducts", service.getPopularProductsByPeriod(params));
        
        return result;
    }

    // 날짜별 방문자 수 API
    @GetMapping("/sellerVisit/daily/{sellerId}")
    @ResponseBody
    public List<Map<String, Object>> getDailyVisits(@PathVariable String sellerId) {
        return service.getDailyVisits(sellerId);
    }

    // 인기 상품 조회수 API
    @GetMapping("/sellerVisit/popular/{sellerId}")
    @ResponseBody
    public List<Map<String, Object>> getPopularProducts(@PathVariable String sellerId) {
        return service.getPopularProducts(sellerId);
    }
}
