void setup() {
  size(1080, 720);
  pixelDensity(2);
}

void draw() {
  background(255);
  strokeWeight(3);
  stroke(154);
  fill(162, 252, 20);
  ellipse(161, 164, 80, 80);

  strokeWeight(10);
  stroke(164);
  fill(255, 240, 0);
  rect(316, 102, 200, 200);

  strokeWeight(15);
  stroke(250,130,1);
  fill(255, 100, 200);
  point(644, 186);

  strokeWeight(8);
  stroke(252,185,245);
  fill(252, 24, 126);
  arc(819, 187, 80, 80, 0, PI+QUARTER_PI, OPEN);
  noFill();
  arc(940, 200, 95, 80, 2.07, 4.834);

  strokeWeight(3);
  stroke(3,7,71);
  fill(255, 100, 200);
  line(241,400,142,500);

  strokeWeight(1);
  stroke(255);
  fill(255, 169, 100);
  quad(332, 366, 485, 390, 464, 497, 357, 495);

  strokeWeight(30);
  stroke(161);
  fill(100, 255, 188);
  triangle(618, 413, 729, 468, 629, 553);
}
