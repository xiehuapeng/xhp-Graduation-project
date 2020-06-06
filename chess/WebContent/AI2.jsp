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
    <title>中国象棋AI对战</title>
    <script type="application/x-javascript" src="js/board4.js"></script>
	<script type="text/javascript" src="js/position.js"></script>
	<script type="text/javascript" src="js/search4.js"></script>
	
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

	    <div class="label">谁先走</div>
      <div><select id="selMoveMode" size="3">
        <option selected value="0">我先走</option>
        <option value="1">电脑先走</option>
      </select></div>
      
	  <div class="label">先走让子</div>
      <div><select id="selHandicap" style="padding:0px">
        <option selected value="0">不让子</option>
        <option value="1">让左马</option>
        <option value="2">让双马</option>
        <option value="3">让九子</option>
      </select>
      </div>
      <div class="label">AI难度等级</div>
      <div><select id="selHard" style="padding:0px" onchange="hard_change()">
        <option value="1">低级</option>
        <option selected value="2" >中级</option>
        <option  value="3" >高级</option>
       
      </select>
      </div>
      
	  <div style="padding-top:2px"><input type="button" class="button" value="开始" onclick="restart_click()"></div>
      <div style="padding-top:2px"><input type="button" class="button" value="悔棋" onclick="retract_click()"></div>
      <div style="padding-top:2px"><input type="button" class="button" value="保存" onclick="save_array()"></div>
     </span> 
    </div>
   
  <script src="socket.io/socket.io.js"></script>  
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
board.computer = 1;								// 电脑默认执黑

// 开始
function restart_click() {
  board.computer = 1 - selMoveMode.selectedIndex;			// 根据用户选择，决定电脑执黑还是执红
  board.restart(STARTUP_FEN[selHandicap.selectedIndex]);	// 使用用户选择的开局局面，初始化棋局
  board.setSearch(selHard);
}

// 悔棋
function retract_click() {
  board.retract();
}

function hard_change()
{
	var objS = document.getElementById("selHard");
    var hard = objS.options[objS.selectedIndex].value;
    var url="AI"+hard+".jsp";
    window.location.href=url;
}

var cname="";
var cintro="";
function save_array() {
	  //socket.emit('save',board.pos.mvList);
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
	 window.open (url, 'newwindow', 'left=410,height=610, width=860, top=200,  toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	 var tb1=document.getElementById("chess");
	  if(tb1.style.display=='none') tb1.style.display='block';
	  else tb1.style.display='none';
	
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
   
   