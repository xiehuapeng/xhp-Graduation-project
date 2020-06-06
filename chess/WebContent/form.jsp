<%@ page language="java" import = "java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="css/style2.css" />
<link rel="shortcut icon" href="./img/icon3.png" type="image/x-icon"/>
<script src='js/fu.js'>

</script>
</head>
<body>
<%
String username1 = (String)session.getAttribute("uname");
String s_id1 = (String)session.getAttribute("s_id"); 
%>


<nav>
  <ul style="float: left" class="main">
    <li style="background-color: #ff0000">
      <a href="#" onclick="return_self()" style="float: left">个人主页</a>
      <ul class="drop menu1"  style="background-color: #ff0000">
        <li><a href="room.jsp">游戏大厅</a></li>
        <li><a href="chess.jsp">已保存棋组</a></li>
        <li><a href="AI3.jsp">人机对战</a></li>
        <li><a href="login.jsp">退出</a></li>
      </ul>
    </li>
 </ul>
</nav>

 
<script type="text/javascript">
function return_self()
{
	window.location.href="selfinfo.jsp?username="+'<%=username1%>'+"&s_id="+<%=s_id1%>;
	}

</script>






</body>
</html>