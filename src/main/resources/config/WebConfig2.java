@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private ProductViewInterceptor productViewInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(productViewInterceptor)
                .addPathPatterns("/product/detail") // 특정 경로에만 적용
                .excludePathPatterns("/static/**", "/api/**"); // 정적 리소스 및 API 제외
    }
}