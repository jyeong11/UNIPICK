package com.itwillbs.unipick.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BuyerController {
	@GetMapping("new")
	public String memberNew() {
		return "buyer/buyerNew";
	}
}
