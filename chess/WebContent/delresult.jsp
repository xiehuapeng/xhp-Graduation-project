<%@ page language="java" import = "java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 <%@include file="form.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<title>注册</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>


   <%
   request.setCharacterEncoding("UTF-8");
   Class.forName("com.mysql.cj.jdbc.Driver");

   Connection connect = DriverManager.getConnection(
		   "jdbc:mysql://localhost:3306/chess?serverTimezone=GMT%2B8&useSSL=false","root","xhpws123");//登录JDBC链接数据库
   Statement stmt = connect.createStatement();//从数据库里面取东西对比
   String username = request.getParameter("name");
   //session.setAttribute("username",username); 
   String adname = (String)session.getAttribute("adminname"); 
   String adpass = (String)session.getAttribute("adminpass"); 

   String s_id = request.getParameter("s_id");
   String uintro="该用户很懒，他还没有留下简介哦";
   int urank=0;
   String temp="','";
   String sql = "delete  from usera where uname='"+username+"'";
   String sql1="delete  from usera where uname='"+username+"'";
   //out.println(sql1);
   try{
	   stmt.execute(sql1);
	   out.println("<h1  style=\"color: #000000\">删除成功！两秒后自动返回</h1>");
	   out.println("");
	   out.println(" <script> setTimeout(\"returnmenu()\",2000);</script>");
	 
   }catch(SQLException e){
	   //out.println(e);
	   out.println("<h1 style=\"color: #000000\">删除失败！</h1>");
	   out.println("");
	   out.println(" <script> setTimeout(\"returnmenu()\",2000);</script>");
   }

   //out.println("删除成功，请返回主界面！");
%>

<input class="content-form-signup" type="button" onclick="returnmenu()" value="返回主界面">
 
<script>
function returnmenu()
{
	
	window.location.href="adminmenu.jsp?username="+'<%=adname%>'+"&s_id="+<%=adpass%>;
	
}
</script>
</body>
</html>
   