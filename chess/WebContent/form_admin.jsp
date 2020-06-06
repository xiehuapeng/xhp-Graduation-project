<%@ page language="java" import = "java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="css/style2.css" />
<link rel="shortcut icon" href="./img/icon2.png" type="image/x-icon"/>
<script src='js/fu.js'>

</script>
<script >
function adsearch()
{
	window.location="adsearch.jsp";
}
function adedit()
{
	window.location="adedit.jsp";
}
function adadd()
{
	window.location="adadd.jsp";
}
function addelete()
{
	window.location="addelete.jsp";
}
function exit()
{
	window.location="login.jsp";
}
</script> 
</head>
<body>
<%
String adname = (String)session.getAttribute("adminname"); 
String adpass = (String)session.getAttribute("adminpass"); 
%>


<nav>
  <ul style="float: left" class="main">
    <li style="background-color: #ff0000">
      <a href="#" style="float: left">信息管理</a>
      <ul class="drop menu1"  style="background-color: #ff0000">

        
         <li><input class="content-form-signup" type="button" onclick="adsearch()" value="查询用户"></li>
	  <li><input class="content-form-signup" type="button" onclick="adedit()" value="修改用户信息"></li>
	  <li><input class="content-form-signup" type="button" onclick="adadd()" value="新增用户"></li>
	  <li><input class="content-form-signup" type="button" onclick="addelete()" value="删除用户"></li>
	  
	  
      </ul>
      </li>
      </ul>
      <ul style="float: left" class="main">
      <li style="background-color: #ff0000">
      <a href="#" style="float: left">登录菜单</a>
      <ul class="drop menu2"  style="background-color: #ff0000">
      
      <li><input class="content-form-signup" type="button" onclick="exit()" value="重新登录"></li>
       <li><input class="content-form-signup" type="button" onclick="returnmenu()" value="返回主界面"></li>
      </ul>
      
    </li>
 </ul>
</nav>

 <script type="text/javascript">
 function returnmenu()
 {
 	//out.println("w");
 	//console.log(username);
 	window.location.href="adminmenu.jsp?username="+'<%=adname%>'+"&s_id="+<%=adpass%>;
 	//window.location="editselfinfo.jsp";
 }
 
 </script>







</body>
</html>