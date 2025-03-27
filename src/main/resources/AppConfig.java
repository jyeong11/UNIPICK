import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration 
public class AppConfig {

	@Bean
	public RestTemplate restTemplate() {
//	    RestTemplate restTemplate = new RestTemplate();
//	    
//	    // 기존 메시지 컨버터들에 FormHttpMessageConverter 추가
//	    List<HttpMessageConverter<?>> converters = restTemplate.getMessageConverters();
//	    converters.add(new FormHttpMessageConverter());  // x-www-form-urlencoded를 처리할 수 있는 컨버터 추가
//	    converters.add(new MappingJackson2HttpMessageConverter());  // JSON 처리용 컨버터 추가
//	    
//	    restTemplate.setMessageConverters(converters);
//	    return restTemplate;
		RestTemplate restTemplate = new RestTemplate();
	    restTemplate.getMessageConverters().add(new FormHttpMessageConverter());
	    return restTemplate;
	}
}