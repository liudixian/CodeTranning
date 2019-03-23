class Boid {
  PVector loc;
  PVector vel;
  PVector acc;
  float maxspeed;
  float maxforce;
  float r;

  Boid (float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    r = 6;
    maxforce = 0.1;
    maxspeed = 3;
  }

  void behavior(ArrayList<Boid> boides, PVector target) {
    PVector separateForce = separate(boides);
    //PVector seekForce = seek(target);
    PVector alignForce = align(boides);
    applyForce(separateForce.mult(4));
    //applyForce(seekForce.mult(0.8));
    applyForce(alignForce);
    applyForce(cohesion(boides));
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  PVector separate(ArrayList<Boid> bs) {
    float count = 0;
    PVector sumS = new PVector();
    float selfspace = r*3;

    for (Boid b : bs) {
      float d = PVector.dist(loc, b.loc);

      if ((d > 0) && (d < selfspace)) {
        //计算每一个渴望
        PVector everyDesired = PVector.sub(loc, b.loc);
        //单位化
        everyDesired.normalize();
        everyDesired.div(d);
        sumS.add(everyDesired);

        count ++;
      }
    }

    if (count >0 ) {
      sumS.div(count);
      sumS.normalize();
      sumS.mult(maxspeed);
      sumS.sub(vel);
      sumS.limit(maxforce);
    }

    return sumS;
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, loc);
    desired.normalize();
    desired.mult(maxspeed);
    //desired.sub(vel);

    PVector steer = desired.copy().sub(vel);
    steer.limit(maxforce);

    return steer;
  }

  PVector align(ArrayList<Boid> boides) {
    PVector sum = new PVector();
    float neighborDist = 20;
    int count =0;

    for (Boid other : boides) {
      float d = PVector.dist(loc, other.loc);

      if ((d > 0) && (d < neighborDist)) {
        sum.add(other.vel);
        count ++;
      }
    }

    if (count >0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);

      PVector steer = new PVector();
      steer = sum.sub(vel);
      steer.limit(maxforce);

      return steer;
    }else {
      return new PVector(0,0);
    }
  }

  //聚集
  PVector cohesion(ArrayList<Boid> boides){
      // 计算邻居boid的位置平均值，作为行为的目标
      float cohesionDist = 20;
      PVector sum = new PVector();
      int count =0;

      for(Boid other: boides){
          float d = PVector.dist(loc, other.loc);
          if((d >0 ) && (d <cohesionDist)){
              sum.add(other.loc);
              count++;
          }
      }

      if(count >0){
          sum.div(count);

          return seek(sum);
      }else {
          return new PVector(0,0);
      }

  }

  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);

    acc.mult(0);
  }

  // Wraparound
  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }

  void display() {
    float c_ = map(vel.mag(), 0, maxspeed, 0, 200);
    push();
    fill(c_, 100, 100, 120);
    //fill(255);
    //strokeWeight(2);
    //stroke(255);
    noStroke();
    translate(loc.x, loc.y);
    float angle  = vel.heading2D();
    rotate(angle);
    //ellipse(0, 0, r+vel.mag(), r+vel.mag());

    beginShape();
    vertex(-r/2,-r/2);
    vertex(r,0);
    vertex(-r/2,r/2);
    endShape(CLOSE);
    pop();
  }




  void push() {
    pushMatrix();
    pushStyle();
  }

  void pop() {
    popMatrix();
    popStyle();
  }
}
