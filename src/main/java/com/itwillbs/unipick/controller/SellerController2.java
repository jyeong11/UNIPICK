package com.itwillbs.unipick.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SellerController2 {

    @GetMapping("prdRegister")
    public String prdRegister() {
        return "seller/productRegister";
    }
    
    @GetMapping("productList")
    public String prdList() {
        return "seller/productList";
    }
}