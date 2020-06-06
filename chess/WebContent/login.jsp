<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv=”Content-Type” content=”text/html; charset=utf-8″>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
<title>中国象棋</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="shortcut icon" href="./img/icon3.png" type="image/x-icon"/>
<script >
function r()
{
var username=document.getElementById("username");
var pass=document.getElementById("s_id");

if(username.value=="")
{
alert("请输入用户名");
username.focus();
return false;
}
if(pass.value=="")
{
alert("请输入学号");
pass.focus();
return false;
}
return true;
}
function register()
{
	window.location="register.jsp";
}
function jump_toadmin()
{
	window.location="adminlogin.jsp";
}
</script>     
</head>
  <body class="loginback">  
       
      


<div class="content">
        <img class="content-logo" src="img/form_logo.png" alt="logo">
        <h1 class="content-title">登录</h1>
        <div class="content-form">
            <form method="post" action="selfinfo.jsp" onsubmit="return r()">
                <div id="change_margin_1">
                    <input class="user" type="text" name="username" id="username" placeholder="请输入用户名" onblur="oBlur_1()" onfocus="oFocus_1()">
                </div>
                <div id="change_margin_2">
                    <input class="password" type="text" name="s_id" id="s_id" placeholder="请输入密码" onblur="oBlur_2()" onfocus="oFocus_2()">
                </div>
                <div id="change_margin_3">
                    <input class="content-form-signup" type="submit" value="登录">
                </div>
                 <div id="change_margin_4">
                    <input class="content-form-signup" type="button" onclick="register()" value="注册">
                </div>
                 <div id="change_margin_5">
                    <input class="content-form-signup" type="button" onclick="jump_toadmin()" value="管理员">
                </div>
            </form>
        </div>
       
    </div>


</body>
</html>