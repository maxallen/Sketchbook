PImage p;
PGraphics sketch;
ArrayList<Node> Web;
int Max_Dist = 20;

void setup() {
  p = loadImage("Heisenberg2.jpg");
  //p.resize(2000,2000);
  sketch = createGraphics(p.width, p.height);
  size(p.width, p.height);
  Web = new ArrayList<Node>();
  colorMode(HSB,100);
  noLoop();
  generate();
}

void draw() {
  image(sketch,0,0,width,height);
  saveFrame("Heisenberg2.jpg");
  //saveFrame(str(int(random(1000)))+".png");
}

void generate() {
  // Organized Node Locations //
  /*
  for (int i = 0; i<p.width; i+=4){
    for(int j = 0; j<p.height; j+=4){
      // Get point in picture //
      float colr = p.get(i,j);
      if (brightness(int(colr)) < 70 ){
        // Add the color to the node Web //
        Web.add(new Node(i,j));
      }
    }
  }
  */
  
  // Random Node Locations //
  for (int i = 0; i<6000; i++){
    // Choose rand x and y
    int rndX = int(random(p.width));
    int rndY = int(random(p.height));
    
    // Get point in picture //
    color colr = p.get(rndX,rndY);
    
    if (brightness(colr) < 70 ){
      // Add the color to the node Web //
      Web.add(new Node(rndX,rndY,colr));
    }
  }
  
  sketch.beginDraw();
  sketch.background(255);
  //sketch.smooth();
  // Create Lines //
  for(int i=0; i<Web.size(); i++){
    Node a = Web.get(i);
    for(int j=i+1; j<Web.size(); j++){
      Node b = Web.get(j);
      // Check distance //
      float d = dist(a.getX(),a.getY(),b.getX(),b.getY());
      if(d < Max_Dist){
//        sketch.stroke(0,40-(d*(40.0/Max_Dist)));
        // Black color with brightness equal to the average of the two nodes //
        sketch.stroke(0,100-int((brightness(a.c)+brightness(b.c))/2));
        sketch.line(a.getX(),a.getY(),b.getX(),b.getY());
      }
    }
  }
  sketch.endDraw();
}

class Node {
  PVector location;
  color c;
  Node(float X, float Y, color C){
    location = new PVector(X,Y);
    c = C;
  }
  float getX(){
    return location.x;
  }
  float getY(){
    return location.y;
  }
}

