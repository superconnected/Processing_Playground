class Ball {
  PVector position;
  PVector velocity;
  float size;
  
  Ball(PVector position, PVector velocity, float size) {
    this.position = position.get();
    this.velocity = velocity.get();
    this.size = size;
  }
  
  void display() {
    fill(0);
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0, 0, size, size);
    popMatrix();
  }
  
  void move() {
    position.set(getNextPosition());
  }
  
  PVector getNextPosition() {
    return PVector.add(position, velocity);
  }
}
