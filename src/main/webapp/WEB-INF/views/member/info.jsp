<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL-core 라이브러리 추가 -->
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>

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
 
 <!------------------------------------------------------------------------------------------------------------------>
  <style>
  	  .page-title {
	  font-size: 24px;
	  font-weight: bold;
	  margin-bottom: 20px;
}
      .info-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        font-size: 14px;
      }

      .info-table th,
      .info-table td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
      }

      .info-table th {
        background-color: #f4f4f4;
        font-weight: bold;
      }

      .info-table img {
        border-radius: 5px;
        max-width: 150px;
        height: auto;
      }

      .info-actions {
        margin-top: 20px;
        text-align: left; 
      }

      .info-actions button {
        padding: 8px 15px;
        margin-left: 1050px;
        border: none;
        border-radius: 4px;
        background-color: #4caf50;
        color: white;
        cursor: pointer;     
      }

      .info-actions button.delete {
        background-color: #f44336;
      }

      /* 탭 스타일 */
      .tabs {
        display: flex;
        border-bottom: 2px solid #ddd;
        margin-bottom: 20px;
        margin-top: 30px;
      }

      .tabs a {
        padding: 10px 20px;
        text-decoration: none;
        color: #333;
        border: 1px solid #ddd;
        border-bottom: none;
        background-color: #f4f4f4;
        margin-right: 5px;
      }

      .tabs a.active {
        background-color: white;
        font-weight: bold;
      }
    </style>
 <!------------------------------------------------------------------------------------------------------------------>
 
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
 <h1 class="page-title">내정보</h1>
<div class="info-container">
            <!-- 사진 및 기본 정보 -->
              <table class="info-table" style="width: 70%;">
                <tr>
                  <td colspan="2" rowspan="3" style="width: 10%;">
                    <img src="${memberVO.emp_profile}" alt="증명사진" />
                  </td>
                  <th>사원번호</th>
                  <td>${memberVO.emp_id}</td>              
                  <th>이름</th>
                  <td>${memberVO.emp_name}</td>           
                  <th>성별</th>
                  <td>${memberVO.emp_gender}</td>
                </tr>
                <tr>                
        		  <th>생년월일</th>
                  <td>${memberVO.emp_birth}</td>
                  <th>주소</th>
                  <td>${memberVO.emp_addr}</td> 
                  <th>연락처</th>
                  <td>${memberVO.emp_tel}</td>                        
                </tr>
                <tr>
              	  <th>이메일</th>
                  <td>${memberVO.emp_email}</td> 
                  <th>부서</th>
                  <td>${memberVO.emp_dnum}</td>
                  <th>직급/직책</th>
                  <td>${memberVO.emp_position} / ${memberVO.emp_job}</td>                
                </tr>
                <tr>
               	  <td>등록</td>
                  <td>삭제</td>                         
                  <th>근무형태</th>
                  <td>${memberVO.emp_work_type}</td>
                  <th>근무지</th>
                  <td>${memberVO.emp_bnum}</td>               
                  <th>입사일자</th>
                  <td>${memberVO.emp_start_date}</td>
                </tr>                                                    
             </table>     	
            </div>
             
            <!-- 버튼 영역 -->                      
            <div class="info-actions">
              <a href="/member/update"><button>수정</button></a>
            </div>
            
            <!-- 탭 -->
            <div class="tabs">
              <a href="" class="active">계좌정보</a>
              <a href="">자격증</a>
              <a href="">인사발령</a>
              <a href="">포상/징계</a>
              <a href="">인사평가</a>              
            </div>
              
            <div class="info-container">
               	<table class="info-table" style="width: 70%;">
               	<tr>                   	           
                  <th>예금주</th>
                  <td>${memberVO.emp_account_name}</td>
                  <th>계좌번호</th>
                  <td>${memberVO.emp_account_num}</td>
               	  <th>은행명</th>
                  <td>${memberVO.emp_bank_name}</td>
                </tr>               
                </table>                   
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
    </script>
  </body>
</html>