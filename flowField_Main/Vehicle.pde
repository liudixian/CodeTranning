class Vehicle {
  /*
  @预期位置向量
   @当前向量
   @起始位置-终点向量
   @距离
   */
  PVector acc, vel, loc;
  float r;
  float maxspeed;
  float maxforce;

  Vehicle(PVector l, float ms, float mf) {
    loc = l.get();
    vel = new PVector(0, -2);
    acc = new PVector(0, 0);
    maxspeed = ms;
    maxforce = mf;
    r = 2;
  }

  public void run() {
    update();
    display();
    borders();
  }

  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
  }



  //void follow(Path p, int far) {
  //  //预测未来的位置
  //  PVector predic = vel.get();
  //  predic.normalize();
  //  predic.mult(25);
  //  PVector predicLoc = PVector.add(loc, predic);

  //  //在路径上寻找法线交点"投影点"
  //  PVector a = p.start;
  //  PVector b = p.end;
  //  PVector F = getF(predicLoc, a, b);

  //  //取F点延长线上某点为目标点
  //  PVector dir = PVector.sub(b, a);
  //  dir.normalize();
  //  dir.mult(far);
  //  PVector target = PVector.add(F, dir);

  //  //判断是否脱离路径
  //  float dist = PVector.dist(F, predicLoc);
  //  if (dist > p.r ) {
  //    seek(target);
  //  }
  //}
  //field

  void followField(FlowField flow) {
    PVector desired = flow.lookup(loc);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }

  //计算法线交点函数
  //PVector getF(PVector p, PVector a, PVector b) {
  //  PVector ap = PVector.sub(p, a);
  //  PVector ab = PVector.sub(b, a);

  //  ab.normalize();
  //  ab.mult(ap.dot(ab));
  //  PVector fPoint = PVector.add(a, ab);
  //  return fPoint;
  //}

  void applyForce(PVector force) {
    acc.add(force);
  }


  //追逐函数
  //void seek(PVector target) {
  //  //渴望值等于 目标 - 当前位置 = 直线距离
  //  PVector desired = PVector.sub(target, loc);
  //  desired.normalize();  //化约为 1 以内的小数
  //  desired.mult(maxspeed);  //转化的max值的比值

  //  //steer（控制） = desired(渴望）- velocity(速度） 
  //  PVector steer = PVector.sub(desired, vel);
  //  steer.limit(maxforce);

  //  applyForce(steer);
  //}

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = vel.heading2D() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    beginShape(PConstants.TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }


  //void borders(Path p) {
  //  if (loc.x > p.end.x + r ) {
  //    loc.x = p.start.x - r;
  //    loc.y = p.start.y + (loc.y - p.end.y);
  //  }
  //}

  // Wraparound
  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }
}
