<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>비밀번호 찾기</h2>
    <form id="forgotPasswordForm">
        <input type="text" id="emp_id" name="emp_id" placeholder="사원번호" required><br>
        <input type="email" id="email" name="email" placeholder="이메일" required><br>
        <button type="button" id="sendVerificationCode">인증코드 전송</button><br>
        <input type="text" id="verificationCode" name="verificationCode" placeholder="인증코드" required><br>
        <button type="button" id="verifyCode">인증코드 확인</button>
    </form>

    <script>
        $("#sendVerificationCode").click(function() {
            $.post("/member/sendVerificationCode", {
                emp_id: $("#emp_id").val(),
                email: $("#email").val()
            }, function(response) {
                alert(response);
            }).fail(function(xhr) {
                alert(xhr.responseText);
            });
        });

        $("#verifyCode").click(function() {
            $.post("/member/verifyCode", {
                emp_id: $("#emp_id").val(),
                verificationCode: $("#verificationCode").val()
            }, function(response) {
                alert(response);
                window.location.href = "/member/resetPassword?emp_id=" + $("#emp_id").val();
            }).fail(function(xhr) {
                alert(xhr.responseText);
            });
        });
    </script>
</body>
</html>