<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
</body>
</html>