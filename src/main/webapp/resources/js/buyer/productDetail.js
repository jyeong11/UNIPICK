$(function() {
	window.loadSize = function() {
        var selectedColor = $("#color").val();
		var sizeSelect = $("#size")

        if (!selectedColor) {
            sizeSelect.prop("disabled", true);
			return;
        }
		sizeSelect.prop("disabled", false);
        $.ajax({
            url: 'getSizeByColor',
            method: 'POST',
            data: JSON.stringify({prd_cd: prdCd,color: selectedColor}),
            contentType: 'application/json',
			success: function(res) {
                updateSize(res);
            },
            error: function() {
                alert("사이즈 정보를 불러오는 데 실패했습니다.");
            }
        });
	}
	function updateSize(sizes) {
        var sizeSelect = $('#size');
        sizeSelect.empty();

        sizeSelect.append('<option>[size]를 선택하세요.</option>');

        $.each(sizes, function(index, size) {
            sizeSelect.append('<option value="' + size.siz_nm + '">' + size.siz_nm);
        });
		// 옵션 전부 클릭시 이벤트 발생
		 sizeSelect.off("change").on("change", function () {
            showSelectedOption();
        });
    }
	 function showSelectedOption() {
        var selectedColor = $("#color").val();
        var selectedSize = $("#size").val();

        if (!selectedColor || !selectedSize) {
            $("#selected-option").hide();
            return;
        }

        $.ajax({
            url: "getSizeByColor",
            method: "POST",
            data: JSON.stringify({prd_cd: prdCd, color: selectedColor, size: selectedSize}),
            contentType: "application/json",
            success: function (res) {
                $("#option-text").text(selectedColor + " / " + selectedSize);
                $("#option-price").text(res[0].prd_sp + "원");
                $("#selected-option").fadeIn();
            },
            error: function () {
                alert("가격 정보를 불러오는 데 실패했습니다.");
            }
        });
    }

    // 컬러 변경 시 사이즈 초기화 및 선택 이벤트 등록
    $("#color").change(function() {
        $("#selected-option").hide();
        loadSize();
    });
	
});