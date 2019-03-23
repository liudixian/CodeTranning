FlowField f;
Path p;
Vehicle v1, v2;
Paths ps;
ArrayList<Vehicle> vs;
int frameNum = 100;
int counter = 0;
boolean record = false;

void setup() {
  size(400, 571);
  f = new FlowField(20);
  p = new Path(10);
  v1 = new Vehicle(new PVector(0, height/2), 2, 0.02);
  v2 = new Vehicle(new PVector(0, height/2), 3, 0.05);
  ps = new Paths();
  vs = new ArrayList<Vehicle>();

  for (int i =0; i < 120; i ++) {
    vs.add(new Vehicle(new PVector(random(width), random(height)), random(1, 5), random(0.05, 0.4)));
  }
  
    for(int i =0; i <5; i ++){
    ps.addPoint(random(width), random(height));
  }
}

void draw() {
  background(255);
  f.display(); 

  //ps.display();
  //p.display();
  //v1.follow(p,10);
  //v2.follow(p,10);

  //v1.run();
  //v2.run();
  //v1.borders();
  //v2.borders();

  for (Vehicle v : vs) {
    v.followField(f);
    v.run();
  }
  
  if(counter <= frameNum && record){
    saveFrame("./output/floawField_01-"+nf(counter,3)+".png");
    println(((float)counter%frameNum)/frameNum);
  }else if(((float)counter%frameNum)/frameNum==1){
    exit();
  }
  
  counter ++;
}

void mousePressed() {
  f.init();
}
