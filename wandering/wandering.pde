Vehicle v;

void setup() {
  size(500,500);
  
  v = new Vehicle(width/2, height/2);
}

void draw() {
  background(255);
  
  if(mousePressed && mouseButton == LEFT) {
    v.seek(new PVector(mouseX, mouseY));
  } else {
    v.wander();
  }
  v.update();
  v.display();
}
