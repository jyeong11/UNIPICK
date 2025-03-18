package com.itwillbs.unipick.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/*
 	컨트롤러 역할(= 서블릿 클래스)을 수행할 스프링 클래스는 @Controller 어노테이션을 적용하여 정의
 	=> @Controller 어노테이션이 적용된 클래스는 스프링이 관리하는 스프링 컨텍스트(Context) 영역에
 	   스프링 빈(Bean)이라는 형태로 관리됨(별도의 서블릿 관련 설정 불필요하며, 모두 자동으로 설정 이루어짐.
 	=> 해당 클래스 자체에 대한 서블릿 주소(URL)를 매핑하거나
 	   클래스 내의 각각의 메서드를 통해 개별적인 매핑 수행도 가능함
 */


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "index";
	} // home() 메서드 끝
	
	@GetMapping("main")
	public String mainPage() {
	    return "redirect:/";
	}
	
}
