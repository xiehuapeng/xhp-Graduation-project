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
   //session.setAttribute("username",username); 
   String adname = (String)session.getAttribute("adminname"); 
   String adpass = (String)session.getAttribute("adminpass"); 

   String s_id = request.getParameter("s_id");
   String uintro="该用户很懒，他还没有留下简介哦";
   int urank=0;
   String temp="','";
   String sql = "select  *  from usera where uname='"+username+"'"+"and upassword='"+s_id+"'";
   String sql1="insert into usera (uname,uintro,upassword,urank) values('"+username+temp+uintro+temp+s_id+temp+urank+"')";
   //out.println(sql1);
   try{
	   stmt.execute(sql1);
	   out.println("<h1 style=\"color: #000000\">添加成功！可以用添加的账号和密码进行登录啦</h1>");
	   out.println("");
	   //out.println(" <script> setTimeout(\"window.location='login.jsp'\",3000);</script>");
	 
   }catch(SQLException e){
	   //out.println(e);
	   out.println("<h1 style=\"color: #000000\">用户已存在！请重新添加</h1>");
	   out.println("");
	   out.println(" <script> setTimeout(\"returnmenu()\",2000);</script>");
   }
   //out.println(sql1);

   
   
   
%>

<input class="content-form-signup" type="button" onclick="jump_login()" value="去登录">
 
<script>
function returnmenu()
{
	//out.println("w");
	//console.log(username);
	window.location.href="adminmenu.jsp?username="+'<%=adname%>'+"&s_id="+<%=adpass%>;
	//window.location="editselfinfo.jsp";
}
function jump_login()
{
	window.location="login.jsp";
}
</script>
</body>
</html>
   