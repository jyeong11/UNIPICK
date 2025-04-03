$(document).ready(function() {
    console.log("문서 로드 완료");
    
    // 스토어 검색
    $("#searchBtn").click(function() {
        console.log("검색 버튼 클릭됨");
        let keyword = $("#storeSearch").val();
        if (keyword.trim() !== "") {
            searchStores(keyword);
        }
    });

    // 스토어 검색 함수
    function searchStores(keyword) {
        console.log("스토어 검색 시작:", keyword);
        $.ajax({
            url: "searchSellers",
            type: "GET",
            data: { keyword: keyword },
            dataType: "json",
            success: function(sellers) {
                console.log("검색 결과:", sellers);
                let dropdown = $("#storeDropdown");
                dropdown.empty();
                
                if (sellers.length === 0) {
                    dropdown.append('<div class="dropdown-item">검색 결과가 없습니다.</div>');
                } else {
                    sellers.forEach(function(seller) {
                        dropdown.append('<div class="dropdown-item store-item" data-sel-id="' + seller.sel_id + 
                                   '" data-sel-nm="' + seller.sel_nm + '">' + seller.sel_nm + '</div>');
                    });
                }
                
                dropdown.css("display", "block");
            },
            error: function(xhr, status, error) {
                console.error("검색 오류:", error, xhr.responseText);
                alert("검색 중 오류가 발생했습니다.");
            }
        });
    }
    
    // 엔터키로 검색
    $("#storeSearch").keypress(function(e) {
        if (e.which === 13) {
            e.preventDefault();
            $("#searchBtn").click();
        }
    });
    
    // 검색 결과에서 스토어 선택
    $(document).on("click", ".store-item", function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        let selId = $(this).data("sel-id");
        let selNm = $(this).data("sel-nm");
        
        console.log("스토어 선택됨:", { selId, selNm });
        
        // 이미 선택된 스토어인지 확인
        if ($("#selectedStores .tag[data-sel-id='" + selId + "']").length === 0) {
            let tagHtml = '<div class="tag" data-sel-id="' + selId + '">' + 
                         selNm + 
                         '<span class="tag-close"><i class="fas fa-times"></i></span></div>';
            
            $("#selectedStores").append(tagHtml);
            console.log("선택된 스토어 추가됨:", selNm);
        }
        
        $("#storeSearch").val("");
        $("#storeDropdown").css("display", "none");
    });
    
    // 선택된 스토어 제거
    $(document).on("click", ".tag-close", function(e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).parent().remove();
        console.log("스토어 태그 제거됨");
    });
    
    // 검색창 외 클릭 시 드롭다운 숨기기
    $(document).on("click", function(event) {
        if (!$(event.target).closest(".input-group, #storeDropdown").length) {
            $("#storeDropdown").css("display", "none");
        }
    });
    
    // 관리자 등록 폼 제출
    $("#adminRegisterForm").submit(function(e) {
        e.preventDefault();
        
        // 선택된 스토어 ID 추출
        let selectedSellerIds = [];
        $("#selectedStores .tag").each(function() {
            selectedSellerIds.push($(this).data("sel-id"));
        });
        
        console.log("선택된 스토어 IDs:", selectedSellerIds);
        
        // AJAX 요청 데이터 준비
        let formData = {
            adm_id: $("#adm_id").val(),
            adm_pw: $("#adm_pw").val(),
            adm_nm: $("#adm_nm").val(),
            adm_sl: $("#adm_sl").val(),
            seller_ids: selectedSellerIds
        };
        
        // AJAX 요청 전송
        $.ajax({
            url: "adminRegister",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function(response) {
                console.log(response);
                if (response.success) {
                    alert("관리자가 성공적으로 등록되었습니다.");
                    window.location.href = "adminList";
                } else {
                    alert(response.msg || "등록 중 오류가 발생했습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 오류:", error);
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    });
});