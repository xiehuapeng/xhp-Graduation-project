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
   
   String username="";
   username = session.getAttribute("uname").toString();
   String cname=request.getParameter("c_name");
   out.println(cname);
   String cdata=request.getParameter("c_data");
   String cintro=request.getParameter("c_intro");
   String temp="','";
   String room=request.getParameter("operate");
   String sql="insert into chess (cname,uname,cdata,cintro) values('"+cname+temp+username+temp+cdata+temp+cintro+"')";
   out.println(sql);
   try{
	   stmt.execute(sql);
	   out.println("保存成功！三秒后自动关闭界面");
	   out.println("");
	   out.println(" <script> setTimeout(\"window.close()\",3000);</script>");
	 
   }catch(SQLException e){
	   out.println(e);
	  
   }
   //out.println(sql1);

   
   
   
%>
  <script src="socket.io/socket.io.js"></script>  
    <script type="text/javascript">


</script>
 

</body>
</html>
   
   