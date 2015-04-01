int paddleLength = 80,
  paddleThickness = 5,
  misses = 0;
float paddleOffset = paddleLength/2,
  minSpeed = 2,
  maxSpeed = 12;
Ball ball;
Paddle topPaddle, bottomPaddle, leftPaddle, rightPaddle; // paddles
PVector middle; // middle of the board
float dt, runTime;

void setup() {
  size(500, 500);
  
  int gap = paddleThickness * 2;
  
  topPaddle = new Paddle(new PVector(width/2, gap), new PVector(paddleLength, paddleThickness));
  bottomPaddle = new Paddle(new PVector(width/2, height - gap), new PVector(paddleLength, paddleThickness));
  leftPaddle = new Paddle(new PVector(gap, height/2), new PVector(paddleThickness, paddleLength));
  rightPaddle = new Paddle(new PVector(width - gap, height/2), new PVector(paddleThickness, paddleLength));
  
  middle = new PVector(width/2, height/2);
  ball = new Ball(middle, randomVelocity(), 5);
  runTime = millis();
}

PVector randomVelocity() {
  return PVector.mult(PVector.random2D(), minSpeed);
}

void resetBall() {
  ball.position.set(middle);
  ball.velocity.set(randomVelocity());
}

void draw() {
  dt = (millis() - runTime) / (1000/60);
  runTime = millis();
  
  background(255);
  noCursor();
  
  handlePaddleMovement();
  ball.move(dt);
  drawPaddles();
  ball.display();
  handleBallBoundaries();
  handleCollisions(dt);
  
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
    resetBall();
  }
}

void drawPaddles() {
  topPaddle.display();
  bottomPaddle.display();
  leftPaddle.display();
  rightPaddle.display();
}

void handleCollisions(float dt) {
  float ballTop = ball.position.y - ball.size,
    ballBottom = ball.position.y + ball.size,
    ballLeft = ball.position.x - ball.size,
    ballRight = ball.position.x + ball.size;
    
  if (topPaddle.containsPoint(new PVector(ball.position.x, ballTop)) || bottomPaddle.containsPoint(new PVector(ball.position.x, ballBottom))) {
    ball.velocity.y *= -1.05;
    float a = ball.position.x - topPaddle.position.x;
    ball.velocity.x = map(a, -paddleLength, paddleLength, -maxSpeed, maxSpeed);
    
    ball.velocity.x = (ball.velocity.x > 0) ? max(ball.velocity.x, minSpeed) : min(ball.velocity.x, -minSpeed);
  }
  
  if (leftPaddle.containsPoint(new PVector(ballLeft, ball.position.y)) || rightPaddle.containsPoint(new PVector(ballRight, ball.position.y))) {
    ball.velocity.x *= -1.05;
    float a = ball.position.y - leftPaddle.position.y;
    ball.velocity.y = map(a, -paddleLength, paddleLength, -10, 10);
    
    ball.velocity.y = (ball.velocity.y > 0) ? max(ball.velocity.y, minSpeed) : min(ball.velocity.y, -minSpeed);
  }
}
