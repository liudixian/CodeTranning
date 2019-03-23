Flock flockBoids;
int initP = 100;
int framenum = 500;
boolean record = false;
int count=0;
  
void setup() {
  //size(640, 360,P3D);
  size(640, 360);
  pixelDensity(2);
  flockBoids = new Flock();
  surface.setResizable(true);
  for (int i =0; i < initP; i ++) {
    flockBoids.add(new Boid(width/2+random(5),height/2+random(5)));
    //flockBoids.add(new Boid(width/2,height/2));
  }
  smooth();
}


void draw() {
  background(255);
  //fill(255,20);
  //rect(0,0,width,height);
  String txt = String.format("frameRate: [%6.1f fps]",frameRate);
  surface.setTitle(txt);
  
    
//pointLight(255,100,100,0,0,600);
//pointLight(100,100,255,0,0,-600);
    //spotLight(120,120,120,width/2,height/2,300,0,0,-1,PI/2,2);

  flockBoids.run();
  
  if (mousePressed) {
    flockBoids.add(new Boid(mouseX, mouseY));
  }
  
  if(record){
    saveFrame("./output/boid_"+nf(count, 3)+".png");
    if(count >= framenum){
    exit();
  }
    count ++;
  }
}

void push() {

  pushMatrix();
  pushStyle();
}

void pop() {
  popMatrix();
  popStyle();
}
