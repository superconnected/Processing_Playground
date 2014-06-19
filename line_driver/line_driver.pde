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

void setup(){
  size(1600,400);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  car = new Car(width/2, 200, 100, 40); 
  ground = new Ground();
}

void draw() {
  background(255);
  box2d.step();
  
  ground.display();
  car.display();
}

