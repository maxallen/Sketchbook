// ----------------------- //
// Buddhabrot V 2.0
// Max Allen
// ----------------------- //

// Variables //

// Screen Dimensions
int Dim = 500; // Dimensions --> Square grid

// Set Dimensions
float X_LEFT = -2.0;
float X_RIGHT = 1.0;
float Y_DOWN = -1.5;
float Y_UP = 1.5;

// Iterations
int iterationsPerFrame = 10000; // Number of random points to check whether or not they escape the mandelbrot set
int MAX_ITERATIONS = 200; // Max number of iterations of each random point until declared that it doesn't excape

// Array of Exposures
int[] exposures = new int[Dim*Dim]; // Point (i,j) is at points[width*j + i) //
//int[][] orbits = new int[HEIGHT][WIDTH];
//int a = WIDTH*HEIGHT;
//int b = HEIGHT;
//int c = WIDTH;
int maxExposure = 0;
int time = 0;

// Loop
boolean loop = true;

void setup() {
  size(Dim, Dim);
  frameRate(15);
  // Initialize the points to contain all 0's //
  for(int i = 0; i<exposures.length; i++){
    exposures[i] = 0;
  }
}

void draw() {
  // Get the exposures for this iteration //
  getExposures();
  
  // Re-Draw every 2 seconds or so //
  if(time%30 == 1){
    background(0);
    getMaxExposure();
    
    // Assing color values according to the top exposure value
    int maxPoints = Dim*Dim;
    loadPixels();
    for(int i=0; i<maxPoints; i++){
//      stroke(255*(points[i]/maxExposure));
//      set(int(i/width),i%width);
      float ramp = exposures[i] / (maxExposure / 2.5);
      if(ramp > 1) ramp=1;
      pixels[i] = color(255*ramp);
    }
    updatePixels();
  }
  
  // Update time
  time++;
}

void getExposures(){
  // Do 10,000 points
  float x,y;
  for(int n = 0; n<iterationsPerFrame; n++) {
    // Get random point //
    x = random(X_LEFT,X_RIGHT);
    y = random(Y_DOWN,Y_UP);
    if(iterate(x,y,false)){
      iterate(x,y,true);
    }
  }
}

boolean iterate(float X, float Y, boolean drawIt){
  // The loop //
  float x = 0.0;
  float y = 0.0;
  float xtemp, ytemp;
  int ix, iy;
  for(int iteration=0; iteration<MAX_ITERATIONS; iteration++){
    // Get new orbit //
    xtemp = x*x - y*y + X;
    ytemp = 2*x*y + Y;
    x = xtemp;
    y = ytemp;
    
    // Add the exposure if necessary //
    if(drawIt && iteration > 3){
      // Get scaled point //
      ix = int(Dim * (x + 2.0) / 3.0);
      iy = int(Dim * (y + 1.5) / 3.0);
      if(ix >=0 && ix < Dim && iy >=0 && iy < Dim){
        // Add to exposures array
        exposures[width*ix + iy]++;
      }
    }
    
    if(x*x + y*y > 4){
      // Point escapes //
      return true;
    }
  }
  // Didn't escape //
  return false;
}

int getMaxExposure(){
  // Assume the maxExposure is 0 //
  maxExposure = 0;
  // Iterate throught the points density loop, setting max exposure to the greatest value //
  int numPoints = Dim*Dim;
  for(int i=0; i<numPoints; i++){
    maxExposure = max(maxExposure,exposures[i]);
  }
  return maxExposure;
}

void mouseClicked() {
  if(loop){
    noLoop();
  }else{
    loop();
  }
  loop = !loop;
}
