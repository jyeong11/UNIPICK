        $(document).ready(function() {
            // 관리자 목록 불러오기
            loadAdminList();
            
            // 스토어 관리 모달 열기
            $(document).on("click", ".manage-stores-btn", function() {
                let adminId = $(this).data("admin-id");
                let stores = $(this).closest("tr").find(".store-data").data("stores");
                
                $("#modalAdminId").val(adminId);
                
                // 현재 스토어 표시
                let currentStores = $("#currentStores");
                currentStores.empty();
                
                if (stores && stores.length > 0) {
                    $.each(stores, function(i, store) {
                        currentStores.append(
                            '<div class="tag" data-sel-id="' + store.sel_id + '">' + 
                            store.sel_nm + 
                            '<span class="tag-close"><i class="fas fa-times"></i></span></div>'
                        );
                    });
                }
                
                $("#manageStoresModal").modal('show');
            });
            
            // 권한 변경 모달 열기
            $(document).on("click", ".change-role-btn", function() {
                let adminId = $(this).data("admin-id");
                let currentRole = $(this).data("current-role");
                
                $("#roleAdminId").val(adminId);
                $("#adminRole").val(currentRole);
                
                $("#changeRoleModal").modal('show');
            });
            
            // 스토어 검색 (모달)
            $("#searchBtnModal").click(function() {
                let keyword = $("#storeSearchModal").val();
                if (keyword.trim() !== "") {
                    searchStoresModal(keyword);
                }
            });
            
            // 엔터키로 검색 (모달)
            $("#storeSearchModal").keypress(function(e) {
                if (e.which === 13) {
                    e.preventDefault();
                    $("#searchBtnModal").click();
                }
            });
            
            // 선택된 스토어 제거 (모달)
            $(document).on("click", "#currentStores .tag-close", function() {
                $(this).parent().remove();
            });
            
            // 검색 결과에서 스토어 선택 (모달)
            $(document).on("click", "#storeDropdownModal .store-item", function() {
                let selId = $(this).data("sel-id");
                let selNm = $(this).data("sel-nm");
                
                // 이미 선택된 스토어인지 확인
                if ($("#currentStores .tag[data-sel-id='" + selId + "']").length === 0) {
                    $("#currentStores").append(
                        '<div class="tag" data-sel-id="' + selId + '">' + 
                        selNm + 
                        '<span class="tag-close"><i class="fas fa-times"></i></span></div>'
                    );
                }
                
                $("#storeSearchModal").val("");
                $("#storeDropdownModal").hide();
            });
            
            // 스토어 저장
            $("#saveStoresBtn").click(function() {
                let adminId = $("#modalAdminId").val();
                
                // 선택된 스토어 ID 추출
                let selectedSellerIds = [];
                $("#currentStores .tag").each(function() {
                    selectedSellerIds.push($(this).data("sel-id"));
                });
                
                // AJAX 요청 전송
                $.ajax({
                    url: "updateAdminStores",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        adm_id: adminId,
                        seller_ids: selectedSellerIds
                    }),
                    success: function(response) {
                        if (response.success) {
                            alert("관리 스토어가 성공적으로 업데이트되었습니다.");
                            $("#manageStoresModal").modal('hide');
                            loadAdminList();
                        } else {
                            alert(response.msg || "업데이트 중 오류가 발생했습니다.");
                        }
                    },
                    error: function() {
                        alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
            
            // 권한 저장
            $("#saveRoleBtn").click(function() {
                let adminId = $("#roleAdminId").val();
                let role = $("#adminRole").val();
                
                // AJAX 요청 전송
                $.ajax({
                    url: "updateAdminRole",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        adm_id: adminId,
                        adm_sl: role
                    }),
                    success: function(response) {
                        if (response.success) {
                            alert("관리자 권한이 성공적으로 업데이트되었습니다.");
                            $("#changeRoleModal").modal('hide');
                            loadAdminList();
                        } else {
                            alert(response.msg || "업데이트 중 오류가 발생했습니다.");
                        }
                    },
                    error: function() {
                        alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
            
            // 스토어 검색 함수 (모달)
            function searchStoresModal(keyword) {
                $.ajax({
                    url: "searchSellers",
                    type: "GET",
                    data: { keyword: keyword },
                    success: function(sellers) {
                        let dropdown = $("#storeDropdownModal");
                        dropdown.empty();
                        
                        if (sellers.length === 0) {
                            dropdown.append('<div class="dropdown-item">검색 결과가 없습니다.</div>');
                        } else {
                            $.each(sellers, function(i, seller) {
                                dropdown.append('<div class="dropdown-item store-item" data-sel-id="' + seller.sel_id + 
                                               '" data-sel-nm="' + seller.sel_nm + '">' + seller.sel_nm + '</div>');
                            });
                        }
                        
                        dropdown.show();
                    },
                    error: function() {
                        alert("검색 중 오류가 발생했습니다.");
                    }
                });
            }
            
            // 관리자 목록 불러오기 함수
            function loadAdminList() {
                $.ajax({
                    url: "getAdminList",
                    type: "GET",
                    success: function(admins) {
                        let tableBody = $("#adminListBody");
                        tableBody.empty();
                        
                        if (admins.length === 0) {
                            tableBody.append('<tr><td colspan="6" class="text-center">등록된 관리자가 없습니다.</td></tr>');
                        } else {
                            $.each(admins, function(i, admin) {
                                let roleText = admin.adm_sl == 1 ? "총괄관리자" : "스토어관리자";
                                let storeHtml = '';
                                
                                // 스토어 태그 생성
                                if (admin.stores && admin.stores.length > 0) {
                                    storeHtml = '<div class="tag-container">';
                                    $.each(admin.stores, function(i, store) {
                                        storeHtml += '<span class="tag">' + store.sel_nm + '</span>';
                                    });
                                    storeHtml += '</div>';
                                } else {
                                    storeHtml = '없음';
                                }
                                
                                tableBody.append(
                                    '<tr>' +
                                    '<td>' + (i + 1) + '</td>' +
                                    '<td>' + admin.adm_id + '</td>' +
                                    '<td>' + admin.adm_nm + '</td>' +
                                    '<td class="store-data" data-stores=\'' + JSON.stringify(admin.stores || []) + '\'>' + storeHtml + '</td>' +
                                    '<td>' + roleText + '</td>' +
                                    '<td>' +
                                    '<button class="btn1 btn-sm manage-stores-btn" data-admin-id="' + admin.adm_id + '">스토어 관리</button> ' +
                                    '<button class="btn btn-sm btn-secondary change-role-btn" data-admin-id="' + admin.adm_id + '" data-current-role="' + admin.adm_sl + '">권한 변경</button>' +
                                    '</td>' +
                                    '</tr>'
                                );
                            });
                        }
                    },
                    error: function() {
                        alert("관리자 목록을 불러오는 중 오류가 발생했습니다.");
                    }
                });
            }
        });