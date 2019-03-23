class Path {
  PVector start;
  PVector end;

  float r;

  Path(int w ) {
    r = w;

    start = new PVector(40, height/3);
    end = new PVector(width-40, 2*height/3);
  }

  void display() {
    strokeWeight(r*2);
    stroke(0,100);
    line(start.x, start.y, end.x, end.y);
    strokeWeight(1);
    stroke(0);
    line(start.x, start.y, end.x, end.y);
  }
}
