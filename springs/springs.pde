int numNodes = 5;
Node[] nodes = new Node[numNodes];
Spring[] springs = new Spring[numNodes];

float k = 0.2;
PVector gravity = new PVector(0,0.8);

void setup(){
  size(640,480);
  
  float offset = width/numNodes;
  
  float angle = 0;
  float step = 360/nodes.length;
  for(int i = 0; i < nodes.length; i++) {
    float x = cos(radians(angle)) * offset + width/2;
    float y = sin(radians(angle)) * offset + height/2;
    nodes[i] = new Node(x,y, 10);
    angle += step;
  }
  for(int i = 0; i < springs.length; i++) {
    Node a = nodes[i];
    Node b = (i == springs.length - 1) ? nodes[0] : nodes[i+1];
    springs[i] = new Spring(a, b, offset, k);
  }
}

void draw(){
  background(255);
  fill(175);
  stroke(0);
  
  for(Spring s : springs){
    s.update();
    s.display();
  }
  
  for(Node n : nodes) {
    //n.applyForce(gravity);
    n.update();
    n.display();
    n.drag(mouseX,mouseY);
  }
  
}

void mousePressed(){
  // since we iterate forward through the nodes to display them, the higher indexes will display
  // in the foreground. Therefore, in order to only grab the "top" node, we iterate backward here.  
  for(int i = nodes.length - 1; i >= 0; i--){
    if(nodes[i].clicked(mouseX,mouseY)){
      break;
    }
  }
}

void mouseReleased(){
  for(Node n : nodes){
    n.stopDragging();
  }
}
