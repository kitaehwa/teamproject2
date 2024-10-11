<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL-core 라이브러리 추가 -->
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
  <head>
  	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
        margin-left: 67%;
        border: none;
        border-radius: 4px;
        background-color: #0055FF;
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
            
			<div class="tabs" style="width: 70%;">
			  <a href="#" class="account">계좌 정보</a>
			  <a href="#" class="license">자격증</a>
			  <a href="#" class="his_edu">교육 이력</a>
			  <a href="#" class="reward">포상/징계</a>
			  <a href="#" class="eval">인사 평가</a>
			</div>            
 
			<div class="tab-content" style="width: 70%;">
				<!-- 탭 클릭 시 정보가 여기에 표시됩니다. -->
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
	<script>
      $(document).ready(function() {
        // 탭 클릭 시 active 클래스를 적용하고 AJAX 요청을 처리하는 로직
        $(".tabs a").click(function(e) {
          e.preventDefault();
          $(".tabs a").removeClass("active");
          $(this).addClass("active");

          const tabType = $(this).attr('class').split(' ')[0];
          let url = '';

          switch (tabType) {
            case 'account':
              url = '/member/account';
              break;
            case 'license':
              url = '/member/license';
              break;
            case 'his_edu':
              url = '/member/his_edu';
              break;
            case 'reward':
              url = '/member/reward';
              break;
            case 'eval':
              url = '/member/eval';
              break;
          }

          // AJAX 요청
          $.ajax({
              url: url,
              type: 'GET',
              data: { emp_id: '${memberVO.emp_id}'},
              success: function(data) {
                console.log(data); // 데이터 구조를 확인
                let content = '';

                if (tabType === 'account') {
                  // assuming data is an object
                  content = '<table class="info-table"><tr><th>예금주</th><td>' + data.emp_account_name + '</td>' +
                            '<th>계좌번호</th><td>' + data.emp_account_num + '</td>' +
                            '<th>은행명</th><td>' + data.emp_bank_name + '</td></tr></table>';
                } else if (tabType === 'license') {
                  // Check if data is an array
                  if (Array.isArray(data)) {
                    content += '<table class="info-table"><tr><th>자격증명</th><th>발급기관</th><th>취득일</th></tr>';
                    data.forEach(function(license) {
                      content += '<tr><td>' + license.li_name + '</td><td>' + license.li_issu + '</td><td>' + license.li_date + '</td></tr>';
                    });
                    content += '</table>';
                  } else {
                    content = '<p>자격증 정보가 없습니다.</p>';
                  }
                } else if (tabType === 'his_edu') {
                  if (Array.isArray(data)) {
                    content += '<table class="info-table"><tr><th>교육명</th><th>강사명</th><th>신청일</th><th>수료일</th><th>수료현황</th></tr>';
                    data.forEach(function(his_edu) {
                      content += '<tr><td>' + his_edu.ename + '</td><td>' + his_edu.teacher + '</td><td>' + his_edu.edate + '</td><td>' + his_edu.end_edate + '</td><td>' + his_edu.estatus + '</td></tr>';
                    });
                    content += '</table>';
                  } else {
                    content = '<p>교육 이력이 없습니다.</p>';
                  }
                } else if (tabType === 'reward') {
                    if (Array.isArray(data)) {
                        content += '<table class="info-table"><tr><th>유형</th><th>이름</th><th>사유</th><th>날짜</th></tr>';
                        data.forEach(function(reward) {
                            // division 값에 따라 표시할 내용을 결정
                            const divisionLabel = reward.division === 'R' ? '포상' : (reward.division === 'P' ? '징계' : reward.division);
                            content += '<tr><td>' + divisionLabel + '</td><td>' + reward.rname + '</td><td>' + reward.reason + '</td><td>' + reward.rdate + '</td></tr>';
                        });
                        content += '</table>';
                    } else {
                        content = '<p>포상/징계 정보가 없습니다.</p>';
                    }
                } else if (tabType === 'eval') {
                  if (Array.isArray(data)) {
                    content += '<table class="info-table"><tr><th>평가명</th><th>기준점수1</th><th>기준점수2</th><th>기준점수3</th><th>종합등급</th><th>피드백</th><th>평가자</th><th>평가일</th></tr>';
                    data.forEach(function(eval) {
                      content += '<tr><td>' + eval.eval_name + '</td><td>' + eval.score1 + '</td><td>' + eval.score2 + '</td><td>' + eval.score3 + '</td><td>' + eval.total + '</td><td>' + eval.feedback + '</td><td>' + eval.valuator + '</td><td>' + eval.eval_date + '</td></tr>';
                    });
                    content += '</table>';
                  } else {
                    content = '<p>인사 평가 정보가 없습니다.</p>';
                  }
                }

                $(".tab-content").html(content);
              },
              error: function(xhr, status, error) {
                console.error("AJAX Error: " + error);
              }
            });
          });
        });
      </script>
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