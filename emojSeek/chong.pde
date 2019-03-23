PImage img;
class Chong {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxspeed;
  float maxforce;
  float lifespan;

  Chong(PVector l) {
    location = l.get();
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    maxspeed = 4;
    maxforce = 0.08;

    img = loadImage("biaoqing.png");
    lifespan = 255;
  }

  void display() {
    //theta:夹角值;
    //heading2D:计算指向夹角
    float theta = velocity.heading2D() + PI/2;
    translate(location.x, location.y);
    rotate(theta);
    //rectMode(CENTER);
    //rect(0,0,10,20);
    imageMode(CENTER);
    tint(255,lifespan);//tint():改变图片的透明度
    image(img, 0, 0, 30, 30);
  }


//seek:寻找target target:目标
  void seek(PVector target) {
    
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity); //desired:渴望
    steer.limit(maxforce);

    applyForce(steer);
  }

//受外力作用函数
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void updata () {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);

    lifespan -= 0.5;
  }
  
 //检查粒子是否死亡
  boolean isDead () {
    if(lifespan>0.0) {
      return false;
    }else {
      return true;
  }
  
  
}

//开关函数
void run() {
    updata();
    display();
    
  }
}