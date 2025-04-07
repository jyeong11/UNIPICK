package com.itwillbs.unipick.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.itwillbs.unipick.handler.ProductViewInterceptor;
import com.itwillbs.unipick.handler.SellerInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	// 파일을 업로드한 후, http://localhost:8080/businessLicense/파일명 경로로 접근가능
	//<img src="/uploads/businessLicense/파일이름.png"> 접근가능
	
	
	public WebConfig() {
        System.out.println("WebConfig initialized");
    }
	
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/businessLicense/**")  // URL 패턴
                .addResourceLocations("file:///D:/UNIPICK/src/main/webapp/resources/businessLicense/");  // 실제 저장 경로
        
    
        registry.addResourceHandler("/productImg/**")
        		.addResourceLocations("file:///D:/UNIPICK/src/main/webapp/resources/productImg/")
        		.setCachePeriod(0);
        
        registry.addResourceHandler("/resources/upload/**")
        		.addResourceLocations("file:///D:/UNIPICK/src/main/webapp/resources/upload/")
        		.setCachePeriod(0);
        
        
    }
	
	@Autowired
	private ProductViewInterceptor productViewInterceptor;

	
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		System.out.println("인터셉터 등록됨");
		registry.addInterceptor(productViewInterceptor)
				.addPathPatterns("/productDetail")
				.excludePathPatterns("/static/**", "/api/**");
		
	}
	
	
}

