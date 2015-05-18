// Mandelbrot Creator V 1.0
// Max Allen

// Variables //
int MAX_ITERATIONS = 10000;

// Complex Plane dimensions //
float X_LEFT = -2.5;
float X_RIGHT = 1.0;
float Y_DOWN = -1.2;
float Y_UP = 1.2;

size(700,500);
smooth();
noLoop();

//int test = 0;

for (int row = 0; row < height; row++) {
  for (int col = 0; col < width; col++) {
    // Get the scaled coordinates in the complex plane //
    float x0 = X_LEFT + (((X_RIGHT - X_LEFT)/width)*(float)col);
    float y0 = Y_UP - (((Y_UP - Y_DOWN)/height)*(float)row);
    //println("(" + str(x0) + "," + str(y0) + ")");
    
    float x = 0.0;
    float y = 0.0;
    int iteration = 0;
    
    // Iteration Loop //
    while(x*x + y*y < 4 && iteration < MAX_ITERATIONS) {
      float xtemp = x*x - y*y + x0;
      float ytemp = 2*x*y + y0;
      if (x == xtemp && y == ytemp)
      {
        iteration = MAX_ITERATIONS;
        break;
      }
      x = xtemp;
      y = ytemp;
      iteration++;
    }
    
    // Coloring: //
    float num = (MAX_ITERATIONS / 255) + 1;
    float c = 0.0;
    if (iteration == MAX_ITERATIONS) {
      // In the set
      c = 0.0;
    }else{
      // Put the point into a color category //
      if (iteration < 3) {
        c = 255;
      }else if(iteration < 5) {
        c = 230;
      }else if(iteration < 7) {
        c = 210;
      }else if(iteration < 10) {
        c = 180;
      }else if(iteration < 15) {
        c = 150;
      }else if(iteration < 20) {
        c = 110;
      }else if(iteration < 40) {
        c = 80;
      }else {
        c = 50;
      }
    }
    stroke(c);
    point(col,row);
  }
}

//println("Test: " + str(test));
println("Done!");
