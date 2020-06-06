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
<script >
function editselfinfo()
{
	window.location="editselfinfo.jsp";
}
function editpassword()
{
	window.location="editpassword.jsp";
}
</script> 
<title>个人信息</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="shortcut icon" href="./img/icon3.png" type="image/x-icon"/>
</head>
<body>


   <%
   request.setCharacterEncoding("UTF-8");
   Class.forName("com.mysql.cj.jdbc.Driver");

   Connection connect = DriverManager.getConnection(
   "jdbc:mysql://localhost:3306/chess?serverTimezone=GMT%2B8&useSSL=false","root","xhpws123");//登录JDBC链接数据库
   Statement stmt = connect.createStatement();//从数据库里面取东西对比
   String username = request.getParameter("username");
   session.setAttribute("uname",username); 
   
   String s_id = request.getParameter("s_id");
   session.setAttribute("s_id",s_id);
   String sql = "select  *  from usera where uname='"+username+"'"+"and upassword='"+s_id+"'";
   ResultSet i = stmt.executeQuery(sql);
   //out.println(sql);
  
   if(i.next())
   {  
	   
	   out.println(" <h2 style='text-align: center'>您的个人信息如下</h2>");
	   %>
	   <div class="content3">
	   <table class="content3" border="1" ><tr>
	  <td>用户名</td>
	  <td>等级</td>
	  <td>个人简介</td>
	  </tr>
	  
	  <tr>
	  <td><%=i.getString("uname")%></td>
	  <td><%=i.getString("urank")%></td>
	  <td><%=i.getString("uintro")%></td>
	  </tr>
	  	  
	  </table>
	  <input class="content-form-signup" type="button" onclick="editselfinfo()" value="修改个人信息">
	    <input class="content-form-signup" type="button" onclick="editpassword()" value="修改密码">
	  </div>
	  <%
	 
   }
   else
   {
       //out.println(i.next()+"ff");
      out.println("<h1 style=\"color: #000000\">用户名或密码错误，请重新输入姓名和密码!</h1>");
      out.println(" <script> setTimeout(\"window.location='login.jsp'\",1000);</script>");
   }
   
   
   
%>



</body>
</html>
   
   