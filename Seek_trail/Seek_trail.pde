/*
  字体：
 - Arial-Bold
 - Arial-Black
 */
Vehicle v, v2;
CalXY c;
float t1, t2;
PFont Arial, song, Arial_black;
String words = "PROCESING\nStudy\n2019\nNature of Code";

void setup() {
  size(600, 857, P2D);
  pixelDensity(2);
  v = new Vehicle(width/2, height/2);
  v2 = new Vehicle(random(width), random(height));
  c = new CalXY();

  t1=0;
  t2 = 1000;

  Arial = loadFont("Arial-BoldMT-48.vlw");
  song = loadFont("AdobeSongStd-Light-180.vlw");
  Arial_black = loadFont("Arial-Black-140.vlw");
}

void draw() {
  colorMode(HSB, 360, 100, 100);
  color c_ = color(226, 100, 77);
  fill(c_, 180);
  stroke(0, 180);
  rect(0, 0, width, height);
  
  //background(c_,30);
  c.cal();

  //background(c_);
  //PVector mouse = new PVector(map(noise(t1), 0, 1, 0, width), map(noise(t2), 0, 1, 0, width));
  PVector mouse = new PVector(c.getX(), c.getY());
  stroke(0);
  strokeWeight(2);
  if (keyPressed)
    ellipse(c.getX(), c.getY(), 48, 48);
  t1+= 0.012;
  t2-= 0.01;
  v.seek(mouse);
  //v.arrive(mouse);
  v.update();
  v.display();
  v2.seek(mouse);
  v2.update();
  v2.display();

  fontDis();
  
}


void fontDis() {
  //textFont(Arial);
  textFont(Arial_black);
  textSize(75);
  //textMode(SHAPE);
  fill(0);
  text(words, 30, 72);
}

void keyPressed() {
  words= words+key;
  if (key == 8) {
    words = "";
  }

  if (key =='s') saveFrame();
}
