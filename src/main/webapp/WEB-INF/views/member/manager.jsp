<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Kaiadmin - Bootstrap 5 Admin Dashboard</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/assets/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

<!-- Fonts and icons -->
<script
	src="${pageContext.request.contextPath }/resources/assets/js/plugin/webfont/webfont.min.js"></script>
<script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["${pageContext.request.contextPath }/resources/assets/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

<!-- OrgChart.js 라이브러리 추가 -->
<script src="https://balkan.app/js/OrgChart.js"></script>

<!-- CSS Files -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />


<style>

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 10px;
}

th, td {
	border: 1px solid #ddd;
	padding: 6px;
	text-align: left;
	white-space: nowrap; /* 줄바꿈 방지 */
    word-wrap: normal; /* 단어가 넘치면 줄바꿈 하지 않고 계속 이어짐 */
}

.btn-info {
	padding: 4px 8px;
	font-size: 12px;
}

.modal-dialog {
	max-width: 800px;
}

.pagination-container {
    display: flex;
    justify-content: space-between; /* 양 끝에 배치 */
    align-items: center; /* 세로 정렬 */
    width: 100%;
}

.pagination ul {
    list-style: none;
    display: flex;
    padding: 0;
}

.pagination ul li {
    margin: 0 5px;
}

.pagination ul li a {
    display: block;
    padding: 5px 10px;
    background-color: #f1f1f1;
    border-radius: 3px;
    text-decoration: none;
    color: #333;
}

.pagination ul li.active a {
    background-color: #007bff;
    color: white;
}

.pagination ul li.disabled a {
    pointer-events: none;
    background-color: #ddd;
}

#register {
    padding: 10px 20px;
    font-size: 14px;
}

.img-fluid {
	max-width: 100%;
	height: auto;
}

.rounded-circle {
	border-radius: 50%;
}

.table-bordered th {
	width: 20%;
}

.table-bordered th, .table-bordered td {
	padding: 10px;
	vertical-align: middle;
}

.table-bordered th {
	background-color: #f2f2f2;
	width: 30%;
}

.btn {
	padding: 0.375rem 0.75rem;
}

#keyword {
	width: auto;
	flex-grow: 2;
}

html, body {
	height: 100%;
	margin: 0;
}

body {
	display: flex;
	flex-direction: column;
}

.main-panel {
	flex: 1 0 auto;
	display: flex;
	flex-direction: column;
}

.container {
	flex: 1 0 auto;
}

.page-inner {
	flex: 1 0 auto;
	display: flex;
	flex-direction: column;
}

#memberTable {
	flex: 1 0 auto;
	overflow-x: auto;
}

footer {
	flex-shrink: 0;
}

.table-responsive {
	overflow-x: auto;
	max-width: 100%;
}

#infoDetail {
	width: max-content;
	min-width: 100%;
}

#infoDetail th, #infoDetail td {
	white-space: nowrap;
	padding: 8px;
}

.controls-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
  flex-wrap: nowrap;
}

#filterForm, #searchForm {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%; /* width 조정 */
  margin-bottom: 10px;
}

#filterForm select, #searchForm select, #searchForm input, .btn {
  margin-right: 5px;
  height: 38px; /* 높이 통일 */
}

#filterForm {
  width: 40%;
}

#searchForm {
  width: 40%;
}

#showOrgChart {
  width: auto;
  white-space: nowrap;
}

#filterType, #filterValue, #searchType {
  width: auto;
  flex-grow: 1;
}

#keyword {
  width: auto;
  flex-grow: 2;
}
</style>


