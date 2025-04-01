import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private ProductViewInterceptor productViewInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(productViewInterceptor)
                .addPathPatterns("/UNIPICK/productDetail") // 특정 경로에만 적용
                .excludePathPatterns("/static/**", "/api/**"); // 정적 리소스 및 API 제외
    }
}