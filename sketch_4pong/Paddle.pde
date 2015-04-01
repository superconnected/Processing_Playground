class Paddle {
  PVector position;
  PVector dimensions;
  
  Paddle(PVector position, PVector dimensions) {
    this.position = position.get();
    this.dimensions = dimensions.get();
  }
  
  void display() {
    fill(0);
    pushMatrix();
    translate(position.x - dimensions.x/2, position.y - dimensions.y/2);
    rect(0, 0, dimensions.x, dimensions.y);
    popMatrix();
  }
  
  boolean containsPoint(PVector point) {
    return point.x >= position.x - dimensions.x/2
      && point.x <= position.x + dimensions.x/2
      && point.y >= position.y - dimensions.y/2
      && point.y <= position.y + dimensions.y/2;
  } 
}
