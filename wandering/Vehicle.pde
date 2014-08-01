class Vehicle {
  PVector location, velocity, acceleration;
  float maxForce, maxSpeed, r, arrive, wander_distance, wander_radius;
  
  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    
    r = 3.0;
    maxSpeed = 4;
    maxForce = 0.1;
    arrive = 100;
    wander_distance = 40;
    wander_radius = 10;
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    
    if (location.x > width) location.x = 0;
    if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    if (location.y < 0) location.y = height;
  }
  
  void applyForce(PVector f) {
    acceleration.add(f.get());
  }
  
  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    float distance = desired.mag();
    desired.normalize();
    if (distance < arrive) {
      desired.mult(map(distance, 0, arrive, 0, maxSpeed));
    } else {
      desired.mult(maxSpeed);
    }
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
  void wander() {
    float heading = velocity.heading();
    
    float x = wander_distance * cos(heading) + location.x;
    float y = wander_distance * sin(heading) + location.y;
    
    float angle = noise(frameCount * .005) * TWO_PI;
    
    float x1 = wander_radius * cos(angle) + x;
    float y1 = wander_radius * sin(angle) + y;
    
    seek(new PVector(x1,y1));
  }
  
  void display() {
    float theta = velocity.heading() + HALF_PI;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    
    popMatrix();
  }
}
