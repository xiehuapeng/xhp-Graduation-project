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
   String username = (String)session.getAttribute("adminname"); 
   //session.setAttribute("username",username); 
   String s_id = (String)session.getAttribute("adminpass"); 
   //session.setAttribute("s_id",s_id);
   String sql = "select  *  from usera where uname='"+username+"'"+"and upassword='"+s_id+"'";
   ResultSet i = stmt.executeQuery(sql);
   i.next();
   //String str = i.getString("uname");
   out.println(s_id);
	   %>
<body class="loginback">  
       
      


<div class="content">
        <h1 class="content-title">请输入待查询的用户名,留空以查看用户列表</h1>
        <div class="content-form">
            <form method="post" action="searchresult.jsp">
                <div id="change_margin_1">
                    <input class="name" type="text" name="name" id="name"  style="width:250px">
                </div>
                <div id="change_margin_2">
                    <input class="content-form-signup" type="submit" value="查询">
                </div>
               
            </form>
        </div>
       
    </div>



</body>
</html>