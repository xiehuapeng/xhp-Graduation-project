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
   String username = request.getParameter("username");
   session.setAttribute("username",username); 
   
   String s_id = request.getParameter("s_id");
   String uintro="该用户很懒，他还没有留下简介哦";
   int urank=0;
   String temp="','";
   String sql = "select  *  from usera where uname='"+username+"'"+"and upassword='"+s_id+"'";
   String sql1="insert into usera (uname,uintro,upassword,urank) values('"+username+temp+uintro+temp+s_id+temp+urank+"')";
   //out.println(sql1);
   try{
	   stmt.execute(sql1);
	   out.println("<h1 style=\"color: #000000\">注册成功！可以用注册的账号和密码进行登录啦</h1>");
	   out.println("");
	   out.println(" <script> setTimeout(\"window.location='login.jsp'\",1500);</script>");
	 
   }catch(SQLException e){
	   //out.println(e);
	   out.println("<h1 style=\"color: #000000\">用户名已被占用！请更换用户名</h1>");
	   out.println(" <script> setTimeout(\"window.location='login.jsp'\",1000);</script>");
   }
   //out.println(sql1);

   
   
   
%>




</body>
</html>
   