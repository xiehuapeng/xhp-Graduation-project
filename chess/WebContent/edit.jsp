<%@ page language="java" import = "java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 <%@include file="form.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">

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
   
   String usernamebefore = (String)session.getAttribute("uname");
   session.setAttribute("uname",username); 
   //String s_id = (String)session.getAttribute("s_id"); 
   String intro = request.getParameter("intro");
   String uintro="该用户很懒，他还没有留下简介哦";
   session.setAttribute("username",username); 
   //out.println("username");
   //out.println("usernamebefore");
   //out.println("intro");
   int urank=0;
   String temp="','";
   String sql = "UPDATE usera set uintro ='"+intro+"'where uname = '"+usernamebefore+"'";
   String sql1 = "UPDATE usera set uname = '"+username+"'where uname = '"+usernamebefore+"'";
   String sql2 = "select  *  from usera where uname='"+username+"'";
   //out.println(sql);
   //out.println(sql1);
   ResultSet i = stmt.executeQuery(sql2);
   i.next();
   if(i.next())
   {
   		out.println("该用户名已被使用，请重新选择！");//   out.println("注册成功！可以用注册的账号和密码进行登录啦");
   }
   else
   {
	   stmt.execute(sql);
	   stmt.execute(sql1);
	   ResultSet i2 = stmt.executeQuery(sql2);
	   i2.next();
	   out.println("修改完成！");
	   out.println(" <h2 style='text-align: center'>您的个人信息如下</h2>");
	   %>
	   <div class="content3">
	   <table class="content3" border="1" ><tr>
	  <td>用户名</td>
	  <td>等级</td>
	  <td>个人简介</td>
	  </tr>
	  
	<tr>
	  <td><%=i2.getString("uname")%></td>
	  <td><%=i2.getString("urank")%></td>
	  <td><%=i2.getString("uintro")%></td>
	  </tr>
	  	  
	  <!-- <input class="content-form-signup" type="button" onclick="returnselfinfo()" value="返回个人信息页面"> -->
	  <%
   }
	//   out.println("");
	//   out.println(" <script> setTimeout(\"window.location='login.jsp'\",3000);</script>");

  //out.println(sql1);
 // ResultSet i = stmt.executeQuery(sql);
  // if(i.next())
  // {  
	   
	//   out.println(" <h2 style='text-align: center'>注册成功</h2>");
	   %>
	 
	  </table>
	  </div>
	  <%
	 
 //  }
//   else
 //  {
       //out.println(i.next()+"ff");
 //     out.println("<h1>查无此人，请回到登录界面重新输入姓名和密码!</h1>");
  // }  
   
   
%>



<script>
<%-- function returnselfinfo()
{
	//out.println("w");
	//console.log(username);
	window.location.href="selfinfo.jsp?username="+'<%=username%>'+"&s_id="+<%=s_id%>;
	//window.location="editselfinfo.jsp";
} --%>
</script>
</body>
</html>
   