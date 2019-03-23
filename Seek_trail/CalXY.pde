class CalXY {
  float x, y;
  float angle =PI*2-PI/2;
  float n;
  boolean mode1;
  int t;
  
  CalXY( ) {
    x = 0;
    y = 0;
    n = height/8;
    mode1 = true;
    t = 0;
  }

  void cal() {
    x = width/2+cos(angle)*n;
    if (mode1) {
      y = height*5/8+sin(angle)*n;
    } else {
      y = height*3/8-sin(angle)*n;
    }
    if (t%400 ==0) {
      mode1 = !mode1;
      println(t);
    }

    angle +=PI/200;
   t++;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
}
