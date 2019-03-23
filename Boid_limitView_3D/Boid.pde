float swt = 20.0;     //sep.mult(25.0f);
float awt = 2.0;      //ali.mult(4.0f);
float cwt = 3.0;      //coh.mult(5.0f);
float maxspeed = 3;
float maxforce = 0.01;
int sepdist = 50;
int cohdist = 50;
int neighborDist = 50;

class Boid {
  PVector loc;
  PVector vel;
  PVector acc;
  //float maxspeed;
  //float maxforce;
  float r;
  float rotateA;
  
  Boid (float x, float y, float z) {
    loc = new PVector(x, y, z);
    vel = new PVector(random(-1,1), random(-1,1), random(-1,1));
    acc = new PVector(0, 0, 0);
    r = 15;
    //maxforce = 0.1;
    //maxspeed = 6;
    rotateA = 0.2;
  }

  void behavior(ArrayList<Boid> boides, PVector target) {
    PVector separateForce = separate(boides);
    //PVector seekForce = seek(target);
    PVector alignForce = align(boides);
    applyForce(separateForce.mult(swt));
    //applyForce(seekForce.mult(0.8));
    applyForce(alignForce.mult(awt));
    applyForce(cohesion(boides).mult(cwt));
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  PVector separate(ArrayList<Boid> bs) {
    float count = 0;
    PVector sumS = new PVector();

    for (Boid b : bs) {
      float d = PVector.dist(loc, b.loc);

      if ((d > 0) && (d < sepdist)) {
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
      return new PVector(0,0,0);
    }
  }

  //聚集
  PVector cohesion(ArrayList<Boid> boides){
      // 计算邻居boid的位置平均值，作为行为的目标
      PVector sum = new PVector();
      int count =0;

      for(Boid other: boides){
          float d = PVector.dist(loc, other.loc);
          if((d >0 ) && (d <cohdist)){
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
    
    rotateA +=0.1;
  }

  // Wraparound
  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }
  
    void borders3D() {
    if (loc.x < -width/2-r) loc.x = width/2+r;
    if (loc.y < -height/2-r) loc.y = height/2+r;
    if (loc.z < -height/2-r) loc.z = height/2+r;
    if (loc.x > width/2+r) loc.x = -width/2-r;
    if (loc.y > height/2+r) loc.y = -height/2-r;
    if (loc.z > height/2+r) loc.z = -height/2-r;
  }

  void display() {
    float c_ = map(vel.mag(), 0, maxspeed, 0, 200);
    push();
    //fill(c_, 100, 100, 120);
    fill(255);
    //strokeWeight(2);
    //stroke(255);
    noStroke();
    translate(loc.x, loc.y, loc.z);
    //float angle  = vel.heading2D();
    //rotate(angle);
    //ellipse(0, 0, r+vel.mag(), r+vel.mag());

    //beginShape();
    //vertex(-r/2,-r/2);
    //vertex(r,0);
    //vertex(-r/2,r/2);
    //endShape(CLOSE);
    rotateX(rotateA);
    rotateY(rotateA);
    box(vel.mag()*3);
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
