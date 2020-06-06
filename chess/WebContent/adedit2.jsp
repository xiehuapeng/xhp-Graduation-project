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
function r()
{
var username=document.getElementById("name");
if(username.value=="")
{
alert("请输入用户名");
username.focus();
return false;
}
return true;
}
function editselfinfo()
{
	window.location="editselfinfo.jsp";
}
function printuname()
{
	document.getElementById("name").innerHTML="我的第一个 JavaScript 函数";
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
   session.setAttribute("editname",username); 
   //session.setAttribute("s_id",s_id);
   String sql = "select  *  from usera where uname='"+username+"'";
   ResultSet i = stmt.executeQuery(sql);
   if(i.next()) 
   //String str = i.getString("uname");
   {
	   %>
<div class="content">
        <h1 class="content-title">修改个人信息</h1>
        <div class="content-form">
            <form method="post" action="result.jsp" onsubmit="return r()">
                <div id="change_margin_1">
                    <input class="name" type="text" name="name" id="name" value=<%=i.getString("uname")%> style="width:250px">
                </div>
                <div id="change_margin_2">
                    <textarea class="intro"  name="intro" id="intro" rows="5" cols="25"><%=i.getString("uintro")%></textarea>
                </div>
                <div id="change_margin_3">
                    <input class="content-form-signup" type="submit" value="完成修改">
                </div>
               
            </form>
        </div>
       
    </div>
<%}
   else
   {
      out.println("<h1>查无此人，请回到主界面重新输入姓名和密码!</h1>");
      }%>


</body>
</html>