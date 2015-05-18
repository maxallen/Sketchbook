import processing.pdf.*;
boolean usePDF = true;
boolean useColor = true;

PImage p;
PGraphics sketch;

float scale = 5.0;
float fontWeight = .50;
int numNodeTries = 4000;

ArrayList<Node> Web;
int Max_Dist = 9;

void setup() {
  p = loadImage("Thepub1.png");
  Web = new ArrayList<Node>();
  //colorMode(HSB,100);
  
  if (usePDF){
    size((int)scale*p.width,(int)scale*p.height, PDF, str(int(random(999)))+".pdf");
    smooth();
    //background(0,0,100);
    background(255);
    strokeWeight(fontWeight);
    generate();
    exit();
  }else{
    sketch = createGraphics((int)scale*p.width,(int)scale*p.height);
    //sketch.colorMode(HSB,100);
    sketch.smooth();
    sketch.beginDraw();
    //sketch.background(0,0,100);
    sketch.background(255);
    sketch.strokeWeight(fontWeight);
    generate();
    sketch.endDraw();
    sketch.save(str(int(random(999)))+".tif");
    exit();
  }
  
  exit();
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
  for (int i = 0; i<numNodeTries; i++){
    // Choose rand x and y
    int rndX = int(random(p.width));
    int rndY = int(random(p.height));
    
    // Get point in picture //
    color colr = p.get(rndX,rndY);
    
    if (red(colr)+blue(colr)+green(colr) < (220*3)){
      // Add the color to the node Web //
      Web.add(new Node(scale*rndX,scale*rndY,colr));
    }
  }
  
  // Create Lines //
  for(int i=0; i<Web.size(); i++){
    Node a = Web.get(i);
    for(int j=i+1; j<Web.size(); j++){
      Node b = Web.get(j);
      // Check distance //
      float d = dist(a.getX(),a.getY(),b.getX(),b.getY());
      if(d < scale*Max_Dist){
        // Black color with brightness equal to the average of the two nodes //
        if (usePDF){
          if (useColor){
            // Color
            stroke(getColor(a.getColor(),b.getColor()));
          }else{
            // No color
            stroke(0,100-int((brightness(a.c)+brightness(b.c))/2));
          }
          line(a.getX(),a.getY(),b.getX(),b.getY());
        }else{
          if (useColor){
            // Color
            sketch.stroke(getColor(a.getColor(),b.getColor()));
          }else{
            // No color
            sketch.stroke(0,100-int((brightness(a.c)+brightness(b.c))/2));
          }
          sketch.line(a.getX(),a.getY(),b.getX(),b.getY());
        }
      }
    }
  }
}

color getColor(color A, color B){
  return lerpColor(A,B,0.5);
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
  color getColor(){
    return c;
  }
}

