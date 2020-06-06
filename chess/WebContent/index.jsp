<%@ page language="java" import = "java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 <%@include file="form.jsp" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf8">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>中国象棋</title>
    <script type="application/x-javascript" src="js/board_online.js"></script>
	<script type="text/javascript" src="js/position.js"></script>
	<script type="text/javascript" src="js/search5.js"></script>
	
    <style type="text/css"><!--

span.td {
  display: inline-block;
}

div.label {
  font-size: 14px;
  padding:2px;
}

select {
  font-size: 14px;
  width: 108px;
  padding:2px;
}

option {
  font-size: 14px;
}

input.button {
  font-size: 14px;
  width: 108px;
}

label {
  font-size: 14px;
}
    --></style>
     <link rel="stylesheet" type="text/css" href="css/style.css" />
  </head>
  <body>
  
     <div style="text-align:center;font-size:28px;font-family:黑体">中国象棋</div>
    <div style="height:16px"></div>
    <div style="text-align:center;white-space:nowrap">
      <span class="td" style="margin-right:10px">
        <div id="container"> </div>
      </span>
      <span class="td" style="vertical-align:top;width:120px;">

	    <!-- <div class="label">谁先走</div>
      <div><select id="selMoveMode" size="3">
        <option    value="0">我先走</option>
        <option value="1">电脑先走</option>
        <option selected value="2">不用电脑</option>
      </select></div>
      
	  <div class="label">先走让子</div>
      <div><select id="selHandicap" style="padding:0px">
        <option selected value="0">不让子</option>
        <option value="1">让左马</option>
        <option value="2">让双马</option>
        <option value="3">让九子</option>
      </select>
      </div> -->
      
	  
      <div style="padding-top:2px"><input type="button" class="button" value="悔棋" onclick="retract_click()"></div>
      <div style="padding-top:2px"><input type="button" class="button" value="保存" onclick="save_array()"></div>
     
      
     </span> 
    </div>
 
<%
String username="";
username = session.getAttribute("uname").toString();
String room=request.getParameter("operate");
%>   

  <script src="socket.io/socket.io.js"></script>  
    <script type="text/javascript">
    function str2utf8(str) {
        encoder = new TextEncoder('utf8');
        return encoder.encode(str);
    }
"use strict";
var socket = io.connect('http://127.0.0.1:8000');//本地环境运行
//var socket = io.connect('http://120.78.158.156:80');//连接远程服务器
//var socket1 = io.connect('http://192.168.1.14:30003');
var socket1 = io.connect('192.168.1.14:30003');
console.log(socket1)
var send_data1 = 'def svt():    movej(p[-0.18,-0.14,0.38,3.19,-0.01,0.02],a=0.5, v=0.5, t=0, r=0) end';
var send_data2 = 'def svt():\n    movej(p[-0.20,-0.14,0.38,3.19,-0.01,0.02],a=0.5, v=0.5, t=0, r=0)\n\n\nend\n';
var send_data3 = 'movej(p[-0.20,-0.14,0.38,3.19,-0.01,0.02],a=0.5, v=0.5, t=0, r=0)\n';
socket1.emit('send_data',send_data3);
console.log(send_data2);
//alert(send_data2);
var count=0;
var rival_name="";
socket.on('join', function(data) {
  console.log('new user: %o', data);
  alert("用户"+data.name+"加入房间!");
  rival_name=data.name;
  //console.log(count++);
});

socket.on('logout', function(data) {
	  console.log('user: %o', data);
	  if(data.name == rival_name)
	  alert("用户"+data.name+"断开连接");
	  var logout_info={};
	  logout_info.name=data.name;
	  logout_info.cdata=board.pos.mvList;
	  socket.emit('logout_info',logout_info);
	});

socket.on('connect', function() {
    
	socket.emit('joinroom',<%=room %>);
    
});

socket.on('joinroom', function(data) {
	
    socket.emit('login', { name:'<%=username %>' });
});

var movelist=new Array();
socket.on('check_exit',function(data){
	if(data.exited ==1)
		{
		alert("恢复中断前棋局！");
		socket.emit('joinroom',data.roomnum);
		
		console.log(data.mvlist);
		var len=data.mvlist.length-1;
		for(var i=1;i<len;i++)
			{
			board.pos.makeMove(data.mvlist[i]);
			
			board.flushBoard();		
			}
		}
	else
		{
		socket.emit('joinroom',<%=room %>);
	    socket.emit('login', { name:'<%=username %>' })
		}
	
});
socket.emit('increase', 0);
socket.on('increase', function(num) {
  console.log('increase: %s', num);
});

socket.on('room_full', function(data) {
	  console.log('increase: %s', data);
	  alert(data+"号房间已满");
	  window.location.href="room.jsp";
	});
	
	
	
// 可供选择的开局局面
var STARTUP_FEN = [
  "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKABNR w",
  "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKAB1R w",
  "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/R1BAKAB1R w",
  "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/9/1C5C1/9/RN2K2NR w",
];
var container=document.getElementById("container");
var board = new Board(container, "images/");	// 实例化棋盘对象
//board.setSearch(16);							// 设置搜索算法
board.computer = -1;								// 翻转后默认执黑

socket.on('flip', function(data) {
	 board.computer=0;
	 board.restart1(STARTUP_FEN[0]);
	 board.search = null;

	});

socket.on('moves', function(data) {
    console.log('nextmove: %o', data);
    var sq1_=data;
  //alert(sq1_); 
  board.clickSquare(sq1_);
  //alert(sq1_);
    
  });

socket.on('retract', function(data) {
	board.retract();
	});
	
board.computer = -1;


var cname="";
var cintro="";
function save_array() {
	 
	  var tb1=document.getElementById("chess");
	  if(tb1.style.display=='none') tb1.style.display='block';
	  else tb1.style.display='none';
	   
	}
	function save()
	{
		 cname=document.getElementById("c_name");
		 cintro=document.getElementById("c_intro");
		 
		 if(c_name.value=="")
		   {
		   alert("请输入棋局名");
		   c_name.focus();
		   return false;
		   }
		 if(c_intro.value=="")
		   {
		   alert("请输入简介");
		   c_name.focus();
		   return false;
		   }
		 var url="savechess.jsp?c_name="+cname.value+"&c_data="+board.pos.mvList.join("-")+"&c_intro="+cintro.value;
		 window.open (url, 'newwindow', 'left=410,height=610, width=860, top=200,  toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no')
		
	}
// 重新开始
function restart_click() {
  board.computer = 1 - selMoveMode.selectedIndex;			// 根据用户选择，决定电脑执黑还是执红
  board.setSearch(16);
  board.restart(STARTUP_FEN[selHandicap.selectedIndex]);	// 使用用户选择的开局局面，初始化棋局
}

// 悔棋
function retract_click() {
  board.retract();
  socket.emit('retract',1);
}

    </script>
    <form id="chess" name="form1" action="savechess.jsp"  method="post" onsubmit="return check()" style="display:none" class="content2">
<table  class="content2" border="1">
<tr align=center><td>棋局名</td><td><input type="text" name="c_name" id="c_name"></td></tr>
<tr align=center><td>棋局简介</td><td><input type="text" name="c_intro" id="c_intro"></td></tr>
<tr align=center><td colspan="2"><input type="button" onclick="save()" value="保存棋局"/>     <input type="reset" value="重 置"/></td></tr>
</table>
</form>
  </body>
</html>