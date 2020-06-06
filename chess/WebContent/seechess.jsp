<%@ page language="java" import = "java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 <%@include file="form.jsp" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>棋局复盘</title>
    <script type="application/x-javascript" src="js/board_local.js"></script>
	<script type="text/javascript" src="js/position5.js"></script>
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
  
     <div style="text-align:center;font-size:28px;font-family:黑体">棋局复盘</div>
    <div style="height:16px"></div>
    <div style="text-align:center;white-space:nowrap">
      <span class="td" style="margin-right:10px">
        <div id="container"> </div>
      </span>
      <span class="td" style="vertical-align:top;width:120px;">

	
      
	  
      
	  
      
      <div style="padding-top:2px"><input type="button" class="button" value="上一步" onclick="make_lastmove()"></div>
      <div style="padding-top:2px"><input type="button" class="button" value="下一步" onclick="make_nextmove()"></div>
      
     </span> 
    </div>
 
<%
String username="";
username = session.getAttribute("uname").toString();
String room=request.getParameter("operate");
String cdata=request.getParameter("cdata");


%>   

  
    <script type="text/javascript">
    
"use strict";

// 可供选择的开局局面
var STARTUP_FEN = [
  "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKABNR w",
  "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKAB1R w",
  "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/R1BAKAB1R w",
  "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/9/1C5C1/9/RN2K2NR w",
];
var container=document.getElementById("container");
var board = new Board(container, "images/");	// 实例化棋盘对象
board.setSearch(16);							// 设置搜索算法
board.computer = -1;								// 电脑默认执黑
board.busy=true;
console.log(board);
var movelist=new Array();
movelist='<%=cdata%>'.split("-");
//alert(movelist);
var move_num=movelist.length;	
board.computer = -1;
var movecount=1;

function make_lastmove()
{ 
	if(movecount!=1)
	{	
	board.pos.undoMakeMove();
	board.flushBoard();
	console.log(movelist[movecount]);
	console.log(movecount);
	movecount--;
	}
	else
		{
		alert("已经是第一步啦！");
		}
	
	}
function make_nextmove()
{ 
	if(movecount!=move_num-1)
		{
		board.pos.makeMove(movelist[movecount]);
		board.flushBoard();
		console.log(movelist[movecount]);
		console.log(movecount);
		movecount++;
		}
	else
		{
		alert("已经是最后一步啦！");
		}
	
	}
var cname="";
var cintro="";


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

  </body>
</html>