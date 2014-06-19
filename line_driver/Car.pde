class Car {
  Body body;
  Tire tire1, tire2;
  float w,h;
  float motorSpeed = 14;
  RevoluteJoint tire1_joint;
  RevoluteJoint tire2_joint;
  boolean canReverse = true;
  float edge = 100;
  
  Car(float x, float y, float w_, float h_) {
    w = w_;
    h = h_;
    
    edge = w * 1.2;
    
    tire1 = new Tire(x - w/2, y + h/2);
    tire2 = new Tire(x + w/2, y + h/2);
    
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.type = BodyType.DYNAMIC;
    
    body = box2d.world.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    ps.setAsBox(
      box2d.scalarPixelsToWorld(w/2), 
      box2d.scalarPixelsToWorld(h/2)
    );
    body.createFixture(ps, 1.0);
    
    tire1_joint = createTireJoint(tire1);
    tire2_joint = createTireJoint(tire2);
  }
  
  private RevoluteJoint createTireJoint(Tire tire) {
    RevoluteJointDef rjd = new RevoluteJointDef();
    rjd.initialize(body, tire.body, tire.body.getWorldCenter());
    rjd.motorSpeed = motorSpeed;
    rjd.maxMotorTorque = 1000;
    rjd.enableMotor = true;
    
    return (RevoluteJoint)box2d.world.createJoint(rjd);
  }
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    stroke(0);
    rectMode(CENTER);
    
    fill(255,0,0);
    ellipse(0,0,2,2); // center point
    
    fill(175);
    
    rect(0,0,w,h); // body
    popMatrix();
    
    tire1.display();
    tire2.display();
    
    if (pos.x + w/2 > width - edge || pos.x - w/2 - edge < 0){
      reverseDirection();
      canReverse = false;
    } else {
      canReverse = true;
    }
  }
  
  void reverseDirection() {
    if (canReverse) {
      motorSpeed *= -1;
      tire1_joint.setMotorSpeed(motorSpeed);
      tire2_joint.setMotorSpeed(motorSpeed);
    }
  }
}
