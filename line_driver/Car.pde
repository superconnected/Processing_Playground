class Car {
  Body body;
  Tire tire1, tire2;
  float w,h;
  float tireRadius;
  RevoluteJoint tire1_joint;
  RevoluteJoint tire2_joint;
  boolean canReverse = true;
  float lastSpeed = 0;
  
  Car(float x, float y, float w_, float h_, float tireRadius_) {
    w = w_;
    h = h_;
    tireRadius = tireRadius_;
    
    tire1 = new Tire(x - w/2, y, tireRadius);
    tire2 = new Tire(x + w/2, y, tireRadius);
    
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
    body.setUserData(this);
    
    tire1_joint = createTireJoint(tire1);
    tire2_joint = createTireJoint(tire2);
  }
  
  private RevoluteJoint createTireJoint(Tire tire) {
    RevoluteJointDef rjd = new RevoluteJointDef();
    rjd.initialize(body, tire.body, tire.body.getWorldCenter());
    rjd.motorSpeed = 0;
    rjd.maxMotorTorque = 250 * body.m_mass/2;
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
  }
  
  void reverseDirection() {
    float motorSpeed = tire1_joint.getMotorSpeed();
    setSpeed(-motorSpeed);
  }
  
  void setSpeed(float speed) {
    tire1_joint.setMotorSpeed(speed);
    tire2_joint.setMotorSpeed(speed);
  }
  
  void toggleMotor() {
    float motorSpeed = tire1_joint.getMotorSpeed();
    if (motorSpeed == 0) {
      if (lastSpeed == 0) setSpeed(tireRadius);
      else setSpeed(lastSpeed);
    } else {
      lastSpeed = motorSpeed;
      setSpeed(0);
    }
  }
}
