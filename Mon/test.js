var canvas = document.querySelector('canvas');
var context = canvas.getContext('2d');

var size = window.innerWidth;
var dpr = window.devicePixelRatio;
canvas.width = size * dpr;
canvas.height = size * dpr;
context.scale(dpr, dpr);
context.lineWidth = 8;
var step = size / 6;

var squares = [{
    x: 0,
    y: 0,
    width: size,
    height: size
  }];

function splitSquaresWith(coordinates) {
  const { x, y } = coordinates;

  for (var i = squares.length - 1; i >= 0; i--) {
    const square = squares[i];

    if (x && x > square.x && x < square.x + square.width) {
      squares.splice(i, 1);
      splitOnX(square, x);
    }

    if (y && y > square.y && y < square.y + square.height) {
      squares.splice(i, 1);
      splitOnY(square, y);
    }
  }
}

function splitOnX(square, splitAt) {
  var squareA = {
    x: square.x,
    y: square.y,
    width: square.width - (square.width - splitAt + square.x),
    height: square.height
  };

  var squareB = {
    x: splitAt,
    y: square.y,
    width: square.width - splitAt + square.x,
    height: square.height
  };

  squares.push(squareA);
  squares.push(squareB);
}

function splitOnY(square, splitAt) {
  var squareA = {
    x: square.x,
    y: square.y,
    width: square.width,
    height: square.height - (square.height - splitAt + square.y)
  };

  var squareB = {
    x: square.x,
    y: splitAt,
    width: square.width,
    height: square.height - splitAt + square.y
  };

  squares.push(squareA);
  squares.push(squareB);
}

splitSquaresWith({x: 160})
splitSquaresWith({y: 160})

function draw() {
  for (var i = 0; i < squares.length; i++) {
    context.beginPath();
    context.rect(
      squares[i].x,
      squares[i].y,
      squares[i].width,
      squares[i].height
    );
    context.stroke();
  }
}

draw()
