class Tire {
  Body body;
  float r;
  
  Tire(float x, float y, float r_) {
    r = r_;
    
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(x,y)));
    bd.type = BodyType.DYNAMIC;
    
    body = box2d.world.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.friction = 1;
    fd.restitution = 0.2;
    fd.density = 1;
    
    body.createFixture(fd);
    body.setUserData(this);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(127);
    stroke(0);
    
    ellipse(0,0,r*2,r*2);
    line(0,0,r,0);
    popMatrix();
  }
}
