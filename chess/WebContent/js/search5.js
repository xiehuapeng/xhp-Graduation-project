"use strict";

// 希尔排序
var SHELL_STEP = [0, 1, 4, 13, 40, 121, 364, 1093];
function shellSort(mvs, vls) {
  var stepLevel = 1;
  while (SHELL_STEP[stepLevel] < mvs.length) {
    stepLevel ++;
  }
  stepLevel --;
  while (stepLevel > 0) {
    var step = SHELL_STEP[stepLevel];
    for (var i = step; i < mvs.length; i ++) {
      var mvBest = mvs[i];
      var vlBest = vls[i];
      var j = i - step;
      while (j >= 0 && vlBest > vls[j]) {
        mvs[j + step] = mvs[j];
        vls[j + step] = vls[j];
        j -= step;
      }
      mvs[j + step] = mvBest;
      vls[j + step] = vlBest;
    }
    stepLevel --;
  }
}

// 对走法排序
function MoveSort(pos, historyTable) {
  this.mvs = [];										// 走法数组，存储当前局面所有走法
  this.vls = [];										// 在历史表中，每个走法对应的分值
  this.pos = pos;
  this.historyTable = historyTable;
  this.index = 0;

  var mvsAll = pos.generateMoves();						// 生成全部走法
  for (var i = 0; i < mvsAll.length; i ++) {
    var mv = mvsAll[i]
    if (!pos.makeMove(mv)) {
      continue;
    }
    pos.undoMakeMove();
    this.mvs.push(mv);

    this.vls.push(historyTable[pos.historyIndex(mv)]);	// 获取历史表中，该走法的值
  }
    shellSort(this.mvs, this.vls);						// 根据历史表的分值，对走法进行排序
}

// 获得一步排序后的走法。如果走法已经全部获取，则返回0
MoveSort.prototype.next = function() {
  while (this.index < this.mvs.length) {
   var mv = this.mvs[this.index];
   this.index ++;
   return mv;
 }
  return 0;
}

var MINMAXDEPTH = 4;	// 极大极小搜索的深度
var LIMIT_DEPTH = 64;	// 最大搜索深度

function Search(pos) {
  this.pos = pos;
}

// 更新历史表
Search.prototype.setBestMove = function(mv, depth) {
  this.historyTable[this.pos.historyIndex(mv)] += depth * depth;
}


Search.prototype.searchMain = function(depth, millis) {
  this.historyTable = [];
  for (var i = 0; i < 4096; i ++) {
    this.historyTable.push(0);
  }
  
  this.mvResult = 0; 			
  this.pos.distance = 0;		
  var t = new Date().getTime();	

 // 迭代加深搜索
 for (var i = 1; i <= depth; i ++) {
   var vl = this.alphaBetaSearch(-MATE_VALUE, MATE_VALUE, i);
    this.allMillis = new Date().getTime() - t;	
    if (this.allMillis > millis) {				
      break;
    }
    if (vl > WIN_VALUE || vl < -WIN_VALUE) {	
      break;
    }
 }

  return this.mvResult;
}

// 超出边界的Alpha-Beta搜索
Search.prototype.alphaBetaSearch = function(vlAlpha_, vlBeta, depth) {
  var vlAlpha = vlAlpha_;	
  
  if (depth == 0) {
    return this.pos.evaluate();
  }
  var vlBest = -MATE_VALUE;	
  var mvBest = 0;			
  var sort = new MoveSort(this.pos, this.historyTable);
  var mv = 0;
  var vl = 0;
  while ((mv = sort.next()) > 0) {
	if (!this.pos.makeMove(mv)) {
	  continue;
    }
	vl = -this.alphaBetaSearch(-vlBeta, -vlAlpha, depth - 1);	
	this.pos.undoMakeMove();
    if (vl > vlBest) {		// 找到最佳值
      vlBest = vl;			
      if (vl >= vlBeta) {	
        mvBest = mv;		
        break;				
      }
      if (vl > vlAlpha) {	
        vlAlpha = vl;		
        mvBest = mv;		
		if (this.pos.distance == 0) {	
	      this.mvResult = mv;
	    }
      }
    }	
  }
  
  if (vlBest == -MATE_VALUE) {
    
    return this.pos.mateValue();
  }
  if (mvBest > 0) {
   
    this.setBestMove(mvBest, depth);
  }

  return vlBest;
}
