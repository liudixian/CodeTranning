class View3D
{
  float x, y;
  float zoff;
  float c;
  
  View3D (float x_, float y_) {
    x = x_;
    y = y_;
  }

  void setView(boolean dragged) {
    translate(x, y, zoff);
    if(dragged){
    mouseCenter();
    }
  }
  void display() {
    stroke(0, 255, 0);
    line(0, 0, 0, 100, 0, 0);
    //红 y
    stroke(255, 0, 0);
    line(0, 0, 0, 0, -100, 0);
    //蓝 z
    stroke(0, 0, 255);
    line(0, 0, 0, 0, 0, 100);

    fill(255, 50);
    stroke(255, 150);
    box(100);

    c+=0;
  }

  void mouseWheel(MouseEvent event) {
    c = event.getCount();
    zoff +=c;
  }

  void mouseCenter() {
    float angleX = map(mouseX-width/2, -width/2, width/2, -PI, PI);
    float angleY = map(mouseY-height/2, -height/2, height/2, PI, -PI);
    rotateX(angleY);
    println(angleY +" "+(mouseY-height/2));
    rotateY(angleX);
  }
}
