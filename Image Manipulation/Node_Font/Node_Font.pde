PImage p;
PGraphics sketch;
ArrayList<Node> Web;
int Max_Dist = 15;
int cols = 5;
int rows = 4;

void setup() {
  p = loadImage("AnMingXiCurvey.png");
  sketch = createGraphics(p.width, p.height);
  sketch.beginDraw();
  sketch.background(255);
  sketch.endDraw();
  size(p.width, p.height);
  Web = new ArrayList<Node>();
  noLoop();
  generate();
}

void draw() {
  image(sketch,0,0,width,height);
  //saveFrame("alpha-####.png");
}

void generate() {
  
  // Go through the grids //
  for(int c=0; c<cols; c++){
    for(int r=0; r<rows; r++){
      // Random Node Locations //
      for (int i = 0; i<2500; i++){
        // Choose rand x and y
        int rndX = int(random((p.width/cols)*c,(p.width/cols)*(c+1)));
        int rndY = int(random((p.height/rows)*r,(p.height/rows)*(r+1)));
        
        // Get color at point in picture //
        color colr = p.get(rndX,rndY);
        
        if ((red(colr)+blue(colr)+green(colr))/3 < 50 ){
          // Add the color to the node Web //
          Web.add(new Node(rndX,rndY,colr));
        }
      }
      
      // Draw current frame //
      sketch.beginDraw();
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
            sketch.stroke(0,20); //,100-int((brightness(a.c)+brightness(b.c))/2));
            sketch.line(a.getX(),a.getY(),b.getX(),b.getY());
          }
        }
      }
      sketch.endDraw();
      
      // Clear the web for the next round //
      Web.clear();
    } 
  }
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

