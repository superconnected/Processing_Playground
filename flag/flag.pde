ArrayList<PVector> particles;
int r = 16;
float a = 0;
float startAngle = 0;
float aVel = 0;

void setup() {
  size(640, 480);
  
  particles = new ArrayList();
  for(int y = r; y < height; y += r) {
    for (int x = r; x < width; x += r) {
     particles.add(new PVector(x, y));
    } 
  }
  
  aVel = (TWO_PI / width) * r;
  print(aVel);
}

void draw() {
  background(255);
  noStroke();
  
  startAngle += 0.2;
  a = startAngle;
  for(PVector p : particles){
    float x = p.x;
    float y = p.y + sin(a) * 5;
    fill(map(p.x, 0, width, 100, 200), map(p.y, 0, height, 100, 200), map(mouseY, 0, height, 75, 255));
    ellipse(x, y, r/2, r/2);
    a += aVel;
    
    if(mousePressed) {
      if(p.x == r) {
        a = startAngle;
      }
    }
  }
}
