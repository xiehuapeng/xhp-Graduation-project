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
   String password = request.getParameter("password");
   
   String usernamebefore = (String)session.getAttribute("username");
   String s_id = (String)session.getAttribute("s_id"); 
   int urank=0;
   String temp="','";
   String sql = "UPDATE usera set upassword ='"+password+"'where uname = '"+usernamebefore+"'";
   //out.println(sql);
	   stmt.execute(sql);
	   out.println(" <h2 style='text-align: center'>修改完成！</h2>");
	   %> 	  
	  <input class="content-form-signup" type="button" onclick="returnselfinfo()" value="返回个人信息页面">
	  <%
   
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
function returnselfinfo()
{
	//out.println("w");
	//console.log(username);
	window.location.href="selfinfo.jsp?username="+'<%=usernamebefore%>'+"&s_id="+<%=password%>;
	//window.location="editselfinfo.jsp";
}
</script>
</body>
</html>
   