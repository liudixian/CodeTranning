class Car
{
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float x;
  float y;
  float maxspeed = 3;

  Car(float x_, float y_) {
    x = x_;
    y = y_;
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    r = 12;
  }

  void run() {
  }


  void update(PVector mouse) {
    mouse.normalize();
    mouse.mult(maxspeed);
    println(loc);
    vel = mouse;

    loc.add(vel);
  }

  void display() {
    //theta = 向量的角
    //theta = 向量的角度
    float theta = vel.heading2D()+radians(90);  //返回一个向量的弧度
    pushMatrix();
    translate(loc.x, loc.y);
    fill(175);
    rotate(theta);
    beginShape();
    vertex(-r, r);
    vertex(r, r);
    vertex(0, -2*r);
    endShape(CLOSE);
    popMatrix();
  }
}
