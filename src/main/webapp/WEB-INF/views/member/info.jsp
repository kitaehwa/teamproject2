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
        margin-left: 65%;
        border: none;
        border-radius: 4px;
        background-color: #0055FF;
        color: white;
        cursor: pointer;     
      }
      
      .btn-modal {
        padding: 8px 15px;
        margin-left: 91%;
        margin-top: 1%;
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
      
      .profile-pic-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 20px;
        width: 110px;
      }
     
      #addLicenseBtn {
      	padding: 8px 15px;
        margin-top: 1%;
        margin-left: 90%;
        border: none;
        border-radius: 4px;
        background-color: #0055FF;
        color: white;
        cursor: pointer;
      }
      
      .delete-license{
        border: none;
        border-radius: 4px;
        background-color: #f44336;
        color: white;
        cursor: pointer;
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
                  <td colspan="2" rowspan="4" style="width: 8%;">
                  <div class="profile-pic-container">
                    <img src="${memberVO.emp_profile }" alt="증명사진" style="max-width: 150px; height: auto;"/>
                  </td>
                  </div>
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
	    function formatDate(timestamp) {
	        if (!timestamp || isNaN(timestamp)) {
	            return '--';
	        }
	        const date = new Date(timestamp);
	        return date.toISOString().split('T')[0];
	    }

	    function loadTabContent(tabType) {
	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/' + tabType,
	            type: 'GET',
	            data: { emp_id: '${memberVO.emp_id}' },
	            success: function(data) {
	                let content = '';
	                switch (tabType) {
	                    case 'account':
	                        content = generateAccountContent(data);
	                        break;
	                    case 'license':
	                        content = generateLicenseContent(data);
	                        break;
	                    case 'his_edu':
	                        content = generateTableContent(data, ['edu_name', 'edu_teacher', 'edu_status', 'edu_complete_date'], ['교육명', '강사명', '수료현황', '수료일']);
	                        break;
	                    case 'reward':
	                        content = generateTableContent(data, ['division', 'rname', 'reason', 'rdate'], ['유형', '이름', '사유', '날짜']);
	                        break;
	                    case 'eval':
	                        content = generateTableContent(data, ['eval_name', 'score1', 'score2', 'score3', 'total', 'feedback', 'valuator', 'eval_date'], 
	                                                      ['평가명', '기준점수1', '기준점수2', '기준점수3', '종합등급', '피드백', '평가자', '평가일']);
	                        break;
	                }
	                $(".tab-content").html(content);
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: " + error);
	            }
	        });
	    }

	    function generateAccountContent(data) {
	        let content = '<table class="info-table"><tr>' +
	                      '<th>예금주</th><td>' + data.emp_account_name + '</td>' +
	                      '<th>계좌번호</th><td>' + data.emp_account_num + '</td>' +
	                      '<th>은행명</th><td>' + data.emp_bank_name + '</td></tr></table>';
	        content += '<button type="button" class="btn-modal" id="openAccountModal">계좌 수정</button>';
	        return content;
	    }

	    function generateTableContent(data, fields, headers) {
	        if (!Array.isArray(data) || data.length === 0) {
	            return '<p>정보가 없습니다.</p>';
	        }
	        let content = '<table class="info-table"><tr>';
	        headers.forEach(header => content += '<th>' + header + '</th>');
	        content += '</tr>';
	        data.forEach(function(item) {
	            content += '<tr>';
	            fields.forEach(field => {
	                let value = field === 'division' ? (item[field] === 'R' ? '포상' : (item[field] === 'P' ? '징계' : item[field])) :
	                            (field.includes('date') ? formatDate(item[field]) : item[field]);
	                content += '<td>' + value + '</td>';
	            });
	            content += '</tr>';
	        });
	        content += '</table>';
	        return content;
	    }

	    $(".tabs a").click(function(e) {
	        e.preventDefault();
	        $(".tabs a").removeClass("active");
	        $(this).addClass("active");
	        loadTabContent($(this).attr('class').split(' ')[0]);
	    });

	    $(document).on('click', '#openAccountModal', function(e) {
	        e.preventDefault();
	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/account',
	            type: 'GET',
	            data: { emp_id: '${memberVO.emp_id}' },
	            success: function(data) {
	                $('#accountName').val(data.emp_account_name);
	                $('#accountNumber').val(data.emp_account_num);
	                $('#bankName').val(data.emp_bank_name);
	                $('#accountModal').modal('show');
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: " + error);
	            }
	        });
	    });

	    $('#saveAccountBtn').click(function(e) {
	        e.preventDefault();
	        var accountData = {
	            emp_id: '${memberVO.emp_id}',
	            emp_account_name: $('#accountName').val(),
	            emp_account_num: $('#accountNumber').val(),
	            emp_bank_name: $('#bankName').val()
	        };
	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/account/update',
	            type: 'POST',
	            data: JSON.stringify(accountData),
	            contentType: 'application/json',
	            success: function(response) {
	                if (response.success) {
	                    alert('계좌 정보가 수정되었습니다.');
	                    $('#accountModal').modal('hide');
	                    loadTabContent('account');
	                } else {
	                    alert('계좌 수정에 실패했습니다.');
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: " + error);
	            }
	        });
	    });
	    
	    // 자격증 추가
		function generateLicenseContent(data) {
        let content = '<table class="info-table"><tr><th>자격증명</th><th>발급처</th><th>취득일</th><th>작업</th></tr>';
        if (Array.isArray(data) && data.length > 0) {
            data.forEach(function(item) {
                content += '<tr><td>' + item.li_name + '</td><td>' + item.li_issu + '</td><td>' + formatDate(item.li_date) + '</td>';
                content += '<td><button class="delete-license" data-id="' + item.li_id + '">삭제</button></td></tr>';
            });
        } else {
            content += '<tr><td colspan="4">등록된 자격증이 없습니다.</td></tr>';
        }
        content += '</table>';
        content += '<button id="addLicenseBtn">자격증 추가</button>';
        return content;
   		}

		$(document).on('click', '#addLicenseBtn', function() {
	        console.log("Add License button clicked");
	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/licenseList',
	            type: 'GET',
	            dataType: 'json',
	            success: function(data) {
	                console.log("License list received:", data);
	                showAddLicenseModal(data);
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: " + error);
	                alert("자격증 목록을 불러오는데 실패했습니다.");
	            }
	        });
	    });

		function showAddLicenseModal(licenseList) {
	        console.log("Showing add license modal with data:", licenseList);
	        let selectElement = $('#licenseSelect');
	        selectElement.empty().append('<option value="">자격증을 선택하세요</option>');
	        
	        if (Array.isArray(licenseList) && licenseList.length > 0) {
	            licenseList.forEach(function(license) {
	                selectElement.append($('<option>', {
	                    value: license.li_id,
	                    text: license.li_name + ' (' + license.li_issu + ')'
	                }));
	            });
	            console.log("Options added to select:", selectElement.find('option').length);
	        } else {
	            console.warn("License list is empty or not an array");
	            selectElement.append('<option value="">자격증 목록을 불러올 수 없습니다</option>');
	        }

	        $('#licenseDate').val('');
	        $('#licenseModal').modal('show');
		    }
	
			 $('#licenseModal').on('shown.bs.modal', function () {
			        console.log("Modal shown, select options:", $('#licenseSelect option').length);
			    });	
			
		 $(document).on('click', '#saveLicenseBtn', function() {
		     if (!$('#addLicenseForm')[0].checkValidity()) {
		         $('#addLicenseForm')[0].reportValidity();
		         return;
		     }
		
		     let licenseData = {
		         li_id: $('#licenseSelect').val(),
		         li_date: $('#licenseDate').val()
		     };
		     $.ajax({
		         url: '${pageContext.request.contextPath}/member/addLicense',
		         type: 'POST',
		         contentType: 'application/json',
		         data: JSON.stringify(licenseData),
		         success: function(response) {
		             if (response.success) {
		                 alert(response.message);
		                 $('#licenseModal').modal('hide');
		                 loadTabContent('license');
		             } else {
		                 alert(response.message);
		             }
		         },
		         error: function(xhr, status, error) {
		             console.error("AJAX Error: " + error);
		             alert("자격증 추가 중 오류가 발생했습니다.");
		         }
		     });
		 });

	    $(document).on('click', '.delete-license', function() {
	        let licenseId = $(this).data('id');
	        if (confirm('정말로 이 자격증을 삭제하시겠습니까?')) {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/member/deleteLicense/' + licenseId,
	                type: 'DELETE',
	                success: function(response) {
	                    if (response.success) {
	                        alert('자격증이 삭제되었습니다.');
	                        loadTabContent('license');
	                    } else {
	                        alert('자격증 삭제에 실패했습니다: ' + response.message);
	                    }
	                },
	                error: function(xhr, status, error) {
	                    console.error("AJAX Error: " + error);
	                }
	            });
	        }
	    });
	    
	    // 초기 탭 로드
	    loadTabContent('account');
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
    <div class="modal fade" id="accountModal" tabindex="-1" aria-labelledby="accountModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="accountModalLabel">계좌 수정</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form id="accountForm">
	          <div class="mb-3">
	            <label for="accountName" class="form-label">예금주</label>
	            <input type="text" class="form-control" id="accountName" placeholder="예금주를 입력하세요">
	          </div>
	          <div class="mb-3">
	            <label for="accountNumber" class="form-label">계좌번호</label>
	            <input type="text" class="form-control" id="accountNumber" placeholder="계좌번호를 입력하세요">
	          </div>
	          <div class="mb-3">
	            <label for="bankName" class="form-label">은행명</label>
	            <input type="text" class="form-control" id="bankName" placeholder="은행명을 입력하세요">
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" id="saveAccountBtn">저장</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 자격증 추가 모달 -->
	<div class="modal fade" id="licenseModal" tabindex="-1" aria-labelledby="licenseModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header bg-primary text-white">
	        <h5 class="modal-title" id="licenseModalLabel">자격증 추가</h5>
	        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form id="addLicenseForm">
	          <div class="mb-3">
	            <label for="licenseSelect" class="form-label">자격증 선택</label>
	            <select id="licenseSelect" class="form-select" required>
	              <option value="">자격증을 선택하세요</option>
	            </select>
	          </div>
	          <div class="mb-3">
	            <label for="licenseDate" class="form-label">취득일</label>
	            <input type="date" class="form-control" id="licenseDate" required>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" id="saveLicenseBtn">저장</button>
	      </div>
	    </div>
	  </div>
	</div>
	
  </body>
</html>