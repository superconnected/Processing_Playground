class Ground {
  ArrayList<Vec2> surface;
  
  Ground(int wallWidth) {
    surface = new ArrayList<Vec2>();
    float angle = random(0, PI);
    float amplitude = random(30, 80);
    for(int i = wallWidth; i < width - wallWidth; i++) {
      float y = height - 100 + sin(angle) * amplitude;
      angle += PI/(width/4);
      
      surface.add(new Vec2(i, y));
    }
    
    ChainShape chain = new ChainShape();
    Vec2[] vertices = new Vec2[surface.size()];
    
    for(int i = 0; i < vertices.length; i++){
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }
    
    chain.createChain(vertices, vertices.length);
    
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = chain;
    fd.friction = 5;
    fd.density = 1.0;
    body.createFixture(fd);
  }
  
  void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    
    beginShape();
    for (Vec2 v : surface) {
      vertex(v.x,v.y);
    }
    endShape(); //<>//
  }
}
