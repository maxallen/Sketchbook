// Marcel Inspiration
//
// Max Allen

ArrayList<Node> Nodes;
int NUM_NODES = 500;
boolean run = true;
int LENGTH = 75;

boolean inSync = true;

void setup(){
  size(1200,700);
  background(255);
  smooth();
  // Create node list //
  Nodes = new ArrayList<Node>();
  for(int i=0; i<NUM_NODES; i++){
    Nodes.add(new Node());
  }
}

void draw(){
  if(run){
    // Go through all nodes and step //
    for(int i=0; i<NUM_NODES; i++){
      Nodes.get(i).step();
    }
  }
}

void keyPressed(){
  if(key == 't'){
    run = !run;
  }
  
  if(key == 's'){
    saveFrame(str(int(random(1000)))+".jpg");
  }
}

class Node {
  PVector location;
  float angle;
  color c;
  
  Node(){
    location = new PVector(random(width),random(height));
    angle = int(random(TWO_PI));
    c = color(random(255),random(255),random(255));
  }
  
  void step(){
    if(inSync){
      pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      stroke(c,10);
      line(0,0,LENGTH,LENGTH);
      angle+=.01;
      popMatrix();
    }else{
      if(int(random(int(random(4)))) == 0){
        pushMatrix();
        translate(location.x, location.y);
        rotate(angle);
        stroke(c,10);
        line(0,0,LENGTH,LENGTH);
        angle+=.01;
        popMatrix();
      }
    }
  }
}
