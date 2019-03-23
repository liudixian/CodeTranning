//hemesh
import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

import controlP5.*;


HE_Mesh mesh;
WB_Render render;

ArrayList<Boid> boides ;
int framenum = 1000;
boolean record = false;
;
int count=0;
boolean ifc = false;
MotionBlur blur;

View3D v3d;

boolean showvalues = true;
boolean scrollbar = false;
boolean ifadd = false;



ControlP5 cp5;


void setup() {
  size(800, 800, P3D);
  surface.setResizable(true);
  push();
  guiSetup();
  pop();

  v3d = new View3D(width/2, height/2);


  HEC_Cylinder creator=new HEC_Cylinder();
  creator.setRadius(3, 6); // upper and lower radius. If one is 0, HEC_Cone is called. 
  creator.setHeight(20);
  creator.setFacets(3).setSteps(2);
  creator.setCap(true, true);// cap top, cap bottom?
  //Default axis of the cylinder is (0,1,0). To change this use the HEC_Creator method setZAxis(..).
  creator.setZAxis(0, 1, 1);
  mesh=new HE_Mesh(creator); 
  HET_Diagnosis.validate(mesh);
  render=new WB_Render(this);


  blur = new MotionBlur();
  boides = new ArrayList<Boid>();
  //surface.reSetwindow(true);
  for (int i=0; i <100; i++) {
    //boides.add(new Boid(random(width/2-3,width/2+3), random(height/2-3,height/2+3)));
    boides.add(new Boid(random(-3, 3), random(-3, +3), random(-3, +3)));
  }

  smooth();
}


void draw() {
  background(0);
  String txt = String.format("farmeRate: [%7.2f fps]", frameRate);
  if (keyPressed && !ifadd) {
    ifc  = true;
  } else {
    ifc = false;
    ifadd = true;
  }
  push();
  v3d.setView(ifc);
  v3d.display();
  surface.setTitle(txt);


  noFill();
  stroke(255, 80);
  box(width);
  //fill(255, 200);
  //stroke(255, 200);
  //rect(0, 0, width, height);

  //spotLight(120, 120, 120, width/2, height/2, 300, 0, 0, -1, PI/2, 2);
  spotLight(0, 0, 255, 0, 0, 300, 0, 0, -1, PI/2, 2);
  spotLight(255, 0, 0, 200, 0, 300, 0, 0, -1, PI/2, 2);
  spotLight(0, 0, 255, -200, 0, 300, 0, 0, -1, PI/2, 2);

  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  draw_();


pop();

  //gif
  float percent = ((float)count%framenum)/framenum;
  if (record) {

    saveFrame("./output2/BoidClass_01-"+nf(count, 3)+".png");
  }
  if (record && (count >= framenum)) {
    exit();
  }

  count ++;
  println(boides.size());

  //if(mousePressed && !scrollbar){

  //}

  switch (key) {
  case '1':
    ifadd = true;
    break;
  case '2':
    showvalues = true;
    ifadd = false;
    break;
  }
}

void mouseDragged() {
  if (ifadd)
    boides.add(new Boid(mouseX-width/2, mouseY-height/2, random(-100, 100)));
}

void draw_() {
  for (Boid b : boides) {
    b.behavior(boides, new PVector(mouseX-width/2, mouseY-height/2, 0));
    b.update();
    //b.display();
    push();
    translate(b.loc.x, b.loc.y, b.loc.z);
    float angle  = b.vel.heading2D()+radians(90);
    rotate(angle);
    fill(255);
    stroke(0);
    render.drawEdges(mesh);
    noStroke();
    render.drawFaces(mesh);
    pop();
    //b.borders();
    b.borders3D();
  }
  
    println(cp5.getController("sep")+"  "+swt);

}
