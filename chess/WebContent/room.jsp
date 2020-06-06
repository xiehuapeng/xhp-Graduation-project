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
<title>游戏大厅</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
<div id="container" style="height:100%">

</div>
<%
String username="";
username = session.getAttribute("uname").toString();
%>


  <script src="socket.io/socket.io.js"></script>  
    <script type="text/javascript">
"use strict";

<%-- var socket = io.connect('http://127.0.0.1:8000');//本地环境运行
//var socket = io.connect('http://120.78.158.156:80');//连接远程服务器
var count=0;
socket.on('join', function(data) {
  console.log('new user: %o', data);
  console.log(count++);
});
socket.on('logout', function(data) {
	  console.log('user: %o', data);
	  alert("用户"+data.name+"断开连接");
	});
socket.on('connect', function() {
  socket.emit('login', { name:'<%=username %>' });
});

socket.emit('increase', 0);
socket.on('increase', function(num) {
  console.log('increase: %s', num);
}); --%>

var imgSquares=[];
var container=document.getElementById("container");
for (var sq = 0; sq < 25; sq ++)
	{
	var img = document.createElement("img");
	var style = img.style;
	//style.position = "absolute";
	style.width="100%";
	style.height="100%";
	style.background = "url("+ "images/table3.png) no-repeat ";
	
	style.margin="-1px"
	img.alt="";
	img.border="0";
	style.border="0";
	   img.onmousedown = function clickimg(sq) {
		      return function() {
		    	  window.location.href="index.jsp?operate="+sq;
		    
		      }
		    } (sq);
		    var roomnum=sq+"号房间";
		    var p=document.createElement("P");
		    var style1=p.style;
		    //style1.width="10%";
			//style1.height="20%";
		    var t=document.createTextNode(roomnum);
		    p.appendChild(t);
		    var div=document.createElement("div");
		    var style2=div.style;
		    style2.width="10%";
		    style2.height="20%";
		    div.appendChild(p);
		    div.appendChild(img);
		    //container.appendChild(p);
		    container.appendChild(div);
		    imgSquares.push(img);
	}
</script>


</body>
</html>
   
   