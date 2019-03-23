import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Mondrian_JAVA extends PApplet {

ArrayList<JSONObject> squares; //<>// //<>// //<>//
JSONObject square;
String[] colors = {"FFD40920", "FF1356A2", "FFF7D842", "FF000000" };
int step;
int level= 12;
int weight = 12;
String white = "FFF2F5F1";
public void setup() {
  
  //新建第一个方块
  squares = new ArrayList<JSONObject>();
  square = new JSONObject();

  square.setInt("x", 0);
  square.setInt("y", 0);
  square.setInt("w", width);
  square.setInt("h", height);

  squares.add(square);

  //
  step = PApplet.parseInt(width/level);
}

public void draw() {

  //background(255);
  strokeWeight(weight);
  for (int i =0; i < width; i += step) {
    squareSplitWith(new PVector(i, 0));
    squareSplitWith(new PVector(0, i));
  }

  for (int i =0; i < squares.size(); i ++) {
    if (random(1)>0.8f) {
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
public void squareSplitWith(PVector coordinate) {
  int x = floor(coordinate.x);
  int y = floor(coordinate.y);

  for (int i = squares.size()-1; i >=0; i --) {
    JSONObject sqs = squares.get(i);
    //检测该方块是否被分割过
    if ( x > sqs.getInt("x")  && x < sqs.getInt("x")+sqs.getInt("w")) {
      if (random(1.0f)>0.5f) {
        squares.remove(i);
        splitOnX(sqs, x);
      }
    }

    if ( y > sqs.getInt("y")  && y < sqs.getInt("y")+sqs.getInt("h")) {
      if (random(1.0f)>0.5f) {
        squares.remove(i);
        splitOnY(sqs, y);
      }
    }
  }
}

public void splitOnX(JSONObject sq, int splitAT) {
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

public void splitOnY(JSONObject sq, int splitAT) {
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

public void mousePressed() {
  //squares.remove(squares.size()-1);
  redraw();
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

//void keyPressed(){
//  if(key == '1'){
//    level =8;
//  }
//}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Mondrian_JAVA" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
