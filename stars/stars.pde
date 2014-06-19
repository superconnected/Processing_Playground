int points, verts;
float theta, rot;

void setup(){
  size(600,400);
  
  points = 12;
  verts = points * 2;
  theta = TWO_PI/verts;
}

void draw() {
  background(255);
  float outer = width/3;
  float inner = outer*.5;
  float scale = .8;
  int num = floor(map(mouseY, 0, height, 5, 12));
  rot = map(mouseX, 0, width, -1, 1);
  for(int i = 0; i < num; i++) {
    drawStar(outer, inner, rot * i, color(50 + i * mouseY/4, i * mouseX/4, 100 + i * 255/num, 100 + i * 255/num));
    outer *= scale;
    inner *= scale;
  }
}

void drawStar(float outerRadius, float innerRadius, float rotation, color fill) {
  pushMatrix();
  fill(fill);
  noStroke();
  translate(width/2, height/2);
  beginShape();
  float a = rotation;
  for(int i = 0; i < points; i++) {
    for(int j = 0; j < 2; j++) {
      float currentRadius = (j%2==0) ? outerRadius : innerRadius;
      float x = cos(a) * currentRadius;
      float y = sin(a) * currentRadius;
      vertex(x,y);
      a += theta;
    }
  }
  endShape(CLOSE);
  popMatrix();
}


