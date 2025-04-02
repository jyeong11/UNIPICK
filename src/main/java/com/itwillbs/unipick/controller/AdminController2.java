package com.itwillbs.unipick.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.itwillbs.unipick.service.AdminService;
import com.itwillbs.unipick.service.AdminService2;

@Controller
public class AdminController2 {
	
	@Autowired
	AdminService2 adminservice;
	
	@GetMapping("adminRegister")
	public String adminRegister() {
		return "admin/adminRegister";
	}
	
	@GetMapping("adminList")
	public String adminList() {
		return "admin/adminList";
	}

}
