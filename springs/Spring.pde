class Spring{
  float k;
  float len;
  Node a;
  Node b;
  
  Spring(Node a_, Node b_, float r, float k_){
    a = a_;
    b = b_;
    len = r;
    k = k_;
  }
  
  void update(){
    PVector force = PVector.sub(b.location, a.location);
    float stretch = force.mag() - len;
    force.normalize();
    force.mult(k * stretch);
    a.applyForce(force);
    force.mult(-1);
    b.applyForce(force);
  }
  
  void display() {
    stroke(0);
    line(a.location.x,a.location.y, b.location.x,b.location.y);
  }
}
