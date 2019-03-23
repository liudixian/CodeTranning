class MotionBlur {
  int[][] result;
  int samplesPerframe;


  MotionBlur () {
    result = new int[width*height][3];
    samplesPerframe = 3;
  }


  void load() {
    for (int i=0; i <width*height; i++) {
      for (int a = 0; a <3; a ++)
        result[i][a] = 0;
    }

    for (int sa=0; sa <= samplesPerframe; sa ++) {


      draw_();
      
      loadPixels();

      for (int i =0; i <pixels.length; i++) {
        result[i][0] += pixels[i] >> 16 & 0xff;   //r
        result[i][1] += pixels[i] >> 8 & 0xff;    //g
        result[i][2] += pixels[i] & 0xff;          //b
      }
    }
  }

  void update() {
    loadPixels();
    //二进制运算 将 rgb还原为比特数组
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 |
        int(result[i][0]*1.0/samplesPerframe) << 16 |
        int(result[i][1]*1.0/samplesPerframe) << 8 |
        int(result[i][2]*1.0/samplesPerframe);
    //上传所有储存的像素
    updatePixels();
  }
}
