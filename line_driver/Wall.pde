class Wall {
  Body body;
  float x, y, w, h;
  
  Wall(float x_, float y_, float w_, float h_, float a) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    ps.setAsBox(
      box2d.scalarPixelsToWorld(w/2),
      box2d.scalarPixelsToWorld(h/2)
    );
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1.0;
    fd.restitution = 0;
    fd.friction = 1;
    
    body.createFixture(fd);
    body.setUserData(this);
  }
  
  void display() {
    fill(100);
    strokeWeight(0);
    rectMode(CENTER);
    
    float a = body.getAngle();
    
    pushMatrix();
    translate(x,y);
    rotate(-a);
    rect(0,0,w,h);
    popMatrix();
  }
}
