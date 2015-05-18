// Perlin Noise Display 1D
// Max Allen

// Variables //
boolean loop = true;
int x = 0;
float x_off = 0;
float xOffStep = .002;
Point prev = null;

void setup() {
  size(500,500);
  background(255);
//  frameRate(5);
}

void draw(){
  // Draw points based on a perlin noise value //
  int newX = x%width;
  x++;
  x_off += xOffStep;
  
  if (prev == null) {
    // No previous point
    // Get point //
    prev = new Point(newX,height-500*noise(x_off));
    
    // Display Point //
//    stroke(0);
//    point(prev.x1,prev.y1);
    
    // Draw line to bottom of screen with low alpha //
    stroke(0,10);
    line(prev.x1,height,prev.x1,prev.y1);
    
  } else {
    // Previous point
    // Get new point //
    float y = height - 500*noise(x_off);
    
    // Draw  line from previous point to new point //
//    stroke(0);
//    line(prev.x1,prev.y1,newX,y);
    prev.setX(newX);
    prev.setY(y);
    
    // Draw line to bottom of screen with low alpha //
    stroke(0,10);
    line(prev.x1,height,prev.x1,prev.y1);
  }
  if (newX == width-1) {
    prev = null;
//    loop = false;
//    noLoop();
  }
  
}

void mousePressed() {
  if (loop) {
    noLoop();
  } else {
    loop();
  }
  loop = !loop;
}

class Point {
  float x1,y1;
  Point (float X, float Y) {
    x1 = X;
    y1 = Y;
  }
  
  void setX (float x){
    x1 = x;
  }
  
  void setY (float y){
    y1 = y;
  }
}
