PImage img;
int resolution = 9;
char[] ascii = new char[] { 'M', 'N', '@', '#', 't', 'x', ';', ':', ',', '.', ' ' };

void setup() {
  img = loadImage("Penguins.jpg");
  size(img.width,img.height);
  background(255);
  fill(0);
  noStroke();
  
  PFont mono = createFont("Courier", resolution+2);
  textFont(mono);

  img.filter(GRAY);
  img.loadPixels();
  
  asciify();
}

void asciify() {
  for (int y = 0; y < img.height; y += resolution) {
    for (int x = 0; x < img.width; x += resolution) {
      color pixel = img.pixels[y * img.width + x];
      int index = round(map(brightness(pixel), 0, 255, 0, ascii.length-1));
      text(ascii[index], x, y);
    }
  }
}


