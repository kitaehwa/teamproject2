<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * {
            padding: 0;
            margin: 0;
            border: none;
        }
        body {
            font-size: 14px;
            font-family: 'Roboto', sans-serif;
        }
        .reset-password-wrapper {
            width: 400px;
            height: 350px;
            padding: 40px;
            box-sizing: border-box;
            position: absolute;
            text-align: center;
            margin-left: -200px;
            margin-top: -200px;
            left: 50%;
            top: 40%;
        }
        .reset-password-wrapper > h2 {
            font-size: 24px;
            color: #0055FF;
            margin-bottom: 20px;
        }
        #resetPasswordForm > input {
            width: 100%;
            height: 48px;
            padding: 0 10px;
            box-sizing: border-box;
            margin-bottom: 16px;
            border-radius: 6px;
            background-color: #F8F8F8;
        }
        #resetPasswordForm > input::placeholder {
            color: #D2D2D2;
        }
        #resetPasswordForm > button {
            width: 100%;
            height: 48px;
            color: #fff;
            font-size: 16px;
            background-color: #0055FF;
            margin-top: 20px;
            border-radius: 6px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="reset-password-wrapper">
        <h2>비밀번호 재설정</h2>
        <form id="resetPasswordForm">
            <input type="hidden" id="emp_id" name="emp_id" value="${emp_id}">
            <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
            <button type="button" id="resetPassword">비밀번호 변경</button>
        </form>
    </div>


    <script>
    
    $("#resetPassword").click(function() {
        var newPassword = $("#newPassword").val();
        var confirmPassword = $("#confirmPassword").val();
        var passwordRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&+=])(?=\S+$).{8,}$/;

        if (!passwordRegex.test(newPassword)) {
            alert("비밀번호는 숫자, 영문, 특수문자[!, @, #, $, %, ^, &]를 포함하여 8자리 이상이어야 합니다.");
            return;
        }

        if (newPassword !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            return;
        }

        $.ajax({
            url: "/member/resetPassword",
            type: "POST",
            data: {
                emp_id: $("#emp_id").val(),
                newPassword: newPassword
            },
            dataType: 'json',
            success: function(response) {
                alert(response.message);
                window.location.href = "/member/login";
            },
            error: function(xhr) {
                alert("비밀번호 재설정 중 오류가 발생했습니다: " + xhr.responseJSON.message);
            }
        });
    });
    
    </script>
</body>
</html>