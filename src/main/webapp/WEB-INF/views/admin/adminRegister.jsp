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

    <title>관리자 등록</title>

    <style>
        .tag-container {
            display: flex;
            flex-wrap: wrap;
            padding: 5px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            min-height: 38px;
        }
        .tag {
            display: inline-block;
            background-color: #f0f0f0;
            border-radius: 15px;
            padding: 5px 10px;
            margin: 3px;
        }
        .tag-close {
            margin-left: 5px;
            cursor: pointer;
        }
        .dropdown-menu {
            max-height: 200px;
            overflow-y: auto;
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
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header py-3">
                        <h3 class="mb-0">관리자 등록</h3>
                    </div>
                    <div class="card-body">
                        <form id="adminRegisterForm">
                            <div class="mb-3">
                                <label for="adm_id" class="form-label">관리자 ID</label>
                                <input type="text" class="form-control" id="adm_id" name="adm_id" required>
                            </div>
                            <div class="mb-3">
                                <label for="adm_pw" class="form-label">비밀번호</label>
                                <input type="password" class="form-control" id="adm_pw" name="adm_pw" required>
                            </div>
                            <div class="mb-3">
                                <label for="adm_nm" class="form-label">관리자명</label>
                                <input type="text" class="form-control" id="adm_nm" name="adm_nm" required>
                            </div>
                            <div class="mb-3">
                                <label for="adm_sl" class="form-label">보안등급</label>
                                <select class="form-select" id="adm_sl" name="adm_sl" required>
                                    <option value="1">총괄관리자</option>
                                    <option value="2">스토어관리자</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">관리 스토어</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="storeSearch" placeholder="스토어명 검색">
                                    <button class="btn btn-outline-secondary" type="button" id="searchBtn">검색</button>
                                </div>
                                <div class="dropdown-menu w-100" id="storeDropdown"></div>
                                <div class="tag-container mt-2" id="selectedStores"></div>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">등록하기</button>
                                <a href="adminList" class="btn btn-secondary">목록으로</a>
                            </div>
                        </form>
                    </div>
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
            // 스토어 검색
            $("#searchBtn").click(function() {
                let keyword = $("#storeSearch").val();
                if (keyword.trim() !== "") {
                    searchStores(keyword);
                }
            });
            
            // 엔터키로 검색
            $("#storeSearch").keypress(function(e) {
                if (e.which === 13) {
                    e.preventDefault();
                    $("#searchBtn").click();
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
                        if (response.success) {
                            alert("관리자가 성공적으로 등록되었습니다.");
                            window.location.href = "adminList";
                        } else {
                            alert(response.msg || "등록 중 오류가 발생했습니다.");
                        }
                    },
                    error: function() {
                        alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
            
            // 스토어 검색 함수
            function searchStores(keyword) {
                $.ajax({
                    url: "searchSellers",
                    type: "GET",
                    data: { keyword: keyword },
                    success: function(sellers) {
                        let dropdown = $("#storeDropdown");
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
            
            // 검색 결과에서 스토어 선택
            $(document).on("click", ".store-item", function() {
                let selId = $(this).data("sel-id");
                let selNm = $(this).data("sel-nm");
                
                // 이미 선택된 스토어인지 확인
                if ($("#selectedStores .tag[data-sel-id='" + selId + "']").length === 0) {
                    $("#selectedStores").append(
                        '<div class="tag" data-sel-id="' + selId + '">' + 
                        selNm + 
                        '<span class="tag-close"><i class="fas fa-times"></i></span></div>'
                    );
                }
                
                $("#storeSearch").val("");
                $("#storeDropdown").hide();
            });
            
            // 선택된 스토어 제거
            $(document).on("click", ".tag-close", function() {
                $(this).parent().remove();
            });
            
            // 검색창 외 클릭 시 드롭다운 숨기기
            $(document).on("click", function(event) {
                if (!$(event.target).closest(".input-group, #storeDropdown").length) {
                    $("#storeDropdown").hide();
                }
            });
        });
    </script>
</body>
</html> 