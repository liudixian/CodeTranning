Car c;

void setup() {
  size(640, 360);

  c = new Car(width/2, height/2);
}

void draw() {
  background(255);
  PVector mouse = new PVector(mouseX-width/2, mouseY-height/2);
  c.update(mouse);
  c.display();
}
