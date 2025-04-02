<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.js"></script>

<!-- CSS for Page -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css" rel="stylesheet">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <title>관리자 리스트</title>

     <style>
        .tag {
            display: inline-block;
            background-color: #f0f0f0;
            border-radius: 15px;
            padding: 3px 10px;
            margin: 2px;
            font-size: 0.9em;
        }
        .tag-container {
            margin-top: 5px;
        }
        .modal-dialog {
            max-width: 500px;
        }
    </style>
</head>
<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper"><div>
	<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
	</div>


		<!-- // Sidebar -->
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
				<div>
					<jsp:include page="../inc/adminTopbar.jsp"></jsp:include>
				</div>
                <!-- Begin Page Content -->
                <div class="container-fluid">
                   <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-center mb-4">
                        <h5 class="mb-0 text-gray-800" id="todayText"></h5>
                    </div>

                    <!-- Content Row 메인 상단 -->
                    <div class="row">
              			<div class="container mt-5">
                    <div class="col-12">
                <div class="card">
                    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                        <h3 class="mb-0">관리자 리스트</h3>
                        <a href="adminRegister" class="btn btn-light">관리자 등록</a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>관리자 ID</th>
                                        <th>관리자명</th>
                                        <th>관리 스토어</th>
                                        <th>권한</th>
                                        <th>관리</th>
                                    </tr>
                                </thead>
                                <tbody id="adminListBody">
                                    <!-- 관리자 목록이 여기에 표시됩니다 -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 스토어 관리 모달 -->
    <div class="modal fade" id="manageStoresModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">관리 스토어 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="modalAdminId">
                    <div class="mb-3">
                        <label class="form-label">현재 관리 스토어</label>
                        <div id="currentStores" class="tag-container"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">스토어 추가</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="storeSearchModal" placeholder="스토어명 검색">
                            <button class="btn btn-outline-secondary" type="button" id="searchBtnModal">검색</button>
                        </div>
                        <div class="dropdown-menu w-100" id="storeDropdownModal"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="saveStoresBtn">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 권한 변경 모달 -->
    <div class="modal fade" id="changeRoleModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">관리자 권한 변경</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="roleAdminId">
                    <div class="mb-3">
                        <label for="adminRole" class="form-label">권한 선택</label>
                        <select class="form-select" id="adminRole">
                            <option value="1">총괄관리자</option>
                            <option value="2">스토어관리자</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="saveRoleBtn">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>

                    </div> <!-- /.row -->

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
    <div class="copyright text-center my-auto">
        <span>Copyright &copy; UNIPICK Admin 2025</span>
    </div>
</div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath }/resources/public/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/public/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath }/resources/public/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath }/resources/public/js/sb-admin-2.min.js"></script>
    
    <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath }/resources/public/vendor/chart.js/Chart.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/public/vendor/datepicker/moment.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/public/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	
    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath }/resources/public/js/index.js"></script>
    <script>
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
                
                let manageStoresModal = new bootstrap.Modal(document.getElementById('manageStoresModal'));
                manageStoresModal.show();
            });
            
            // 권한 변경 모달 열기
            $(document).on("click", ".change-role-btn", function() {
                let adminId = $(this).data("admin-id");
                let currentRole = $(this).data("current-role");
                
                $("#roleAdminId").val(adminId);
                $("#adminRole").val(currentRole);
                
                let changeRoleModal = new bootstrap.Modal(document.getElementById('changeRoleModal'));
                changeRoleModal.show();
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
                            bootstrap.Modal.getInstance(document.getElementById('manageStoresModal')).hide();
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
                            bootstrap.Modal.getInstance(document.getElementById('changeRoleModal')).hide();
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
                                    '<button class="btn btn-sm btn-primary manage-stores-btn" data-admin-id="' + admin.adm_id + '">스토어 관리</button> ' +
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
    </script>
</body>
</html> 