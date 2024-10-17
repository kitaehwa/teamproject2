<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL-core 라이브러리 추가 -->
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
      href="${pageContext.request.contextPath}/resources/assets/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />

    <!-- Fonts and icons -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/webfont/webfont.min.js"></script>
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
          urls: ["${pageContext.request.contextPath}/resources/assets/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/demo.css" />
    
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
        text-align: left;
        margin-left: 62%;
        margin-top: 10px;                     
      }
      
      .info-actions button {
        padding: 8px 15px;  
        border: none;
        border-radius: 4px;
        background-color: #0055FF;
        color: white;
        cursor: pointer;
        float: left;
        margin-left: 5px; 
      }
      
      .info-actions button.delete {
        background-color: #f44336;
      }

      .tabs {
        display: flex;
        border-bottom: 2px solid #ddd;
        margin-bottom: 20px;
        margin-top: 60px;
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
      
      input[readonly] {
        background-color: #f0f0f0;
        color: #333;
      }

      .profile-pic-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 20px;
        width: 110px;
      }

      .profile-pic-container img {
        margin-bottom: 10px;
        max-width: 150px;
        height: auto;
      }

      #uploadProfilePic {
        margin-top: 10px;
      }
      
      .profile-pic-container input[type="file"] {
	    margin-top: 10px;
	    display: block;
	    width: 80%; /* 원하는 너비로 설정 */
	    text-align: center; /* 파일 선택 버튼의 텍스트 가운데 정렬 */
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
            <h1 class="page-title">내정보</h1>
            <div class="info-container">
              <!-- 사진 및 기본 정보 입력 -->
              <form method="post" action="/member/update" id="updateForm" enctype="multipart/form-data">
                <table class="info-table" style="width: 70%;">
                  <tr>
                    <td rowspan="4" style="width: 8%;">
                    <div class="profile-pic-container">
					    <img id="profilePicPreview" src="${memberVO.emp_profile != null ? memberVO.emp_profile : '/resources/assets/img/profile.png'}" alt="증명사진" style="max-width: 150px; height: auto;"/>
						<input type="file" name="emp_profile" id="profilePicInput" accept="image/*">
					</div>
                    
                    
                    </td>
                    <th>사원번호</th>
                    <td><input type="text" name="emp_id" value="${memberVO.emp_id}" readonly/></td>
                    <th>이름</th>
                    <td><input type="text" name="emp_name" value="${memberVO.emp_name}" readonly/></td>
                    <th>성별</th>
                    <td><input type="text" name="emp_gender" value="${memberVO.emp_gender}" readonly/></td>
                  </tr>
                  <tr>
                    <th>생년월일</th>
                    <td><input type="text" name="emp_birth" value="${memberVO.emp_birth}" readonly/></td>
                    <th>주소</th>
                    <td><input type="text" name="emp_addr" value="${memberVO.emp_addr}" /></td>
                    <th>연락처</th>
                    <td><input type="text" name="emp_tel" value="${memberVO.emp_tel}" /></td>                  
                  </tr>
                  <tr>
                    <th>이메일</th>
                    <td><input type="email" name="emp_email" value="${memberVO.emp_email}" /></td>
                    <th>부서</th>
                    <td><input type="text" name="emp_dnum" value="${memberVO.emp_dnum}" readonly/></td>
                    <th>직급/직책</th>
                    <td><input type="text" name="emp_job_id" value="${memberVO.emp_position} / ${memberVO.emp_job}" readonly /></td>                   
                    
                  </tr>
                  <tr>
                    <th>근무형태</th>
                    <td><input type="text" name="emp_work_type" value="${memberVO.emp_work_type}" readonly/></td>                   
                    <th>근무지</th>
                    <td><input type="text" name="emp_bnum" value="${memberVO.emp_bnum}" readonly/></td>                   
                    <th>입사일자</th>
                    <td><input type="text" name="emp_start_date" value="${memberVO.emp_start_date}" readonly/></td>
                  </tr>
                </table>
                
                  <input type="hidden" name="emp_account_num" value="${memberVO.emp_account_num}" />
				  <input type="hidden" name="emp_bank_name" value="${memberVO.emp_bank_name}" />
				  <input type="hidden" name="emp_account_name" value="${memberVO.emp_account_name}" />
				  <input type="hidden" name="emp_position" value="${memberVO.emp_position}" />
				  <input type="hidden" name="emp_status" value="${memberVO.emp_status}" />
				  <input type="hidden" name="emp_job" value="${memberVO.emp_job}" />	                
                
                <button type="button" id="uploadProfilePic" class="btn btn-primary btn-sm mt-2">프로필 사진 등록</button>
                <!-- 버튼 영역 -->              
                <div class="info-actions">               
                  <button type="submit">저장</button>
                  <button type="button" class="delete" onclick="location.href='/member/info'">취소</button>
                </div>
              </form>
                
                <!-- 비밀번호 수정 -->
                <form id="passwordForm" action="" method="get">
				    <input type="hidden" name="emp_id" value="${memberVO.emp_id}" />
				    <table class="info-table" style="width: 70%;">
				        <tr>
				            <th>현재 비밀번호</th>
				            <td><input type="password" name="current_password" required /></td>
				        </tr>
				        <tr>
				            <th>새 비밀번호</th>
				            <td><input type="password" name="new_password" required /></td>
				        </tr>
				        <tr>
				            <th>새 비밀번호 확인</th>
				            <td><input type="password" name="confirm_password" required /></td>
				        </tr>
				    </table>
				    <div class="info-actions">  
				    <button type="submit">비밀번호 변경</button>
				    </div>
				 </form>
                
            </div> 
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
    <script src="${pageContext.request.contextPath}/resources/assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/core/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/core/bootstrap.min.js"></script>

    <!-- jQuery Scrollbar -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- Chart JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/chart.js/chart.min.js"></script>

    <!-- jQuery Sparkline -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

    <!-- Chart Circle -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/chart-circle/circles.min.js"></script>

    <!-- Datatables -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/datatables/datatables.min.js"></script>

    <!-- Bootstrap Notify -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

    <!-- jQuery Vector Maps -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/jsvectormap/world.js"></script>

    <!-- Sweet Alert -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/plugin/sweetalert/sweetalert.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/kaiadmin.min.js"></script>

    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/setting-demo.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/demo.js"></script>
    
    <script>
    $(document).ready(function() {
        let selectedFile = null;

        // 비밀번호 수정
        $('#passwordForm').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: '${pageContext.request.contextPath}/member/updatePassword',
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                if(response.success) {
                    alert(response.message);
                    // 비밀번호 변경 성공 시 추가 작업 (예: 폼 초기화)
                    $('#passwordForm')[0].reset();
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert('서버와의 통신 중 오류가 발생했습니다.');
	            }
	        });
	    });
        
        $('#profilePicInput').change(function(e) {
            selectedFile = e.target.files[0];
            if (selectedFile) {
                let reader = new FileReader();
                reader.onload = function(e) {
                    $('#profilePicPreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(selectedFile);
            }
        });

        $('#uploadProfilePic').click(function() {
            if (!selectedFile) {
                alert('먼저 파일을 선택해주세요.');
                return;
            }

            let formData = new FormData();
            formData.append('emp_profile', selectedFile);
            formData.append('emp_id', $('input[name="emp_id"]').val());

            $.ajax({
                url: '${pageContext.request.contextPath}/member/uploadProfilePicture',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    let result = JSON.parse(response);
                    if (result.success) {
                        alert('증명사진이 성공적으로 업로드되었습니다.');
                        // 업로드 성공 후 필요한 추가 작업
                    } else {
                        alert('사진 업로드에 실패했습니다: ' + result.message);
                    }
                },
                error: function() {
                    alert('서버와의 통신 중 오류가 발생했습니다.');
                }
            });
        });
    });

        $('#updateForm').submit(function(e) {
            e.preventDefault();
            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    if(response.success) {
                        alert('정보가 성공적으로 수정되었습니다.');
                        window.location.href = '${pageContext.request.contextPath}/member/info';
                    } else {
                        alert('정보 수정에 실패했습니다: ' + response.message);
                    }
                },
                error: function() {
                    alert('서버와의 통신 중 오류가 발생했습니다.');
                }
            });
        });
    

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