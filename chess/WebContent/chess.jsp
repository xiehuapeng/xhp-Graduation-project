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
<title>已经保存棋组</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>


   <%
   request.setCharacterEncoding("UTF-8");
   Class.forName("com.mysql.cj.jdbc.Driver");

   Connection connect = DriverManager.getConnection(
   "jdbc:mysql://localhost:3306/chess?serverTimezone=GMT%2B8&useSSL=false","root","xhpws123");//登录JDBC链接数据库
   Statement stmt = connect.createStatement();//从数据库里面取东西对比

   String username = "";
   username = session.getAttribute("uname").toString();
   String sql = "select  *  from chess where uname='"+username+"'";
   ResultSet rs = stmt.executeQuery(sql);
   //out.println(sql);
   %>
   <div class="content3">
   <table class="content3" border="1" >
   <tr>
   <th>棋局名</th>
   <th>简介</th>
   </tr>
   <%

   //遍历结果集
   while(rs.next())
   {%>
   <!-- <tr>
   <th>学号:</th>
   <th>姓名:</th>
   <th>住址:</th>
   </tr> -->
   <tr>
   <!-- 输出结果集 -->
   <td><%=rs.getString("cname") %></td>
   <td><%=rs.getString("cintro") %></td>
   <td><input type="button" onclick="jump('<%=rs.getString("cdata") %>')" value="查看"/> </td>
   </tr>
   <%}
   %>

   </table>
   </div>
  <% 
   stmt.close();
    connect.close(); 
 %>
 <script type="text/javascript">
 function jump(data)
 {
	 //console.log(data);
	 //alert(data);
	 window.location.href="seechess.jsp?cdata="+ data;
 }
 
 </script>


</body>
</html>
   
   