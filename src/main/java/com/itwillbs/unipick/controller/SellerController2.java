package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.unipick.service.SellerService2;

@Controller
public class SellerController2 {

	@Autowired
	SellerService2 sellerservice;
	
	@GetMapping("prdRegister")
	public String prdRegister() {
		return "seller/productRegister";
	}
	
    @PostMapping("productInsert")
    public ResponseEntity<Map<String, Object>> uploadImage(@RequestParam("imageFile") MultipartFile imageFile,
                                                             HttpSession session) {
        Map<String, Object> result = sellerservice.uploadImage(imageFile, session);
        if (result.containsKey("error")) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
        }
        return ResponseEntity.ok(result);
    }
	
}
