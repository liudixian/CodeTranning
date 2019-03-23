//多短路径跟随
class Paths {
  ArrayList<PVector> points;
  float r;
  
  Paths() {
    r = 2-0;
    points = new ArrayList<PVector>();
    
  }
  
  void addPoint(float x, float y) {
    PVector point = new PVector(x,y);
    points.add(point);
  }
  
  void display(){
    stroke(0);
    noFill();
    beginShape();
      for(PVector v: points) {
        vertex(v.x, v.y);
    }
    endShape();
  }
}
