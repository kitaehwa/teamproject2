<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>비밀번호 재설정</h2>
    <form id="resetPasswordForm">
        <input type="hidden" id="emp_id" name="emp_id" value="${emp_id}">
        <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required><br>
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required><br>
        <button type="button" id="resetPassword">비밀번호 변경</button>
    </form>

    <script>
        $("#resetPassword").click(function() {
            if ($("#newPassword").val() !== $("#confirmPassword").val()) {
                alert("비밀번호가 일치하지 않습니다.");
                return;
            }

            $.post("/member/resetPassword", {
                emp_id: $("#emp_id").val(),
                newPassword: $("#newPassword").val()
            }, function(response) {
                alert(response);
                window.location.href = "/member/login";
            }).fail(function(xhr) {
                alert(xhr.responseText);
            });
        });
    </script>
</body>
</html>