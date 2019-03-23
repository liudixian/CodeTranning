class Vehicle {
  //变量
  ArrayList<PVector> history = new ArrayList<PVector>();

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  color c;

  Vehicle(float x, float y ) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, -2);
    position = new PVector(x, y);
    r = 6;
    maxspeed = 8;
    maxforce = 0.08;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    //加速度更新、清零
    acceleration.mult(0);
    //历史痕迹
    history.add(position.get());
    if (history.size()>100) {
      history.remove(0);
    }

    colorMode(HSB, 360, 100, 100);
    c = color(map(velocity.x, 0, 4, 226, 360), 100, map(velocity.x, 0, 4, 90, 90));
  }
  //作用力
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  //追逐函数
  void seek(PVector target) {
    //渴望值等于 目标 - 当前位置 = 直线距离
    PVector desired = PVector.sub(target, position);
    desired.normalize();  //化约为 1 以内的小数
    desired.mult(maxspeed);  //转化的max值的比值

    //steer（控制） = desired(渴望）- velocity(速度） 
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);

    applyForce(steer);
  }
  //到达函数
  void arrive(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    float d = desired.mag();
    // Scale with arbitrary damping within 100 pixels计算长短大小，并缩放到100像素以内
    if (d < 100) {
      float m = map(d, 0, 100, 0, maxspeed);
      desired.setMag(m);
    } else {
      desired.setMag(maxspeed);
    }

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }

  void display() {
    beginShape();
    stroke(c);
    strokeWeight(20);
    noFill();

    for (PVector v : history) {
      //stroke(map(sin(radians(angle)), 0, 1, 0, 360), 100, 100);
      vertex(v.x, v.y);
      //ellipse(v.x,v.y,5,5);

    }
    endShape();

    //显示图形
    //float theta = velocity.heading2D() + PI/2;
    fill(c);
    stroke(c);
    strokeWeight(1);
    //noStroke();
    //pushMatrix();
    //translate(position.x,position.y);
    //rotate(theta);
    //shapeBody();
    //endShape();
    //popMatrix();
  }

  void setMaxForce(float m) {
    maxforce = m;
  }

  void setMaxSpeed(float s) {
    maxspeed = s;
  }

  void shapeBody() {
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
  }
}
