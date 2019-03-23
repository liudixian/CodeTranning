int offsetX = 0, offsetY = 0, clickX = 0, clickY = 0;
float rotationX = 0, rotationY = 0, targetRotationX = 0, targetRotationY = 0, clickRotationX, clickRotationY; 
int c=0;
int z = 0;
  boolean d =false;
View3D v3d;

void setup() {
  size(640, 360, P3D);
  v3d = new View3D(width/2, height/2);
}

void draw() {
  background(0);
  //translate(width*0.5, height*0.5, z);
  ////setView();
  //mouseCenter();
  //drawDecareSys();
  //noFill();
  //fill(255,50);
  //stroke(200);
  //box(100);
  
  //z+=0;

  
  v3d.setView(d);
  v3d.display();

}

void mouseDragged(){
  d = true;
}
void mouseReleased(){
d =false;
}

void setView() {

  if (mousePressed) {
    offsetX = mouseX-clickX;
    offsetY = mouseY-clickY;
    targetRotationX = clickRotationX + offsetX/float(width) * TWO_PI;
    targetRotationY = min(max(clickRotationY + offsetY/float(height) * TWO_PI, -HALF_PI), HALF_PI);
    rotationX += (targetRotationX-rotationX)*0.25; 
    rotationY += (targetRotationY-rotationY)*0.25;
  }
  rotateX(-rotationY); 
  rotateY(rotationX);
}

void drawDecareSys() {

  //push();
  //translate(width/2, height/2);
  //x 绿
  stroke(0, 255, 0);
  line(0, 0, 0, 100, 0, 0);
  //红 y
  stroke(255, 0, 0);
  line(0, 0, 0, 0, -100, 0);
  //蓝 z
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 100);
  //pop();
}

//void mouseWheel(MouseEvent event){
//  c = event.getCount();
//    z += c;

//}

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popMatrix();
  popStyle();
}
