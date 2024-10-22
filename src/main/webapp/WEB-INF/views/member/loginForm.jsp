<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<style>

*{
    padding: 0;
    margin: 0;
    border: none;
}
body{
    font-size: 14px;
    font-family: 'Roboto', sans-serif;
}

.login-wrapper{
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

.login-wrapper > h2{
    font-size: 24px;
    color: #0055FF;
    margin-bottom: 20px;
}
#login-form > input{
    width: 100%;
    height: 48px;
    padding: 0 10px;
    box-sizing: border-box;
    margin-bottom: 16px;
    border-radius: 6px;
    background-color: #F8F8F8;
}
#login-form > input::placeholder{
    color: #D2D2D2;
}
#login-form > input[type="submit"]{
    color: #fff;
    font-size: 16px;
    background-color: #0055FF;
    margin-top: 20px;
}

#login-form > input[type="checkbox"]{
    display: none;
}
#login-form > label{
    color: #999999;
    float: left;
}
#login-form input[type="checkbox"] + label{
    cursor: pointer;
    padding-left: 26px;
    background-image: url("checkbox.png");
    background-repeat: no-repeat;
    background-size: contain;
}
#login-form input[type="checkbox"]:checked + label{
    background-image: url("checkbox-active.png");
    background-repeat: no-repeat;
    background-size: contain;  
}

.login-wrapper {
    text-align: center;
} 

</style>

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>

<script type="text/javascript">
     $(function() {        
           fnInit();         
     });
     
     function frm_check(){
         saveid();
     }
 
    function fnInit(){
        var cookieid = getCookie("saveid");
        console.log(cookieid);
        if(cookieid !=""){
            $("input:checkbox[id='saveId']").prop("checked", true);
            $('#logId').val(cookieid);
        }       
    }    
 
    function setCookie(name, value, expiredays) {
        var todayDate = new Date();
        todayDate.setTime(todayDate.getTime() + 0);
        if(todayDate > expiredays){
            document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expiredays + ";";
        }else if(todayDate < expiredays){
            todayDate.setDate(todayDate.getDate() + expiredays);
            document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
        }            
        console.log(document.cookie);
    }
 
    function getCookie(Name) {
        var search = Name + "=";
        console.log("search : " + search);
        
        if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면 
            offset = document.cookie.indexOf(search);
            console.log("offset : " + offset);
            if (offset != -1) { // 쿠키가 존재하면 
                offset += search.length;
                // set index of beginning of value
                end = document.cookie.indexOf(";", offset);
                console.log("end : " + end);
                // 쿠키 값의 마지막 위치 인덱스 번호 설정 
                if (end == -1)
                    end = document.cookie.length;
                console.log("end위치  : " + end);              
                return unescape(document.cookie.substring(offset, end));
            }
        }
        return "";
    }
 
    function saveid() {
        var expdate = new Date();
        if ($("#saveId").is(":checked")){
            expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30);
            setCookie("saveid", $("#logId").val(), expdate);
            }else{
           expdate.setTime(expdate.getTime() - 1000 * 3600 * 24 * 30);
            setCookie("saveid", $("#logId").val(), expdate);           
        }
    }
    
</script>

	<c:if test="${not empty loginError}">
	    <script type="text/javascript">
	        alert("${loginError}");
	    </script>
	</c:if>

	<div class="login-wrapper">
		<h2>login</h2>
			<form method="post" id="login-form" onsubmit="return frm_check();"> <!-- action 속성이 없을 때 자신의 주소를 호출  -->
				<input type="text" name="emp_id" id="logId" placeholder="사원번호"><br>
				<input type="password" name="emp_pw" placeholder="비밀번호"><br>
				<label for="remember-check">
                <input type="checkbox" class="save_id" name="checkId" id="saveId"> 사원번호 저장</label>	
				<input type="submit" value="로그인">
                <a href="/member/forgotPassword">비밀번호를 잊으셨나요?</a>
         	</form>  		   
	</div>	

