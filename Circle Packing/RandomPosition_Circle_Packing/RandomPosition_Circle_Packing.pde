// Circle Packing
// 
// V 1.0

// Variables //
int MAX_TRIES = 1000; // 1,000
int HEIGHT = 500;
int WIDTH = 500;

float startArea = 50000.0; // 50,000 = 1/5 of total area
float originalRadius = getRadius(startArea);
float C = 1.1;
int circleNum = 0; // Placing first circle
int iteration = 1;
int NUM_CIRCLES = 500;

float[][] circles;

boolean said = false;

void setup() {
  size(WIDTH,HEIGHT);
  background(0);
//  frameRate(5);
  smooth();
  ellipseMode(RADIUS);
  circles = new float[NUM_CIRCLES][3]; // Each circle has a x, y, and radius
}

void draw() {
  if (circleNum < NUM_CIRCLES-1 ) {
    int tryNum = 1;
    float radius = getRadius(startArea * (1.0 / pow(iteration,C)));
    while (tryNum < MAX_TRIES) {
      // Get random coordinates and test to see if the current cirlce touches any other circles
      float x = random(WIDTH);
      float y = random(HEIGHT);
      boolean broken = false;
      
      // Go throught array of circles //
      for (int i=0; i < circleNum; i++) {
        float[] cir = circles[i];
        if (dist(x,y,cir[0],cir[1]) < radius + cir[2] ) { // Distance between two circles is less than the sum of their radii
          // OVERLAPPING //
          broken = true;
          break;
        }
      }
      if (!broken)  {
        // Draw Circle //
        float colour = 150*(radius/originalRadius);
//        stroke(255,50+colour,13);
          stroke(100);
        fill(255,50+colour,13);
        ellipse(x,y,radius,radius);
        
        // Add Circle //
        circles[circleNum][0] = x;
        circles[circleNum][1] = y;
        circles[circleNum][2] = radius;
        circleNum ++;
        break;
      }
      tryNum ++;
    }
    iteration ++;
  }else {
    if (!said){
      println("Done!");
      said = true;
    }
  }
}

float getRadius(float area) {
  // Area = PI*radius*radius
  return sqrt(area/PI);
}
