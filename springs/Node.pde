class Node {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float damping = .95;
  float r;
  boolean dragging = false;
  
  Node(float x, float y, float m) {
    location = new PVector(x,y);
    mass = m;
    
    r = mass * 2;
    
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force.get(), mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.mult(damping);
    acceleration.mult(0);
    checkEdges();
  }
  
  void display() {
    ellipse(location.x,location.y,r,r);
  }
  
  boolean isInside(float x, float y){
    return dist(location.x,location.y, x,y) < r/2;
  }
  
  void checkEdges() {
    if(location.y + r > height){
      location.y = height - r;
      velocity.y = 0;
    }
  }
  
  boolean clicked(float x, float y){
    if(isInside(x,y)){
      dragging = true;
      return true;
    }
    return false;
  }
  
  void drag(float x, float y){
    if(dragging){
      location.x = x;
      location.y = y;
    }
  }
  
  void stopDragging(){
    dragging = false;
  }
}
