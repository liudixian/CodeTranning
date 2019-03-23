ArrayList<JSONObject> squares;  //<>//
JSONObject square;
String[] colors = {"FFD40920", "FF1356A2", "FFF7D842", "FF000000" };
int step;
int level= 12;
int weight = 12;
String white = "FFF2F5F1";
void setup() {
  size(600, 600);
  //新建第一个方块
  squares = new ArrayList<JSONObject>();
  square = new JSONObject();

  square.setInt("x", 0);
  square.setInt("y", 0);
  square.setInt("w", width);
  square.setInt("h", height);

  squares.add(square);
  frameRate(6);
  //
}

void draw() {
  //background(255);
  step = int(width/level);
  level = floor(map(mouseX, 0, width, 4, 30));
  //background(255);
  strokeWeight(weight*7/level);
  for (int i =0; i < width; i += step) {
    squareSplitWith(new PVector(i, 0));
    squareSplitWith(new PVector(0, i));
  }

  for (int i =0; i < squares.size(); i ++) {
    if (random(1)>0.8) {
      fill(unhex(colors[floor(random(4))]));
    } else {
      fill(unhex(white));
    }
    rect(squares.get(i).getInt("x"),
      squares.get(i).getInt("y"),
      squares.get(i).getInt("w"),
      squares.get(i).getInt("h")
      );
  }
  //println(squares.size());
  noLoop();
}

//分割方格
void squareSplitWith(PVector coordinate) {
  int x = floor(coordinate.x);
  int y = floor(coordinate.y);

  for (int i = squares.size()-1; i >=0; i --) {
    JSONObject sqs = squares.get(i);
    //检测该方块是否被分割过
    if ( x > sqs.getInt("x")  && x < sqs.getInt("x")+sqs.getInt("w")) {
      if (random(1.0)>0.5) {
        squares.remove(i);
        splitOnX(sqs, x);
      }
    }

    if ( y > sqs.getInt("y")  && y < sqs.getInt("y")+sqs.getInt("h")) {
      if (random(1.0)>0.5) {
        squares.remove(i);
        splitOnY(sqs, y);
      }
    }
  }
}

void splitOnX(JSONObject sq, int splitAT) {
  int x = sq.getInt("x");
  int y = sq.getInt("y");
  int w = sq.getInt("w");
  int h = sq.getInt("h");

  JSONObject sqA = new JSONObject();
  sqA.setInt("x", x);
  sqA.setInt("y", y);
  sqA.setInt("w", w-(w-splitAT+x));
  sqA.setInt("h", h);

  JSONObject sqB = new JSONObject();
  sqB.setInt("x", splitAT);
  sqB.setInt("y", y);
  sqB.setInt("w", w - splitAT+x);
  sqB.setInt("h", h);

  squares.add(sqA);
  squares.add(sqB);
}

void splitOnY(JSONObject sq, int splitAT) {
  int x = sq.getInt("x");
  int y = sq.getInt("y");
  int w = sq.getInt("w");
  int h = sq.getInt("h");

  JSONObject sqA = new JSONObject();
  sqA.setInt("x", x);
  sqA.setInt("y", y);
  sqA.setInt("w", w);
  sqA.setInt("h", h-(h-splitAT+y));

  JSONObject sqB = new JSONObject();
  sqB.setInt("x", x);
  sqB.setInt("y", splitAT);
  sqB.setInt("w", w);
  sqB.setInt("h", h - splitAT+y);

  squares.add(sqA);
  squares.add(sqB);
}

void mousePressed() {
  //squares.remove(squares.size()-1);
  redraw();
  reSet();
}

//void mouseMoved() {
//  redraw();
//  reSet();
//}

void reSet() {
  ////////////////////////------必须清零集合------////////////////////
  squares.clear();   //保证每次重启时集合内方形只有一个
  ////////////////////////------必须清零集合------////////////////////

  square = new JSONObject();

  square.setInt("x", 0);
  square.setInt("y", 0);
  square.setInt("w", width);
  square.setInt("h", height);

  squares.add(square);
  println(squares, squares.size());
}
