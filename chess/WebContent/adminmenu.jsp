<%@ page language="java" import = "java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 <%@include file="form_admin.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
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
</script> 
<title>个人信息</title>
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
   String s_id = request.getParameter("s_id");
   String sql = "select  *  from admini where aid='"+username+"'"+"and apassword='"+s_id+"'";
   
   ResultSet i = stmt.executeQuery(sql);
   //out.println(sql);
  
   if(i.next())
   {  
	   session.setAttribute("adminname",username); 
	   session.setAttribute("adminpass",s_id); 
	   %>
	<!--    <ul>
	  <li><input class="content-form-signup" type="button" onclick="adsearch()" value="查询用户"></li>
	  <li><input class="content-form-signup" type="button" onclick="adedit()" value="修改用户信息"></li>
	  <li><input class="content-form-signup" type="button" onclick="adadd()" value="新增用户"></li>
	  <li><input class="content-form-signup" type="button" onclick="addelete()" value="删除用户"></li>
	  </ul>
	  </div> -->
	  <%
	 
   }
   else
   {
       //out.println(i.next()+"ff");
	   out.println("<h1 style=\"color: #000000\">管理员不存在，请回到登录界面重新输入姓名和密码!</h1>");
	      out.println(" <script> setTimeout(\"window.location='login.jsp'\",1000);</script>");
   }
   
   
   
%>




</body>
</html>
   
   