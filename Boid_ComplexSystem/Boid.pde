class Boid {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float maxspeed;
  float maxforce;
  int cohdist = 30;
  float alignNBdist = 20;
  float angle =0.0;
  float swt = 25.0;     //sep.mult(25.0f);
  float awt = 1.0;      //ali.mult(4.0f);
  float cwt = 2.0;      //coh.mult(5.0f);

  Boid(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    r = 4;
    maxspeed = 4;
    maxforce = 0.01;
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  void run(ArrayList<Boid> boides) {
    flock(boides);
    update();
    borders();
    renderCell();
  }

  void flock(ArrayList<Boid> boides) {
    PVector sepF = separate(boides);
    PVector cohF = cohesion(boides);
    PVector aliF = align(boides);
    sepF.mult(swt);
    aliF.mult(awt);
    cohF.mult(cwt);
    applyForce(sepF);
    applyForce(cohF);
    applyForce(aliF);
  }

  PVector separate(ArrayList<Boid> boides) {
    PVector steer = new PVector(0, 0);
    float sepDist = 25;
    int count =0;

    for (Boid other : boides) {
      float d = PVector.dist(loc, other.loc);

      if ((d>0) && (d < sepDist)) {
        PVector diff = PVector.sub(loc, other.loc);
        diff.normalize();
        diff.div(d);
        steer.add(diff);
        count ++;
      }
    }

    if (count >0) {
      steer.div((float)count);
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }


  PVector cohesion(ArrayList<Boid> boides) {//跟随群体
    PVector sum = new PVector();
    int count = 0;

    for (Boid other : boides) {
      float d = PVector.dist(loc, other.loc);

      if ((d>0) && (d < cohdist)) {
        sum.add(other.loc);
        count ++;
      }
    }

    if (count >0) {
      sum.div((float)count);

      return seek(sum);
    }
    return sum;
  }

  PVector align(ArrayList<Boid> boides) { //使boid寻找并排队群体
    PVector steer = new PVector();
    int count = 0;

    for (Boid other : boides) {
      float d = PVector.dist(loc, other.loc);
      if ((d > 0) && (d < alignNBdist)) {
        steer.add(other.vel);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  PVector seek(PVector target) {
    PVector desired  = PVector.sub(target, loc);
    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, vel);
    steer.mult(maxforce);
    return steer;
  }


  void renderCell() {

    float theta = vel.heading2D()+radians(90);
    float c_ = map(vel.mag(), 0, maxspeed, 0, 200);
    push();
    fill(c_, 100, 100, c_+100);
    noStroke();
    translate(loc.x, loc.y);
    //beginShape(TRIANGLES);
    //rotate(theta);
    //vertex(0, -r*2);
    //vertex(-r, r/2);
    //vertex(r, r/2);
    //endShape();
    float s = map(vel.mag(), 0, maxspeed, 0, 20);
    ellipse(0, r, s, s);


    //rect(0,0,s,20-s);
    //box(s);
    pop();
  }

  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);

    acc.mult(0);

    angle += vel.mag()/10;
  }

  void borders() {
    if (loc.x < -r) loc.x  = width+ r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }

  void flowField(VecField field) {
    PVector desir = field.lookup(loc);
    desir.mult(maxspeed);

    PVector steer = PVector.sub(desir, vel);
    applyForce(steer);
  }
}
