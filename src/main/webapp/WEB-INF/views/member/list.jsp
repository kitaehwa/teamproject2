<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Kaiadmin - Bootstrap 5 Admin Dashboard</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="${pageContext.request.contextPath }/resources/assets/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />

    <!-- Fonts and icons -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/webfont/webfont.min.js"></script>
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

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />
  
  
  <style>
      	table {
		    width: 100%;
		    border-collapse: collapse;
		    margin-bottom: 10px; /* 테이블 아래 여백 줄이기 */
		}
		
		th, td {
		    border: 1px solid #ddd;
		    padding: 6px; /* 패딩 줄이기 */
		    text-align: left;
		}
		
		.btn-info {
		    padding: 4px 8px; /* 버튼 패딩 줄이기 */
		    font-size: 12px; /* 버튼 글씨 크기 줄이기 */
		}
      
       .modal-dialog { max-width: 800px; 
       }
       
       .pagination ul {
	        list-style: none;
	        display: flex;
	        justify-content: center;
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
	    
	    /* 프로필 사진을 둥글게 하고 크기 조정 */
	    .img-fluid {
	        max-width: 100%;
	        height: auto;
	    }
	
	    .rounded-circle {
	        border-radius: 50%;
	    }
	
	    /* 테이블 스타일 */
	    .table-bordered th {
	    	width: 20%; /* 열 너비 줄이기 */
		}
	
	    .table-bordered th,
	    .table-bordered td {
	        padding: 10px;
	        vertical-align: middle;
	    }
	
	    .table-bordered th {
	        background-color: #f2f2f2;
	        width: 30%;
	    }
	    
  </style>
    
  
  </head>
  <body>
    <div class="wrapper">
      <%@ include file="/resources/assets/inc/sidebar.jsp" %> <!-- sidebar -->
      <div class="main-panel">
        <div class="main-header">
          <%@ include file="/resources/assets/inc/logo_header.jsp" %> <!-- Logo Header -->
          <%@ include file="/resources/assets/inc/navbar.jsp" %> <!-- Navbar Header -->
        </div>
        <div class="container">
          <div class="page-inner">
<!------------------------------------------------------------------------------------------------------------------>

<h1>사원 목록</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>사원번호</th>
                    <th>이름</th>
                    <th>직급</th>
                    <th>부서</th>
                    <th>상세정보</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="member" items="${members}">
                    <tr>
                        <td>${member.emp_id}</td>
                        <td>${member.emp_name}</td>
                        <td>${member.emp_position}</td>
                        <td>${member.emp_dnum}</td>
                        <td><button class="btn btn-info btn-sm" onclick="showDetail('${member.emp_id}')">상세보기</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div class="pagination">
		    <ul>
		        <!-- 이전 페이지로 가는 링크 (첫 페이지에서는 비활성화) -->
		        <li class="${currentPage == 1 ? 'disabled' : ''}">
		            <a href="?page=${currentPage - 1}" aria-label="Previous">&laquo; 이전</a>
		        </li>
		
		        <!-- 페이지 숫자 링크 -->
		        <c:forEach var="i" begin="1" end="${totalPages}">
		            <li class="${currentPage == i ? 'active' : ''}">
		                <a href="?page=${i}">${i}</a>
		            </li>
		        </c:forEach>
		
		        <!-- 다음 페이지로 가는 링크 (마지막 페이지에서는 비활성화) -->
		        <li class="${currentPage == totalPages ? 'disabled' : ''}">
		            <a href="?page=${currentPage + 1}" aria-label="Next">다음 &raquo;</a>
		        </li>
		    </ul>
		</div>
        
        <!-- Modal -->
	    <div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	            <div class="modal-body" id="modalBody">
	                <div class="row">
	                    <div class="col-md-4 d-flex align-items-center justify-content-center">
	                        <!-- 프로필 사진 표시 영역 -->
	                        <img id="emp_photo" src="" alt="프로필 사진" class="img-fluid rounded-circle" style="width: 150px; height: 150px;">
	                    </div>
	                    <div class="col-md-8">
	                        <!-- 사원 정보를 4행 2열 테이블 형식으로 출력 -->
	                        <table class="table table-bordered">
	                            <tr>
	                                <th>사원번호</th>
	                                <td id="emp_id"></td>
	                                <th>이름</th>
	                                <td id="emp_name"></td>
	                            </tr>
	                            <tr>
	                                <th>직급</th>
	                                <td id="emp_position"></td>
	                                <th>직책</th>
	                                <td id="emp_job"></td>
	                            </tr>
	                            <tr>
	                                <th>부서</th>
	                                <td id="emp_dnum"></td>
	                                <th>근무지</th>
	                                <td id="emp_bnum"></td>
	                            </tr>
	                            <tr>
	                                <th>이메일</th>
	                                <td id="emp_email"></td>
	                                <th>연락처</th>
	                                <td id="emp_tel"></td>
	                            </tr>
	                        </table>
	                    </div>
	                </div>
	            </div>
	        </div>
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
        <%@ include file="/resources/assets/inc/footer.jsp" %>
      </div>
      <!-- main-panel -->
    </div>
    <!-- main-wrapper -->
    
    <!--   Core JS Files   -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>
    
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- jQuery Scrollbar -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- Chart JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart.js/chart.min.js"></script>

    <!-- jQuery Sparkline -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

    <!-- Chart Circle -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart-circle/circles.min.js"></script>

    <!-- Datatables -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/datatables/datatables.min.js"></script>

    <!-- Bootstrap Notify -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

    <!-- jQuery Vector Maps -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/world.js"></script>

    <!-- Sweet Alert -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/sweetalert/sweetalert.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/kaiadmin.min.js"></script>

    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/setting-demo.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/demo.js"></script>
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
      
      function showDetail(emp_id) {
    	    $.ajax({
    	        url: '${pageContext.request.contextPath}/member/detail/' + emp_id,
    	        type: 'GET',
    	        dataType: 'json',
    	        success: function(data) {
    	            if (data) {
    	                // 서버에서 받은 데이터를 모달에 출력
    	                $('#emp_photo').attr('src', data.emp_photo || '${pageContext.request.contextPath}/resources/default-profile.jpg'); // 사진이 없을 경우 기본 이미지 설정
    	                $('#emp_id').text(data.emp_id);
    	                $('#emp_name').text(data.emp_name);
    	                $('#emp_position').text(data.emp_position);
    	                $('#emp_job').text(data.emp_job);
    	                $('#emp_dnum').text(data.emp_dnum);
    	                $('#emp_bnum').text(data.emp_bnum);
    	                $('#emp_email').text(data.emp_email);
    	                $('#emp_tel').text(data.emp_tel);

    	                // 모달을 띄우기
    	                $('#detailModal').modal('show');
    	            } else {
    	                alert('데이터를 불러오는데 실패했습니다.');
    	            }
    	        },
    	        error: function(jqXHR, textStatus, errorThrown) {
    	            console.error("AJAX error:", textStatus, errorThrown);
    	        }
    	    });
    	}
      
    </script>
  </body>
</html>
