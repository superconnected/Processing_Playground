int paddleLength = 80,
  paddleThickness = 5,
  misses = 0;
float paddleOffset = paddleLength/2;
float top, bottom, left, right; // ball/paddle collision boundaries
Ball ball;
Paddle topPaddle, bottomPaddle, leftPaddle, rightPaddle; // paddles
PVector middle; // middle of the board

void setup() {
  size(500, 500);
  
  int gap = paddleThickness * 2;
  
  top = paddleThickness + gap;
  bottom = height - paddleThickness - gap;
  left = paddleThickness + gap;
  right = width - paddleThickness - gap;
  
  topPaddle = new Paddle(new PVector(width/2, gap), new PVector(paddleLength, paddleThickness));
  bottomPaddle = new Paddle(new PVector(width/2, height - gap), new PVector(paddleLength, paddleThickness));
  leftPaddle = new Paddle(new PVector(gap, height/2), new PVector(paddleThickness, paddleLength));
  rightPaddle = new Paddle(new PVector(width - gap, height/2), new PVector(paddleThickness, paddleLength));
  
  middle = new PVector(width/2, height/2);
  ball = new Ball(middle, randomVelocity(), 5);
}

void draw() {
  background(255);
  noCursor();
  
  handlePaddleMovement();
  ball.move();
  drawPaddles();
  ball.display();
  handleBallBoundaries();
  handleCollisions();
  
  fill(155,155,155);
  text("missed: " + misses, 40, 40);
}

void handlePaddleMovement() {
  if (mouseX > paddleOffset && mouseX < width - paddleOffset) {
    topPaddle.position.x = mouseX;
    bottomPaddle.position.x = mouseX;
  }
  if (mouseY > paddleOffset && mouseY < height - paddleOffset) {
    leftPaddle.position.y = mouseY;
    rightPaddle.position.y = mouseY;
  }
}

void handleBallBoundaries() {
  if (ball.position.x < 0 || ball.position.x > width || ball.position.y < 0 || ball.position.y > height) {
    misses++;
    ball.position.set(middle);
    ball.velocity.set(randomVelocity());
  }
}

void drawPaddles() {
  topPaddle.display();
  bottomPaddle.display();
  leftPaddle.display();
  rightPaddle.display();
}

void handleCollisions() {
  PVector nextPosition = ball.getNextPosition();
  PVector intersect = null;
  
  if (ball.position.y > top && nextPosition.y <= top) {
    intersect = intersection(nextPosition, middle, top, false);
    if (isPointWithinPaddleBounds(intersect, topPaddle, false)) {
      ball.velocity.y *= -1.05;
      //todo: add spin
    }
  } else if (ball.position.y < bottom && nextPosition.y >= bottom) {
    intersect = intersection(nextPosition, middle, bottom, false);
    if (isPointWithinPaddleBounds(intersect, bottomPaddle, false)) {
      ball.velocity.y *= -1.05;
      //todo: add spin
    }
  }
  
  if (ball.position.x > left && nextPosition.x <= left) {
    intersect = intersection(nextPosition, middle, left, true);
    if (isPointWithinPaddleBounds(intersect, leftPaddle, true)) {
      ball.velocity.x *= -1.05;
      //todo: add spin
    }
  } else if (ball.position.x < right && nextPosition.x >= right) {
    intersect = intersection(nextPosition, middle, right, true);
    if (isPointWithinPaddleBounds(intersect, rightPaddle, true)) {
      ball.velocity.x *= -1.05;
      //todo: add spin
    }
  }
}

PVector intersection(PVector lineEnd, PVector origin, float wall, boolean isVertical) {
  // translate so that the origin is (0, 0), makes the calculations easier
  PVector endPoint = PVector.sub(lineEnd, origin);
  wall = isVertical ? wall - origin.y : wall - origin.x;
  
  if (endPoint.x == 0) {
    if (!isVertical) {
      return PVector.add(new PVector(0, wall), origin);
    }
    return null;
  }
    
  float a = endPoint.y/endPoint.x;
  
  if (isVertical) {
    return PVector.add(new PVector(wall, a * wall), origin);
  }
  
  return PVector.add(new PVector(wall/a, wall), origin);
}

boolean isPointWithinPaddleBounds(PVector point, Paddle paddle, boolean isVertical) {
  if (point == null)
    return false;
    
  if(isVertical) {
    return point.y >= paddle.position.y - paddleOffset && point.y <= paddle.position.y + paddleOffset;
  }
  
  return point.x >= paddle.position.x - paddleOffset && point.x <= paddle.position.x + paddleOffset;
}

PVector randomVelocity() {
  return PVector.mult(PVector.random2D(), 3);
}
