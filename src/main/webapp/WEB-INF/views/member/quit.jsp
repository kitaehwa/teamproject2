<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
	.form-group { margin-bottom: 20px; }
	#quitRules { margin-top: 30px; }
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

<h2>퇴사 신청</h2>
                    <form id="quitForm">
                        <table class="table table-bordered">
                            <tr>
                                <th>사원번호</th>
                                <td><input type="text" class="form-control" id="empId" name="empId" value="${memberVO.emp_id}" readonly></td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td><input type="text" class="form-control" id="empName" name="empName" value="${memberVO.emp_name}" readonly></td>
                            </tr>
                            <tr>
                                <th>부서</th>
                                <td><input type="text" class="form-control" id="empDept" name="empDept" value="${memberVO.emp_dnum}" readonly></td>
                            </tr>
                            <tr>
                                <th>직책</th>
                                <td><input type="text" class="form-control" id="empPosition" name="empPosition" value="${memberVO.emp_job}" readonly></td>
                            </tr>
                            <tr>
                                <th>퇴사희망일</th>
                                <td><input type="date" class="form-control datepicker" id="quitDate" name="quitDate"></td>
                            </tr>
                            <tr>
                                <th>퇴사사유</th>
                                <td>
                                    <select class="form-control" id="quitReason" name="quitReason">
                                        <option value="">선택하세요</option>
                                        <option value="이직">이직</option>
                                        <option value="휴식">휴식</option>
                                        <option value="학업/자기개발">학업/자기개발</option>
                                        <option value="창업/자영업">창업/자영업</option>
                                        <option value="가족/육아">가족/육아</option>
                                        <option value="해외거주/이주">해외거주/이주</option>
                                        <option value="직무불만족">직무불만족</option>
                                        <option value="기타">기타</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>사유상세</th>
                                <td><textarea class="form-control" id="quitReasonDetail" name="quitReasonDetail" rows="5"></textarea></td>
                            </tr>
                        </table>

                        <div id="quitRules">
                            <h4>퇴사 규칙</h4>
                            <ol>
                                <li>퇴사 후 12개월 동안 동종업계 또는 경쟁 회사로의 이직을 금지하며, 위반 시 법적 책임을 질 수 있습니다.</li>
                                <li>퇴사 후에도 회사의 기밀 정보 및 영업 비밀을 외부에 유출하거나 개인적으로 사용하지 않을 것을 동의합니다.</li>
                                <li>회사에서 근무 중에 개발된 모든 지식 재산은 회사의 소유임을 인정하고, 이에 대한 권리를 주장하지 않겠습니다.</li>
                                <li>퇴사 전 모든 업무에 대한 인수인계를 완료하고, 필요한 자료 및 정보를 후임자에게 제공할 것에 동의합니다.</li>
                                <li>회사 소유의 장비 및 자산(노트북, 명함, 업무 관련 자료 등)을 퇴사 전 모두 반환할 것에 동의합니다.</li>
                                <li>퇴사 후에도 회사 및 동료에 대해 비방하지 않으며, 명예를 훼손하는 행동을 하지 않을 것을 동의합니다.</li>
                                <li>퇴사 시 남아있는 미지급금(급여, 퇴직금 등)은 정확히 정산되며 이에 동의합니다.</li>
                                <li>퇴사 후 12개월 동안 회사의 고객, 협력업체, 거래처 등에 접촉하여 사업 제안이나 개인적인 거래를 하지 않겠다는 것에 동의합니다.</li>
                            </ol>
                        </div>

                        <div class="form-group">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="agreeRules" name="agreeRules">
                                <label class="custom-control-label" for="agreeRules">퇴사절차에 동의합니다.</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">제출</button>
                            <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                        </div>
                    </form>
                </div>
            </div>
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
    $('#quitForm').submit(function(e) {
        e.preventDefault();
        if (!$('#agreeRules').is(':checked')) {
            alert('퇴사 규칙에 동의해주세요.');
            return;
        }
        
        var formData = {
            emp_id: $('#empId').val(),
            emp_name: $('#empName').val(),
            emp_dept: $('#empDept').val(),
            emp_position: $('#empPosition').val(),
            quit_date: $('#quitDate').val(),
            quit_reason: $('#quitReason').val(),
            quit_reason_detail: $('#quitReasonDetail').val()
        };

        $.ajax({
            url: '${pageContext.request.contextPath}/quit/submit',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                if (response === 'success') {
                    alert('퇴사 신청이 성공적으로 제출되었습니다.');
                    window.location.href = '${pageContext.request.contextPath}/member/main';
                } else {
                    alert('퇴사 신청 제출에 실패했습니다: ' + response);
                }
            },
            error: function() {
                alert('서버와의 통신 중 오류가 발생했습니다.');
            }
        });
    });
    </script>
    
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
