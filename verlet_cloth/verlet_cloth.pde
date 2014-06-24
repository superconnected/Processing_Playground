/**
 * Solution for http://natureofcode.com/book/chapter-5-physics-libraries/#chapter05_exercise13
 * by Josh Daniels (github.com/superconnected)
 */

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
ArrayList<Particle> particles;
int rows = 15,
    cols = 25;
Particle topLeft, topRight;
boolean overTopLeft = false,
        overTopRight = false;

void setup() {
  size(600,400);
  
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0,0,width,height));
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0.2)));
  
  particles = new ArrayList<Particle>();
  
  for(int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int idx = i*cols+j;
      float x = (width/2-(cols * 10)) + j * 20;
      float y = 60 + i * 20;
      Particle p = new Particle(new Vec2D(x, y));
      particles.add(p);
      physics.addParticle(p);
      
      if(j > 0) {
        Particle previous = particles.get(idx-1);
        addSpring(p,previous);
      }
      
      if(i > 0) {
        Particle above = particles.get(idx-cols);
        addSpring(p,above);
      }
    }
  }
  
  topLeft = particles.get(0);
  topLeft.lock();
  topRight = particles.get(cols-1);
  topRight.lock();
}

void addSpring(Particle p1, Particle p2) {
  VerletSpring2D spring = new VerletSpring2D(p1, p2, 10, 0.05);
  physics.addSpring(spring);
}

void draw() {
  background(255);
  stroke(0);
  noFill();

  physics.update();
  
  for(int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int idx = i*cols+j;
      Particle p = particles.get(idx);
      
      if(j > 0) {
        Particle previous = particles.get(idx-1);
        line(p.x,p.y,previous.x,previous.y);
      }
      
      if(i > 0) {
        Particle above = particles.get(idx-cols);
        line(p.x,p.y,above.x,above.y);
      }
    }
  }
  
  topLeft.display();
  topRight.display();
  
  if(overTopLeft) {
    topLeft.x = mouseX;
    topLeft.y = mouseY;
  } else if (overTopRight) {
    topRight.x = mouseX;
    topRight.y = mouseY;
  }
  
}

void mousePressed() {
  if (dist(topLeft.x,topLeft.y,mouseX,mouseY) < topLeft.radius) {
    overTopLeft = true;
  } else if (dist(topRight.x,topRight.y,mouseX,mouseY) < topRight.radius) {
    overTopRight = true;
  }
}

void mouseReleased() {
  overTopLeft = false;
  overTopRight = false;
}
