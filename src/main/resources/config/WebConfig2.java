import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

@Configuration
public class WebConfig2 implements WebMvcConfigurer {

	public WebConfig2() {
        System.out.println("WebConfig222222222222 initialized");
    }
	
	
    @Autowired
    private ProductViewInterceptor productViewInterceptor;

//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//    	
//        System.out.println("인터셉터 등록됨");
//        registry.addInterceptor(productViewInterceptor)
//                .addPathPatterns("/UNIPICK/productDetail/**") // 특정 경로에만 적용
//                .excludePathPatterns("/static/**", "/api/**"); // 정적 리소스 및 API 제외
//    }
}