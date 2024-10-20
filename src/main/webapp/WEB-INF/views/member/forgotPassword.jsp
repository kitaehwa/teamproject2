<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
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
        .forgot-password-wrapper {
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
        .forgot-password-wrapper > h2 {
            font-size: 24px;
            color: #0055FF;
            margin-bottom: 20px;
        }
        #forgotPasswordForm > input {
            width: 100%;
            height: 48px;
            padding: 0 10px;
            box-sizing: border-box;
            margin-bottom: 16px;
            border-radius: 6px;
            background-color: #F8F8F8;
        }
        #forgotPasswordForm > input::placeholder {
            color: #D2D2D2;
        }
        #forgotPasswordForm > button {
            width: 100%;
            height: 48px;
            color: #fff;
            font-size: 16px;
            background-color: #0055FF;
            margin-top: 20px;
            border-radius: 6px;
            cursor: pointer;
        }
        
        #verificationCode{
        	margin-top: 30%;
        }
        
    </style>
</head>
<body>
    <div class="forgot-password-wrapper">
        <h2>비밀번호 찾기</h2>
        <form id="forgotPasswordForm">
            <input type="text" id="emp_id" name="emp_id" placeholder="사원번호" required>
            <input type="email" id="emp_email" name="emp_email" placeholder="이메일" required>
            <button type="button" id="sendVerificationCode">인증코드 전송</button>
            <input type="text" id="verificationCode" name="verificationCode" placeholder="인증코드" required>
            <button type="button" id="verifyCode">인증코드 확인</button>
        </form>
    </div>

    <script>
        $("#sendVerificationCode").click(function() {
            $.post("/member/sendVerificationCode", {
                emp_id: $("#emp_id").val(),
                emp_email: $("#emp_email").val()
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