class FlowField {
  PVector[][] field;
  int cols, rows;
  int resolution;

  FlowField(int r){
      resolution = width/r;
      cols = width/resolution;
      rows = height/resolution;
      field = new PVector[cols][rows];
      init();
  }

  void init(){
      noiseSeed((int)random(10000));
      float xoff = 0;
      for (int i=0; i <cols; i ++) {
          float yoff=0;
          for (int j=0; j <rows; j++) {
              float theta = map(noise(xoff, yoff),0,1,0,TWO_PI);
              field[i][j] = new PVector(cos(theta), sin(theta));
              yoff += 0.1;
          }
          xoff += 0.1;
      }
  }

  void display(){
      for (int i =1; i < cols; i++){
          for(int j=1; j<rows; j++) {
              drawVector(field[i][j], i*resolution, j*resolution, resolution-2);
          }
      }
  }

  void drawVector(PVector v, float x, float y, float scayl) {
      pushMatrix();
      float arrowsize = 4;
      translate(x,y);
      stroke(0,100);
      rotate(v.heading2D());
      float len = v.mag()*scayl;
      line(0,0,len,0);
      popMatrix();
  }

  PVector lookup(PVector lookup) {
      int column = int(constrain(lookup.x/resolution, 0, cols-1));
      int row = int(constrain(lookup.y/resolution, 0, rows-1));
      return field[column][row].get();
  }
}