</head>
<body>
	<div class="wrapper">
		<%@ include file="/resources/assets/inc/sidebar.jsp"%>
		<!-- sidebar -->
		<div class="main-panel">
			<div class="main-header">
				<%@ include file="/resources/assets/inc/logo_header.jsp"%>
				<!-- Logo Header -->
				<%@ include file="/resources/assets/inc/navbar.jsp"%>
				<!-- Navbar Header -->
			</div>
			<div class="container">
				<div class="page-inner">
					<!------------------------------------------------------------------------------------------------------------------>
					<h1>관리자 페이지</h1>
					<div class="controls-container"
						style="display: flex; align-items: center; justify-content: space-between; gap: 10px;">
						<!-- 필터 폼 추가 -->
						<form id="filterForm" class="form-inline"
							action="${pageContext.request.contextPath}/member/filter"
							method="get">
							<input type="hidden" name="pageType" value="manager"> <select
								name="filterType" id="filterType" class="form-control">
								<option value="">필터 선택</option>
								<option value="emp_dnum">부서</option>
								<option value="emp_bnum">근무지</option>
								<option value="emp_position">직급</option>
								<option value="emp_job">직책</option>
							</select> <select name="filterValue" id="filterValue" class="form-control">
								<option value="">선택하세요</option>
							</select>
							<button type="button" id="applyFilter" class="btn btn-primary">필터
								적용</button>
							<button type="button" id="resetFilter" class="btn btn-primary">초기화</button>
						</form>

						<!-- 검색 폼 추가 -->
						<form id="searchForm" class="form-inline">
							<input type="hidden" name="pageType" value="manager"> <select
								name="searchType" id="searchType" class="form-control">
								<option value="emp_id">사원번호</option>
								<option value="emp_name">사원명</option>
								<option value="emp_dnum">부서명</option>
								<option value="emp_position">직급</option>
								<option value="emp_job">직책</option>
							</select> <input type="text" name="keyword" id="keyword"
								class="form-control" placeholder="검색어 입력">
							<button type="button" id="searchBtn" class="btn btn-primary">검색</button>
						</form>

						<!-- 조직도 버튼 추가 -->
						<button id="showOrgChart" class="btn btn-primary">조직도 보기</button>
					</div>
				</div>


				<!-- 사원 목록 테이블 -->
				<div class="table-responsive">
					<table class="table table-bordered" id="memberTable">
						<thead>
							<tr>
								<th>사원번호</th>
								<th>이름</th>
								<th>생년월일</th>
								<th>성별</th>
								<th>연락처</th>
								<th>이메일</th>
								<th>주소</th>
								<th>지점명</th>
								<th>부서</th>
								<th>직급</th>
								<th>직책</th>
								<th>연봉</th>
								<th>근무형태</th>
								<th>재직구분</th>
								<th>입사일</th>
								<th>휴직일</th>
								<th>복직일</th>
								<th>퇴사일</th>
								<th>정보수정</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="member" items="${members}">
								<tr>
									<td>${member.emp_id}</td>
									<td>${member.emp_name}</td>
									<td>${member.emp_birth}</td>
									<td>${member.emp_gender}</td>
									<td>${member.emp_tel}</td>
									<td>${member.emp_email}</td>
									<td>${member.emp_addr}</td>
									<td>${member.emp_bnum}</td>
									<td>${member.emp_dnum}</td>
									<td>${member.emp_position}</td>
									<td>${member.emp_job}</td>
									<td>${member.emp_salary}</td>
									<td>${member.emp_work_type}</td>
									<td>${member.emp_status}</td>
									<td>${member.emp_start_date}</td>
									<td>${member.emp_break_date}</td>
									<td>${member.emp_restart_date}</td>
									<td>${member.emp_quit_date}</td>
									<td><button class="btn btn-info btn-sm" onclick="showEditModal('${member.emp_id}')">수정</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<!-- 페이징  -->
				<div class="pagination-container">
				<div class="pagination">
					<ul>
						<!-- 이전 페이지로 가는 링크 (첫 페이지에서는 비활성화) -->
						<li class="${currentPage == 1 ? 'disabled' : ''}"><a
							href="?page=${currentPage - 1}" aria-label="Previous">&laquo;
								이전</a></li>

						<!-- 페이지 숫자 링크 -->
						<c:forEach var="i" begin="1" end="${totalPages}">
							<li class="${currentPage == i ? 'active' : ''}"><a
								href="?page=${i}">${i}</a></li>
						</c:forEach>

						<!-- 다음 페이지로 가는 링크 (마지막 페이지에서는 비활성화) -->
						<li class="${currentPage == totalPages ? 'disabled' : ''}"><a
							href="?page=${currentPage + 1}" aria-label="Next">다음 &raquo;</a>
						</li>
					</ul>
				</div>

				<button id="register" class="btn btn-primary">사원등록</button>
				</div>
				<!-- 조직도 모달 -->
				<div class="modal fade" id="orgChartModal" tabindex="-1"
					role="dialog" aria-hidden="true">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">조직도</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<label for="branchSelect">지부 선택:</label> <select
										id="branchSelect" class="form-control">
										<!-- 옵션들은 JavaScript로 동적으로 추가될 것입니다 -->
									</select>
								</div>
								<div id="orgChart" style="height: 600px;"></div>
							</div>
						</div>
					</div>
				</div>

				<!-- Modal -->
				<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
				    <div class="modal-dialog modal-lg" role="document">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h5 class="modal-title">사원 정보 수정</h5>
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                    <span aria-hidden="true">&times;</span>
				                </button>
				            </div>
				            <div class="modal-body">
				                <form id="editForm">
				                    
				                    <div class="form-group">
				                        <label for="edit_emp_id">사원번호</label>
				                        <input type="text" class="form-control" id="edit_emp_id" name="emp_id">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_name">이름</label>
				                        <input type="text" class="form-control" id="edit_emp_name" name="emp_name">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_birth">생년월일</label>
				                        <input type="date" class="form-control" id="edit_emp_birth" name="emp_birth">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_gender">성별</label>
				                        <input type="text" class="form-control" id="edit_emp_gender" name="emp_gender">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_tel">연락처</label>
				                        <input type="text" class="form-control" id="edit_emp_tel" name="emp_tel">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_email">이메일</label>
				                        <input type="text" class="form-control" id="edit_emp_email" name="emp_email">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_addr">주소</label>
				                        <input type="text" class="form-control" id="edit_emp_addr" name="emp_addr">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_bnum">지점명</label>
				                        <input type="text" class="form-control" id="edit_emp_bnum" name="emp_bnm">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_dnum">부서</label>
				                        <input type="text" class="form-control" id="edit_emp_dnum" name="emp_dnum">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_position">직급</label>
				                        <input type="text" class="form-control" id="edit_emp_position" name="emp_position">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_job">직책</label>
				                        <input type="text" class="form-control" id="edit_emp_job" name="emp_job">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_salary">연봉</label>
				                        <input type="text" class="form-control" id="edit_emp_salary" name="emp_salary">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_work_type">근무형태</label>
				                        <input type="text" class="form-control" id="edit_emp_work_type" name="emp_work_type">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_status">재직구분</label>
				                        <input type="text" class="form-control" id="edit_emp_status" name="emp_status">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_start_date">입사일</label>
				                        <input type="date" class="form-control" id="edit_emp_start_date" name="emp_start_date">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_break_date">휴직일</label>
				                        <input type="date" class="form-control" id="edit_emp_break_date" name="emp_break_date">
				                    </div>
				                    <div class="form-group">
				                        <label for="edit_emp_restart_date">복직일</label>
				                        <input type="date" class="form-control" id="edit_emp_restart_date" name="emp_restart_date">
				                    </div>
				                    
				                    <div class="form-group">
				                        <label for="edit_emp_quit_date">퇴사일</label>
				                        <input type="date" class="form-control" id="edit_emp_quit_date" name="emp_quit_date">
				                    </div>
				                </form>
				            </div>
				            <div class="modal-footer">
				                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				                <button type="button" class="btn btn-primary" onclick="updateEmployee()">저장</button>
						
						<!-- page-inner -->
					</div>
					<!-- container -->
					<%-- 	    <%@ include file="/resources/assets/inc/footer.jsp" %> --%>
				</div>
			</div>

			<!------------------------------------------------------------------------------------------------------------------>
		</div>
		<!-- page-inner -->
	</div>
	<!-- container -->
	<%@ include file="/resources/assets/inc/footer.jsp"%>
	</div>
	<!-- main-panel -->
	</div>
	<!-- main-wrapper -->

	<!--   Core JS Files   -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<!-- jQuery Scrollbar -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

	<!-- Chart JS -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart.js/chart.min.js"></script>

	<!-- jQuery Sparkline -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

	<!-- Chart Circle -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart-circle/circles.min.js"></script>

	<!-- Datatables -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/datatables/datatables.min.js"></script>

	<!-- Bootstrap Notify -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

	<!-- jQuery Vector Maps -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/world.js"></script>

	<!-- Sweet Alert -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/sweetalert/sweetalert.min.js"></script>

	<!-- Kaiadmin JS -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/kaiadmin.min.js"></script>

	<!-- Kaiadmin DEMO methods, don't include it in your project! -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/setting-demo.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/demo.js"></script>
	<script>
      $("#lineChart").sparkline([102, 109, 120, 99, 110, 105, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#177dff",
        fillColor: "rgba(23, 125, 255, 0.14)",
      });

      $("#lineChart2").sparkline([99, 125, 122, 105, 110, 124, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#f3545d",
        fillColor: "rgba(243, 84, 93, .14)",
      });

      $("#lineChart3").sparkline([105, 103, 123, 100, 95, 105, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#ffa534",
        fillColor: "rgba(255, 165, 52, .14)",
      });
      
      // 사원 정보 수정
      function showEditModal(emp_id) {
	    $.ajax({
	        url: '${pageContext.request.contextPath}/member/detail/' + emp_id,
	        type: 'GET',
	        success: function(member) {
	            $('#edit_emp_id').val(member.emp_id);
	            $('#edit_emp_name').val(member.emp_name);
	            $('#edit_emp_birth').val(member.emp_birth);
	            $('#edit_emp_gender').val(member.emp_gender);
	            $('#edit_emp_tel').val(member.emp_tel);
	            $('#edit_emp_email').val(member.emp_email);
	            $('#edit_emp_addr').val(member.emp_addr);
	            $('#edit_emp_bnum').val(member.emp_bnum);
	            $('#edit_emp_dnum').val(member.emp_dnum);
	            $('#edit_emp_position').val(member.emp_position);
	            $('#edit_emp_job').val(member.emp_job);
	            $('#edit_emp_salary').val(member.emp_salary);
	            $('#edit_emp_work_type').val(member.work_type);
	            $('#edit_emp_status').val(member.emp_status);
	            $('#edit_emp_start_date').val(member.emp_start_date);
	            $('#edit_emp_break_date').val(member.emp_break_date);
	            $('#edit_emp_restart_date').val(member.emp_restart_date);
	            $('#edit_emp_quit_date').val(member.emp_quit_date);
	           
	            $('#editModal').modal('show');
	        },
	        error: function(xhr, status, error) {
	            alert('사원 정보를 불러오는데 실패했습니다.');
		        }
		    });
		}
	
		function updateEmployee() {
		    var formData = $('#editForm').serialize();
		    $.ajax({
		        url: '${pageContext.request.contextPath}/member/update',
		        type: 'POST',
		        data: formData,
		        success: function(response) {
		            if(response.success) {
		                alert('사원 정보가 성공적으로 업데이트되었습니다.');
		                $('#editModal').modal('hide');
		                loadMembers(currentPage);  // 현재 페이지 새로고침
		            } else {
		                alert('사원 정보 업데이트에 실패했습니다: ' + response.message);
		            }
		        },
		        error: function(xhr, status, error) {
		            alert('서버 오류가 발생했습니다.');
			        }
			    });
			}
	      
	    // 전역 변수 추가
	    var currentState = 'manager'; 
		var currentSearchType = '';
		var currentKeyword = '';
		var currentFilterType = '';
		var currentFilterValue = '';
      
        // 검색기능
        $(document).ready(function() {
        // 페이지 로드 시 사원 목록 불러오기
        loadMembers(1);

        // 검색 버튼 클릭 이벤트
        $('#searchBtn').click(function() {
		    currentSearchType = $('#searchType').val();
		    currentKeyword = $('#keyword').val();
		    searchMembers(1);
		});

        // 엔터 키 이벤트
        $('#keyword').keypress(function(e) {
          if (e.which == 13) {
            e.preventDefault();
            searchMembers(1);
	        }
	      });
	    });

        function loadMembers(page) {
        $.ajax({
          url: '${pageContext.request.contextPath}/member/manager',
          type: 'GET',
          data: { page: page },
          success: function(response) {
            updateTable(response);
          },
          error: function() {
            alert('사원 목록을 불러오는데 실패했습니다.');
	        }
	      });
	    }

        function searchMembers(page) {
    	    currentState = 'search';
    	    var searchType = currentSearchType || $('#searchType').val();
    	    var keyword = currentKeyword || $('#keyword').val();
    	    var pageType = $('#searchForm input[name="pageType"]').val();
    	    currentSearchType = searchType;
    	    currentKeyword = keyword;
    	    
    	    $.ajax({
    	        url: '${pageContext.request.contextPath}/member/search',
    	        type: 'GET',
    	        data: { 
    	            searchType: searchType,
    	            keyword: keyword,
    	            pageType: pageType,
    	            page: page
    	        },
    	        success: function(response) {
    	            updateTable(response);
    	        },
    	        error: function() {
    	            alert('검색에 실패했습니다.');
    	        }
    	    });
    	}
	  
       	function updateTable(response) {
    	    $('#memberTable tbody').empty();
    	    var members = $(response).find('#memberTable tbody tr');
    	    $('#memberTable tbody').append(members);
    	    
    	    $('.pagination').html($(response).find('.pagination').html());
    	    
    	    // 페이지네이션 이벤트 다시 바인딩
    	    $('.pagination a').click(function(e) {
    	        e.preventDefault();
    	        var page = $(this).attr('href').split('page=')[1];
    	        
    	        switch(currentState) {
    	            case 'manager':
    	                loadMembers(page);
    	                break;
    	            case 'search':
    	                searchMembers(page);
    	                break;
    	            case 'filter':
    	                applyFilter(page);
    	                break;
    	        }
    	    });
    	}
      	
        // 조직도 관련 스크립트
	    $(document).ready(function() {
		   loadBranchList();
		
		    $('#showOrgChart').click(function() {
		        $('#orgChartModal').modal('show');
		        var selectedBranch = $('#branchSelect').val();
		        if (selectedBranch) {
		            loadOrgChart(selectedBranch);
		        }
		    });
		
		    $('#branchSelect').change(function() {
		        var selectedBranch = $(this).val();
		        loadOrgChart(selectedBranch);
		    });
		    
		    $('#orgChartModal .close').click(function() {
		        $('#orgChartModal').modal('hide');
		    });
		    
		    $('.close').on('click', function() {
		        $('#detailModal').modal('hide');
		    });

		    // 모달 외부 클릭으로 닫기
		    $('#orgChartModal').click(function(event) {
		        if (event.target == this) {
		            $(this).modal('hide');
		        }
		    });
		    
		});
      
      	// 필터 관련 스크립트
      	 $(document).ready(function() {
        // 필터 타입 변경 시 필터 값 옵션 업데이트
        $('#filterType').change(function() {
            var filterType = $(this).val();
            updateFilterValues(filterType);
        });

        // 필터 적용 버튼 클릭 이벤트
        $('#applyFilter').click(function() {
	    currentFilterType = $('#filterType').val();
	    currentFilterValue = $('#filterValue').val();
	    applyFilter(1);
		});

        // 초기화 버튼 클릭 이벤트
        $('#resetFilter').click(function() {
            resetFilter();
        });
        

	    });

        // 필터 값 옵션 업데이트 함수
        function updateFilterValues(filterType) {
            $.ajax({
                url: '${pageContext.request.contextPath}/member/filterOptions',
                type: 'GET',
                data: { filterType: filterType },
                success: function(options) {
                    var $filterValue = $('#filterValue');
                    $filterValue.empty().append('<option value="">선택하세요</option>');
                    $.each(options, function(index, option) {
                        $filterValue.append($('<option></option>').val(option).text(option));
                    });
                },
                error: function() {
                    alert('필터 옵션을 불러오는데 실패했습니다.');
                }
            });
        }
		
		function loadBranchList() {
		    $.ajax({
		        url: '${pageContext.request.contextPath}/member/branchList',
		        type: 'GET',
		        success: function(branches) {
		            var select = $('#branchSelect');
		            select.empty();
		            $.each(branches, function(i, branch) {
		                select.append($('<option></option>').val(branch).text(branch));
		            });
		            // 부산지부를 기본값으로 설정
		            select.val('부산지부');
		            loadOrgChart('부산지부');
		        },
		        error: function() {
		            alert('지부 목록을 불러오는데 실패했습니다.');
		        }
		    });
		}
		
		function loadOrgChart(branchName) {
		    $.ajax({
		        url: '${pageContext.request.contextPath}/member/orgChart',
		        type: 'GET',
		        data: { emp_bnum: branchName },
		        success: function(data) {
		            drawOrgChart(data);
		        },
		        error: function() {
		            alert('조직도 데이터를 불러오는데 실패했습니다.');
		        }
		    });
		}
		
		function drawOrgChart(data) {
		    console.log("Drawing org chart with data:", data);
		    var chart = new OrgChart(document.getElementById("orgChart"), {
		        template: "ula",
		        enableDragDrop: true,
		        nodeBinding: {
		            field_0: "name",
		            field_1: "title"
		        },
		        nodes: data.map(node => ({
		            id: node.id,
		            pid: node.pid,
		            name: node.name,
		            title: node.title,
		            emp_job: node.emp_job,
		            emp_dnum: node.emp_dnum
		        })),
		        nodeMouseClick: OrgChart.action.none,
		    });

		    chart.on('click', function(sender, args) {
		        var node = chart.get(args.node.id);
		        console.log("Node clicked:", node);
		        
		        if (node && (node.emp_job === "부서장" || node.title === "부서장")) {
		            console.log("부서장 노드 클릭됨:", node.id);
		            var departmentId = node.emp_dnum || node.pid;
		            showTeamMembers(node.id, departmentId);
		        } else {
		            console.log("클릭된 노드는 부서장이 아닙니다.");
		        }
		    });
		}

		function showTeamMembers(nodeId, departmentId) {
		    console.log("Fetching team members for:", nodeId, departmentId);
		    if (!departmentId) {
		        console.error("유효하지 않은 부서 ID:", departmentId);
		        return;
		    }

		    $.ajax({
		        url: '${pageContext.request.contextPath}/member/teamMembers',
		        type: 'GET',
		        data: { emp_dnum: departmentId },
		        success: function(members) {
		            console.log("Received team members:", members);
		            if (members && members.length > 0) {
		                var table = '<table class="table"><thead><tr><th>이름</th><th>직책</th></tr></thead><tbody>';
		                members.forEach(function(member) {
		                    table += '<tr><td>' + 
		                        (member.emp_name ? escapeHtml(member.emp_name) : 'N/A') + 
		                        '</td><td>' + 
		                        (member.emp_job ? escapeHtml(member.emp_job) : 'N/A') + 
		                        '</td></tr>';
		                });
		                table += '</tbody></table>';
		                
		                swal({
		                    title: escapeHtml(departmentId) + " 팀원 목록",
		                    content: {
		                        element: "div",
		                        attributes: {
		                            innerHTML: table
		                        }
		                    },
		                    width: '600px'
		                });
		            } else {
		                console.log("No team members found");
		                swal("알림", "팀원 정보를 찾을 수 없습니다.", "info");
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error("팀원 정보 가져오기 오류:", error);
		            console.log("XHR:", xhr);
		            console.log("Status:", status);
		            swal("오류", "팀원 목록을 불러오는데 실패했습니다.", "error");
		        }
		    });
		}

		function escapeHtml(unsafe) {
		    return unsafe
		         .replace(/&/g, "&amp;")
		         .replace(/</g, "&lt;")
		         .replace(/>/g, "&gt;")
		         .replace(/"/g, "&quot;")
		         .replace(/'/g, "&#039;");
		}
		
		// 필터 함수
		function applyFilter(page) {
	    currentState = 'filter';
	    var filterType = currentFilterType || $('#filterType').val();
	    var filterValue = currentFilterValue || $('#filterValue').val();
	    var pageType = $('input[name="pageType"]').val();
	    currentFilterType = filterType;
	    currentFilterValue = filterValue;
	    
	    $.ajax({
	        url: '${pageContext.request.contextPath}/member/filter',
	        type: 'GET',
	        data: { 
	            filterType: filterType,
	            filterValue: filterValue,
	            pageType: pageType,
	            page: page || 1
	        },
	        success: function(response) {
	            updateTable(response);
	        },
	        error: function() {
	            alert('필터링에 실패했습니다.');
		        }
		    });
		}

        // 필터 초기화 함수
        function resetFilter() {
	    currentState = 'manager';
	    currentFilterType = '';
	    currentFilterValue = '';
	    $('#filterType').val('');
	    $('#filterValue').empty().append('<option value="">선택하세요</option>');
	    loadMembers(1);
		}

        // 페이지 로드 함수
        function loadMembers(page) {
	    currentState = 'manager';
	    $.ajax({
	        url: '${pageContext.request.contextPath}/member/manager',
	        type: 'GET',
	        data: { page: page },
	        success: function(response) {
	            updateTable(response);
	        },
	        error: function() {
	            alert('사원 목록을 불러오는데 실패했습니다.');
		        }
		    });
		}

      
    </script>
</body>
</html>