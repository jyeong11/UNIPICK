$(function() {
	
	$(document).on("click", ".prd-img .heart", function(event) {
		event.preventDefault();
		wish($(this));
	});
	
	const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
	let data = {limit : 12}
	
	$.ajax({
		url: "recomProduct",
		method: "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		success: function(res) {
			let products = res.map(item =>{ let heartClass = item.buy_em ? 'fa-solid yellow' : 'fa-regular';
						return `<div class="slide">
								<a href="productDetail?prd_cd=${item.prd_cd}&sel_nm=${item.sel_nm}">
									<div class="prd-img">
										<img src="${contextPath}${item.fil_pt}" class="slide-img">
										<i class="${heartClass} fa-heart heart" data-value="${item.prd_cd}"></i>
									</div>
									<div class="product-info">
										<div class="sel-nm">${item.sel_nm}</div>
										<div class="prd-nm">${item.prd_nm}</div>
										<div class="price">
											<div class="prd-dc">${item.dc}</div>
											<div class="prd-op">${item.prd_op}원</div>
											<div class="prd-sp">${item.prd_sp}원</div>
										</div>
										<div class="prd-bd">${item.cod_nm}</div>
									</div>
								</a>
							</div>`})
							.join('');
			$('.slider').append(products);
			initSlider();
		},
		error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
	});
	
	function initSlider() {
		const slider = document.querySelector(".slider");
		const slides = document.querySelectorAll(".slide");
		const prevBtn = document.getElementById("rec_btn_prev");
		const nextBtn = document.getElementById("rec_btn_next");

		const totalSlides = slides.length;
		const slidesToShow = 4;
		let index = 0;
		const slideWidth = slides[0]?.clientWidth || 300; // 기본값 지정

		slider.style.width = `${slideWidth * totalSlides}px`;

		function updateButtons() {
			prevBtn.style.visibility = index === 0 ? "hidden" : "visible";
			nextBtn.style.visibility = index >= totalSlides - slidesToShow ? "hidden" : "visible";
		}

		function updateSlider() {
			slider.style.transition = "transform 0.5s ease-in-out";
			slider.style.transform = `translateX(${-slideWidth * index}px)`;
			updateButtons();
		}

		nextBtn.addEventListener("click", () => {
			if (index < totalSlides - slidesToShow) {
				index += slidesToShow;
			}
			updateSlider();
		});

		prevBtn.addEventListener("click", () => {
			if (index > 0) {
				index -= slidesToShow;
			}
			updateSlider();
		});

		updateButtons();
	}
	
	
});
