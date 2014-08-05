ArrayList<Ring> rings;

void setup() {
  size(500,500);
  
  rings = new ArrayList<Ring>();
  int r = 10;
  for(int i = 0; i < r; i++) {
    int n = 4 + (4 * i);
    int diameter = 15 + (25 * i);
    float speed = 0.004 * (r - i);
    rings.add(new Ring(n, diameter, speed));
  }
}

void draw() {
  background(255);
  
  for(Ring ring : rings) {
    ring.display();
  }
}
