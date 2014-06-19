color[] colors;

float dt = 0;
int ls = 0;
float last = 0;
float lm = 0;

void setup(){
  size(640,480);
  smooth();
  
  colors = new color[3];
  colors[0] = #DD4422; // hour
  colors[1] = #44DD22; // minute
  colors[2] = #2244DD; // second
  
  ls = second();
}

void draw(){
  background(#222222);
  
  dt = millis() - lm;
  lm = millis();
  
  if(second() != ls) {
    last = 0;
    ls = second();
  } else {
    last += dt/1000.0;
  }
  
  noFill();
  strokeWeight(10);
  strokeCap(SQUARE);
  
  translate(width/2,height/2);
  rotate(-HALF_PI);
  
  stroke(colors[0]);
  float h = map(hour(), 0, 24, 0, TWO_PI);
  arc(0,0,100,100,0,h);
  
  stroke(colors[1]);
  float m = map(minute(), 0, 60, 0, TWO_PI);
  arc(0,0,150,150,0,m);
  
  stroke(colors[2]);
  float s = map(second() + last, 0, 60, 0, TWO_PI);
  arc(0,0,200,200,0,s);
}
