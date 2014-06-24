import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
Car car;
Ground ground;
int wallWidth = 10;
Wall leftWall, rightWall;
float contactBegin;

void setup(){
  size(1600,400);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld(new Vec2(0, -25));
  
  car = new Car(width/2, 0, 100, 12, 20); 
  ground = new Ground(wallWidth);
  leftWall = new Wall(wallWidth/2, height/2, wallWidth, height, 0);
  rightWall = new Wall(width - wallWidth/2, height/2, wallWidth, height, 0);
  
  box2d.listenForCollisions();
}

void draw() {
  background(255);
  box2d.step();
  
  ground.display();
  car.display();
  leftWall.display();
  rightWall.display();
}

void keyPressed() {
  if (key == ' ') {
    car.toggleMotor();
  }
}

void beginContact(Contact cp) {
  Object b1 = cp.getFixtureA().getBody().getUserData();
  Object b2 = cp.getFixtureB().getBody().getUserData();
  
  if ((b1 instanceof Tire || b2 instanceof Tire) &&
      (b1 instanceof Wall || b2 instanceof Wall)) {
        if (millis() - contactBegin > 500) {
          car.reverseDirection();
          contactBegin = millis();
        }
  }
}
void endContact(Contact cp){/*noop*/}
