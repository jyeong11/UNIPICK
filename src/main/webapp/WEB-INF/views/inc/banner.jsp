<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
<!-- Swiper -->
<div class="swiper-container">
  <div class="swiper-wrapper">
    <div class="swiper-slide"><img src="${pageContext.request.contextPath }/resources/images/banner1.jpg" alt="Banner 1" style="width: 100%; height: 100%; object-fit: cover;"></div>
    <div class="swiper-slide"><img src="${pageContext.request.contextPath }/resources/images/banner2.jpg" alt="Banner 2"></div>
    <div class="swiper-slide"><img src="${pageContext.request.contextPath }/resources/images/banner3.jpg" alt="Banner 3"></div>
  </div>
  <!-- 네비게이션 버튼 (필요 시) -->
  <div class="swiper-button-prev"></div>
  <div class="swiper-button-next"></div>
  <!-- 페이지네이션 (필요 시) -->
  <div class="swiper-pagination"></div>
</div>


<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
  var swiper = new Swiper('.swiper-container', {
	slidesPerView: 1,
    loop: true,
    autoplay: {
      delay: 5000,  // 5초마다 슬라이드 전환
      disableOnInteraction: false,
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
  });
</script>
</body>