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
        
        #countdown {
            color: #0055FF;
            font-weight: bold;
            margin-top: 10px;
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
            <div id="countdown"></div>
            <button type="button" id="verifyCode">인증코드 확인</button>
        </form>
    </div>

    <script>
    let countdownTimer;
    // 인증코드 타이머
    function startCountdown(duration, display) {
        let timer = duration, minutes, seconds;
        countdownTimer = setInterval(function () {
            minutes = parseInt(timer / 60, 10);
            seconds = parseInt(timer % 60, 10);

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            display.text(minutes + ":" + seconds);

            if (--timer < 0) {
                clearInterval(countdownTimer);
                display.text("시간 만료");
                $("#verifyCode").prop('disabled', true);
            }
        }, 1000);
    }
    
    $("#sendVerificationCode").click(function() {
        $.ajax({
            url: "/member/sendVerificationCode",
            type: "POST",
            data: {
                emp_id: $("#emp_id").val(),
                emp_email: $("#emp_email").val()
            },
            dataType: 'json',
            success: function(response) {
                alert(response.message);
                $("#verificationCode").show();
                $("#verifyCode").show();
                $("#countdown").show();
                
                // 카운트다운 시작
                clearInterval(countdownTimer);
                let tenMinutes = 60 * 10,
                    display = $('#countdown');
                startCountdown(tenMinutes, display);
                
                $("#verifyCode").prop('disabled', false);
            },
            error: function(xhr) {
                alert(xhr.responseJSON.message);
            }
        });
    });

    $("#verifyCode").click(function() {
        $.ajax({
            url: "/member/verifyCode",
            type: "POST",
            data: {
                emp_id: $("#emp_id").val(),
                verificationCode: $("#verificationCode").val()
            },
            dataType: 'json',
            success: function(response) {
                alert(response.message);
                if (response.success) {
                    window.location.href = "/member/resetPassword?emp_id=" + $("#emp_id").val();
                }
            },
            error: function(xhr) {
                alert("오류가 발생했습니다. 다시 시도해 주세요.");
            }
        });
    });
        
   		// 초기에 인증코드 입력칸과 확인 버튼 숨기기
        $("#verificationCode").hide();
        $("#verifyCode").hide();
        $("#countdown").hide();
        
    </script>
    
    
</body>
</html>