"use strict";

var MINMAXDEPTH = 3;	// 极大极小搜索深度

function Search(pos) {
  this.pos = pos;
}

Search.prototype.searchMain = function() {
  this.mvResult = 0; 	// 搜索出的走法
  this.maxMinSearch();	// 极大极小搜索算法

  return this.mvResult;	// 返回搜索结果
}

// 极大极小搜索
Search.prototype.maxMinSearch = function() {
  if (this.pos.sdPlayer == 0) {
    // 红方走棋，极大点搜索
	this.maxSearch(MINMAXDEPTH);
  } else {
    // 黑方走棋，极小点搜索
    this.minSearch(MINMAXDEPTH);
  }
}

// 极大点搜索
Search.prototype.maxSearch = function(depth) {
  if (depth == 0) {
    return this.pos.evaluate();
  }
  
  var vlBest = -MATE_VALUE;				// 初始最优值为负无穷
  var mvs = this.pos.generateMoves();	// 生成当前局面的所有走法
  var mv = 0;
  var value = 0;
  for (var i = 0; i < mvs.length; i ++) {
    mv = mvs[i];
	
	if (!this.pos.makeMove(mv)) {
     
	  continue;
    }
	
	// 极小点搜索算法
	value = this.minSearch(depth - 1);
	this.pos.undoMakeMove();

	if (value > vlBest) { 
	  vlBest = value;
	  if (depth == MINMAXDEPTH) {
	    this.mvResult = mv;
	  }
	}	
  }
  
  return vlBest;	// 返回当前节点的最优值
}

// 极小点搜索
Search.prototype.minSearch = function(depth) {
  if (depth == 0) {
    return this.pos.evaluate();
  }
  
  var vlBest = MATE_VALUE;				// 初始最优值为正无穷
  var mvs = this.pos.generateMoves();
  var mv = 0;
  var value = 0;
  for (var i = 0; i < mvs.length; i ++) {
    mv = mvs[i];
	if (!this.pos.makeMove(mv)) {
      continue;
    }
	value = this.maxSearch(depth - 1);	
	this.pos.undoMakeMove();
	
	if (value < vlBest) {				
	  vlBest = value;
	  if (depth == MINMAXDEPTH) {
	    this.mvResult = mv;
	  }
	}
  }
  
  return vlBest;	// 返回当前节点的最优值
}