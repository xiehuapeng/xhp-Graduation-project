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
</head>
<body>


   <%
   request.setCharacterEncoding("UTF-8");
   Class.forName("com.mysql.cj.jdbc.Driver");

   Connection connect = DriverManager.getConnection(
		   "jdbc:mysql://localhost:3306/chess?serverTimezone=GMT%2B8&useSSL=false","root","xhpws123");//登录JDBC链接数据库	   
   Statement stmt = connect.createStatement();//从数据库里面取东西对比
   String username = request.getParameter("name");
   /* String adname = (String)session.getAttribute("adminname"); 
   String adpass = (String)session.getAttribute("adminpass");  */
   String sql = "select  *  from usera where uname='"+username+"'";
   if(username == "")
   {
	   sql = "select  *  from usera";
   }
   ResultSet i = stmt.executeQuery(sql);
   //out.println(sql);
   if(i.next())
   {
	   out.println(" <h2 style='text-align: center'>查询用户的信息如下</h2>");
	   %>
	   <div class="content3">
	   <table class="content3" border="1" ><tr>
	  <td>用户名</td>
	  <td>等级</td>
	  <td>个人简介</td>
	  </tr>
	  <% 
   do
   {  
	   
	   %>
	  
	  <tr>
	  <td><%=i.getString("uname")%></td>
	  <td><%=i.getString("urank")%></td>
	  <td><%=i.getString("uintro")%></td>
	  </tr>
	  	  
	  
	  <%
	 
   }
   while(i.next());
	  %>
	  </table>
	  </div>
	  <%
   }
   else
   {
       //out.println(i.next()+"ff");
      //out.println("<h1>查无此人，请回到登录界面重新输入姓名!</h1>");
      out.println("<h1 style=\"color: #000000\">查无此人!两秒后自动跳转至菜单界面</h1>");
      out.println(" <script> setTimeout(\"returnmenu()\",2000);</script>");
   }
   
   
   
%>

	<!-- <input class="content-form-signup" type="button" onclick="returnmenu()" value="返回主界面"> -->
 
<script>
function returnmenu()
{
	//out.println("w");
	//console.log(username);
	window.location.href="adminmenu.jsp?username="+'<%=adname%>'+"&s_id="+<%=adpass%>;
	//window.location="editselfinfo.jsp";
}
</script>
</body>
</html>
   
   