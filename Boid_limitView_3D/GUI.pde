void guiSetup() {
  cp5 = new ControlP5(this);
  cp5.addSlider("swt")
    .setRange(0.0, 40.0)
    .setValue(16.40)
    .setPosition(5, 5)
    .setSize(100, 10)
    ;

  cp5.addSlider("cwt")
    .setRange(0.0, 40.0f)
    .setValue(14.50)
    .setPosition(5, 20)
    .setSize(100, 10);

  cp5.addSlider("awt")
    .setRange(0.0, 40.0)
    .setValue(4.4)
    .setPosition(5, 35)
    .setSize(100, 10);

  cp5.addSlider("maxspeed")
    .setRange(0.0, 10.0)
    .setValue(4.2)
    .setPosition(5, 50)
    .setSize(100, 10);

  cp5.addSlider("maxforce")
    .setRange(0.000, 0.1800)
    .setValue(0.02)
    .setPosition(5, 65)
    .setSize(100, 10);

  cp5.addSlider("sepdist")
    .setRange(0, 200)
    .setValue(50)
    .setPosition(5, 80)
    .setSize(100, 10);

  cp5.addSlider("cohdist")
    .setRange(0, 200)
    .setValue(62)
    .setPosition(5, 95)
    .setSize(100, 10);

  cp5.addSlider("neighborDist")
    .setRange(0, 200)
    .setValue(48)
    .setPosition(5, 110)
    .setSize(100, 10);
}

//void slider() {
//  cp5.getController("sep").setValue(swt);
//}
