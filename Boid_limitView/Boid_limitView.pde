ArrayList<Boid> boides ;
int framenum = 500;
boolean record = true;
int count=0;

MotionBlur blur;

void setup() {
  size(640, 360, P2D);

  blur = new MotionBlur();
  boides = new ArrayList<Boid>();
  //surface.reSetwindow(true);
  for (int i=0; i <100; i++) {
    boides.add(new Boid(random(width/2-3,width/2+3), random(height/2-3,height/2+3)));
  }
}


void draw() {
  String txt = String.format("farmeRate: [%7.2f fps]", frameRate);
  surface.setTitle(txt);

  background(0);
  //fill(255, 200);
  //stroke(255, 200);
  //rect(0, 0, width, height);
  
  //spotLight(120,120,120,width/2,height/2,300,0,0,-1,PI/2,2);
  draw_();




  //gif
  float percent = ((float)count%framenum)/framenum;
  if (record) {

    saveFrame("./output2/BoidClass_01-"+nf(count, 3)+".png");
  }
  if (count >= framenum) {
    //exit();
  }

  count ++;
  println(percent);
}

void mouseDragged() {
  boides.add(new Boid(mouseX, mouseY));
}

void draw_(){
  for (Boid b : boides) {
    b.behavior(boides, new PVector(mouseX, mouseY));
    b.update();
    b.display();
    b.borders();
  }
}
