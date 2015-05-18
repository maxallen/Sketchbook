PImage p;
PGraphics sketch;
ArrayList<Node> Web;
int Max_Dist = 30;
int time = 0;

boolean toggleImg = true;

void setup() {
  p = loadImage("Heisenberg2.jpg");
  sketch = createGraphics(p.width, p.height);
  sketch.beginDraw();
//  sketch.background(255);
  sketch.smooth();
  sketch.endDraw();
  size(p.width, p.height);
  Web = new ArrayList<Node>();
  //colorMode(HSB,100);
  
  //noLoop();
//  frameRate(4);
}

void draw() {
  time++;
  background(255);
  if(toggleImg){
    image(p,0,0,width,height);
  }
  image(sketch,0,0,width,height);
}

void keyPressed(){
  if(key == 't'){
    toggleImg = !toggleImg;
    println("Toggle!");
  }
  
  if(key == 's'){
    // Save Image //
    saveFrame(str(int(random(1000)))+".png");
  }
}

void mouseDragged(){
  addNode();
}

void addNode(){
  if(time%4 == 0){
    // Creat node and add it to the Node list //
    float x = mouseX;
    float y = mouseY;
    color c = p.get(int(x),int(y));
    Web.add(new Node(x,y,c));
    
    // Go through all nodes in the list //
    sketch.beginDraw();
    for(Node n : Web){
      // If the distance to the above node is less than the Max_Dist, draw a line with appropriate color //
      float d = dist(n.getX(),n.getY(),x,y);
      if(d <= Max_Dist){
        //sketch.stroke(getGrey(n.c,c));
        sketch.stroke(getColor(n.c,c));
        sketch.line(x,y,n.getX(),n.getY());
      }
    }
    sketch.endDraw();
  }
}



int getGrey(color A, color B){
  int a = int((red(A)+blue(A)+ green(A))/3);
  int b = int((red(B)+blue(B)+ green(B))/3);
  return (a+b)/2;
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
}


// 

//

//

//

void genedrate() {
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
  for (int i = 0; i<10000; i++){
    // Choose rand x and y
    int rndX = int(random(p.width));
    int rndY = int(random(p.height));
    
    // Get point in picture //
    color colr = p.get(rndX,rndY);
    
    if (brightness(colr) < 100 ){
      // Add the color to the node Web //
      Web.add(new Node(rndX,rndY,colr));
    }
  }
  
  sketch.beginDraw();
  sketch.background(255);
  sketch.smooth();
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
