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
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/orgchart/3.1.1/js/jquery.orgchart.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/orgchart/3.1.1/css/jquery.orgchart.min.css">

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />
    
    <style>
    /* 차트 컨테이너 */
    #chart-container {
        height: 700px;
        border: none; /* 경계 제거 */
        overflow: auto;
        background: #f8f9fa; /* 배경색을 밝게 변경 */
        border-radius: 8px; /* 모서리 둥글게 */
    }
    /* 조직도 기본 스타일 */
    .orgchart {
        background: #fff;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
        border-radius: 8px; /* 모서리 둥글게 */
    }
    /* 노드 스타일 */
    .orgchart .node {
        width: 180px; /* 노드 너비 증가 */
        height: 150px;
        transition: transform 0.3s; /* 호버 시 애니메이션 효과 */
    }
    .orgchart .node:hover {
        transform: scale(1.05); /* 호버 시 확대 효과 */
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15); /* 그림자 변경 */
    }
    /* 노드 제목 스타일 */
    .orgchart .node .title {
        background-color: #007bff; /* 기본 블루색으로 변경 */
        height: 40px;
        color: #fff; /* 제목 텍스트 색상 */
        padding: 10px; /* 여백 추가 */
        font-size: 16px; /* 글꼴 크기 증가 */
        border-top-left-radius: 8px; /* 모서리 둥글게 */
        border-top-right-radius: 8px; /* 모서리 둥글게 */
    }
    /* 노드 내용 스타일 */
    .orgchart .node .content {
        border: 1px solid #007bff; /* 경계 색상 변경 */
        height: 60px;
        padding: 10px; /* 여백 추가 */
        border-bottom-left-radius: 8px; /* 모서리 둥글게 */
        border-bottom-right-radius: 8px; /* 모서리 둥글게 */
        color: #333; /* 텍스트 색상 */
        font-size: 16px; /* 글꼴 크기 증가 */
        font-weight: bold; /* 글자 굵게 */
        text-align: center; /* 가운데 정렬 */
        display: flex; /* 플렉스 박스 사용 */
        align-items: center; /* 세로 가운데 정렬 */
        justify-content: center; /* 가로 가운데 정렬 */
        
    }
    /* 노드 중앙 정렬 */
    .orgchart {
        text-align: center;
        justify-content: center;
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
	
		<h1>조직도</h1>
            <div id="chart-container"></div>
                
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
      
      $(document).ready(function() {
    	    $.get("/member/org/data", function(data) {
    	        console.log("Received data:", data);
    	        $('#chart-container').empty();
    	        if ($.fn.orgchart) {
    	            var oc = $('#chart-container').orgchart({
    	                'data' : data,
    	                'nodeContent': 'name',
    	                'createNode': function($node, data) {
    	                    $node.find('.title').text(data.title);
    	                    $node.find('.content').text(data.name);
    	                }
    	            });
    	        } else {
    	            console.error("OrgChart plugin not loaded");
    	        }
    	    }).fail(function(jqXHR, textStatus, errorThrown) {
    	        console.error("AJAX request failed:", textStatus, errorThrown);
    	    });
    	});

    
      
    </script>
  </body>
</html>
