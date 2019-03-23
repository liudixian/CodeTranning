/*
- 随机在x或y轴上做切线，分割矩形
- 在已知的矩形上继续分割
- 随机的赋予所有矩形以颜色
*/
//方格jason对象
var squares;
//递归次数
var step;
var white = '#F2F5F1';
var colors = ['#D40920', '#1356A2', '#F7D842'];


function setup() {
	var dpr = window.devicePixelRatio;
	createCanvas(320*dpr, 320*dpr);
	squares = [{
		x: 0,
		y: 0,
		w: width,
		h: height
	}];

	step = width / 7;
}

function splitOnY(square, splitAt) {
	var squareA = {
		x: square.x,
		y: square.y,
		w: square.w,
		h: square.h - (square.h - splitAt + square.y)
	};

	var squareB = {
		x: square.x,
		y: splitAt,
		w: square.w,
		H: square.h - splitAt + square.y
	};

	squares.push(squareA); //在数组末尾加上squareA
	squares.push(squareB); //在数组末尾加上squareB

}

function splitOnX(square, splitAt) {
	var squareA = {
		x: square.x,
		y: square.y,
		h: square.h,
		w: square.w - (square.w - splitAt + square.x)
	};

	var squareB = {
		x: splitAt,
		y: square.y,
		h: square.h,
		w: square.w - splitAt + square.x
	};

	squares.push(squareA); //在数组末尾加上squareA
	squares.push(squareB); //在数组末尾加上squareB
}


//切分函数
function splitSquaresWidth(coordinates) {
	// const {		x, y	} = coordinates;
var c = {
	x:0,
	y:0
}
c = coordinates;

	for (var i = squares.length-1 ; i >= 0; i--) {
		var square = squares[i];
		//x
		if (c.x && c.x > square.x && c.x < square.x + square.w) {
			if (random(1) > 0.5) {
				squares.splice(i, 1); //删除一个方格信息
				splitOnX(square, c.x); //在x轴新增分叉点
			}
		}
		//y
		if(c.y && c.y > square.y && c.y < square.y + square.h) {
		// if (random(1) > 0.5) {
			squares.splice(i, 1);
			splitOnY(square, c.y);
		}
	// }
}
}

function run() {
	//随机分配颜色
	for (var i = 0; i < colors.length; i++) {
		squares[floor(random(1)) * squares.length].color = colors[i];
		// squares[i].color = colors[i];
		// print(squares[i].color);
	}
	//绘制
	for (var i = 0; i < squares.length; i++) {
		if (squares[i].color) {
			fill(squares[i].color);
			// fill(colors[i]);

		} else {
			fill(white);
		}
		strokeWeight(8);
		rect(squares[i].x, squares[i].y, squares[i].w, squares[i].h);

	}
}


function draw() {
	for (var i = 0; i < width; i += step) {
		splitSquaresWidth({
			y: i
		});
		splitSquaresWidth({
			x: i
		});
	}
	run();
	// print(squares.length,"color: ",squares.color);
	noLoop();
}
