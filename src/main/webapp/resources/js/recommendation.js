window.addEventListener("DOMContentLoaded", function () {
    const slider = document.querySelector(".slider");
    const slides = document.querySelectorAll(".slide");
    const prevBtn = document.getElementById("rec_btn_prev");
    const nextBtn = document.getElementById("rec_btn_next");

    const totalSlides = slides.length;
    const slidesToShow = 4;  // 한 번에 보여줄 이미지 수
    let index = 0;  // 처음 시작은 첫 번째 이미지
    const slideWidth = slides[0].clientWidth;  // 슬라이드의 너비 (각 이미지의 너비)

    // 슬라이더의 전체 너비를 슬라이드 개수에 맞게 설정
    slider.style.width = `${slideWidth * totalSlides}px`;

    // 버튼 상태 업데이트 함수
    function updateButtons() {
        if (index === 0) {
            prevBtn.style.visibility = "hidden";  // 첫 번째 페이지에서는 이전 버튼 숨김
        } else {
            prevBtn.style.visibility = "visible";  // 첫 번째가 아니면 이전 버튼 보임
        }

        if (index >= totalSlides - slidesToShow) {
            nextBtn.style.visibility = "hidden";  // 마지막 페이지에서는 다음 버튼 숨김
        } else {
            nextBtn.style.visibility = "visible";  // 마지막이 아니면 다음 버튼 보임
        }
    }

    // 슬라이더 업데이트
    function updateSlider() {
        slider.style.transition = "transform 0.5s ease-in-out";
        slider.style.transform = `translateX(${-slideWidth * index}px)`;  // index만큼 이동
        updateButtons();  // 버튼 상태를 업데이트
    }

    nextBtn.addEventListener("click", () => {
        if (index < totalSlides - slidesToShow) {
            index += slidesToShow;  // 4개씩 이동
        } else {
            index = totalSlides - slidesToShow;  // 마지막에서 더 이상 넘지 않도록
        }
        updateSlider();
    });

    prevBtn.addEventListener("click", () => {
        if (index > 0) {
            index -= slidesToShow;  // 4개씩 이동
        } else {
            index = 0;  // 처음에서 더 이상 뒤로 가는 일 없도록
        }
        updateSlider();
    });

    // 초기 버튼 상태 업데이트
    updateButtons();
});
