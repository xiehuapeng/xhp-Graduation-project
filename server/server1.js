var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var users = {};
var asock=[];
var roomarray= new Array();
var mvlist= new Array();
for (var sq = 0; sq < 25; sq ++)
{
	roomarray[sq]=0;
}
app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

var count = 0;
var pair = 1;
var logoutname="";
var roomnum;
io.on('connection', function(socket) { 
  console.log('connection: %o', users);
asock.push(socket);
console.log("join");
console.log(asock.length);

  socket.on('disconnect', function() {
    var exitid= socket.id;
	if (users[socket.name]) {
      delete users[socket.name];
    }
	var room_no=exitid.charAt(exitid.length-1);
	roomarray[room_no]=roomarray[room_no]-1;
	var n=asock.indexOf(socket);
	if(n!=-1){
	asock.splice(n,1);
	}
		asock.forEach(s=>{
		if(s!=socket){
			console.log(s.id);
			console.log(socket.id);
			s.emit('logout', { name: exitid });
			console.log('exit');
		}
	});
    
	console.log(asock.length);
  });
  
  
	socket.on('logout_info',function(data){
	 mvlist=data.cdata;
     logoutname=data.name;
	 console.log(logoutname);
	 console.log(mvlist);
	 var room = Object.keys(socket.rooms)[1];
	 console.log(room);
	 roomnum=room.substring(4);
	 console.log(roomnum);
	 //roomarray[roomnum]=roomarray[roomnum]-1;
	});
	
	
  socket.on('joinroom', function(data) {
    var roomNum= 'room' + data;
	var index=parseInt(data);
	if(roomarray[index]<2)
	{
		roomarray[index]=roomarray[index]+1;
		socket.join(roomNum, function () {
			console.log(socket.rooms);
			socket.emit('joinroom',data);
		}); 		
	}
	else
	{
		socket.emit('room_full',data);
	}
	
  });
  
  socket.on('check_exit',function(data){
	socket.id = data.name;
	if(socket.id == logoutname)
	{
		var info={};
		info.exited=1;
		info.flipped=1;
		info.mvlist=mvlist;
		info.roomnum=roomnum;
		socket.emit('check_exit',info);
	}
	else
	{
		var info={};
		info.exited=0;
		info.flipped=1;
		info.mvlist=mvlist;
		info.roomnum=roomnum;
		socket.emit('check_exit',info);
	}
  
  
  });
  socket.on('login', function(data) {
    
	console.log('login: %o', data);
    socket.id = data.name;
    users[data.name] = data;
   
    console.log('login users: %o', users);
	console.log('socket id: %o', socket.id);
	
	var room = Object.keys(socket.rooms)[1]; //这是当前socket的房间
        console.log(room);//打印出房间。
		roomnum=room.substring(4);
		socket.id=data.name+roomnum;
	asock.forEach(s=>{
		if(s!=socket){
		var room1 = Object.keys(s.rooms)[1];
			if(room1 == room)
			{
					console.log(s.id);
					console.log(socket.id);
					s.emit('flip',1);
					s.emit('join', { name : socket.id});	 
			}
		
		console.log('flip');
		}
	});
  
  });
  
  socket.on('move', function(data) {
    asock.forEach(s=>{
		if(s!=socket){
			var room2 = Object.keys(s.rooms)[1];
			var room = Object.keys(socket.rooms)[1];
			if(room2 == room)
			{
					console.log(s.id);
					s.emit('moves', data);
			}
			console.log('moves sent');
		}
	});	
	console.log('move: %o', data);
   
  });
  
  socket.on('increase', function(num) {
    console.log('increase: %s', num);
    io.emit('increase', num + 1);
  });
  
  
    socket.on('retract', function(data) {
    asock.forEach(s=>{
		if(s!=socket){
			var room2 = Object.keys(s.rooms)[1];
			var room = Object.keys(socket.rooms)[1];
			if(room2 == room)
			{
			s.emit('retract',data);
			console.log('retract');
			}
		}
	});		
   
  });

  
});

http.listen(8000, '0.0.0.0');



