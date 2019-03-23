Chong chong;
PVector now;
PVector target;
PVector wind;

void setup(){
  now = new PVector(100,100);
  size(500,500);
  chong = new Chong(now);
  wind = new PVector(0.01,0);
  
}

void draw(){
  background(255);
  
 
  target = new PVector(mouseX,mouseY);
  chong.seek(target);
  chong.applyForce(wind);
  chong.run();
   if (chong.isDead()) {
    println("Particle is dead!");
  }
  
}