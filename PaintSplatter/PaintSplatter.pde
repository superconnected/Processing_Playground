import java.util.*;

int centerX;
int centerY;
int size;
int spread;
Random generator;

void setup()
{
  size(640, 480);
  background(255);
  
  generator = new Random();
  
  centerX = width/2;
  centerY = height/2;
  size = 25;
  spread = 25;
  noStroke();
}

void draw()
{
  if(mousePressed && mouseButton == LEFT) {
    float x = (float)generator.nextGaussian();
    float y = (float)generator.nextGaussian();
    float distance = abs(dist(x, y, 0, 0));
    float radius = size - min(distance * size, size - size/8);
    
    fill(int((float)generator.nextGaussian() * 255), int((float)generator.nextGaussian() * 255), int((float)generator.nextGaussian() * 255), 40);
    ellipse(x * spread + mouseX, y * spread + mouseY, radius, radius);
  }
}
