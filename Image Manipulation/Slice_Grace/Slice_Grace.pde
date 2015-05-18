// Brightness Level Curve Portrait //
//
// Max Allen //

PImage p;
PGraphics sketch;
int time = 0;

// Pixilate //
int NUM_LEVELS = 3;
boolean useColor = false;
int levelSplit = 255/NUM_LEVELS;
color A = color(0,0,0);
color B = color(255,255,255);

// Slice //
int sliceNum = 20; // 20 px //
int x = 0;
float x_off = 0.0;
float xOffStep = .012;

boolean toggleImg = true;

void setup() {
  p = loadImage("Baby2.jpeg");
  sketch = createGraphics(p.width, p.height);
  sketch.beginDraw();
//  sketch.background(255);
  sketch.smooth();
  sketch.endDraw();
  size(p.width, p.height);
  colorMode(RGB);
  noLoop();
}

void draw() {
  time++;
  background(255);
  
  // Use the brightness value in HSB to print the PImage out in Black and White //
  image(p,0,0);
  pixilate();
  slice();

}

void slice(){
  loadPixels();
  int y;
  color c;
  int num = 0;
  // Every row //
  for(int row=0; row<(height/sliceNum); row++){
    num++;
    // Every col //
    for(int col=0; col<width; col++){
      x_off += xOffStep;
      y = int((row*sliceNum) + sliceNum*noise(x_off));
      
      if(num%2 == 0){
        ////////
        // Even Row 
        ////////
        // Pixels Above Y -- Brighter //
        for(int i=row*sliceNum; i<y; i++){
          // Point (x,i) //
          c = get(col,i);
          pixels[i*width + col] = color(red(c)+30, green(c)+30,blue(c)+30);
        }
        // Pixels Below Y -- Darker //
        for(int i=y; i<(row*sliceNum + sliceNum); i++){
          // Point (x,i) //
          if(int(random(10000)) == 1){
            println("Point: (" + x + "," + i + ")");
          }
          c = get(col,i);
          pixels[i*width + col] = color(red(c)-30, green(c)-30,blue(c)-30);
        }
      }else{
        ////////
        // Odd Row
        ////////
        // Pixels Above Y -- Darker //
        for(int i=row*sliceNum; i<y; i++){
          // Point (x,i) //
          if(int(random(10000)) == 1){
            println("Point: (" + x + "," + i + ")");
          }
          c = get(col,i);
          pixels[i*width + col] = color(red(c)-30, green(c)-30,blue(c)-30);
        }
        // Pixels Below Y -- Brighter //
        for(int i=y; i<(row*sliceNum + sliceNum); i++){
          // Point (x,i) //
          c = get(col,i);
          pixels[i*width + col] = color(red(c)+30, green(c)+30,blue(c)+30);
        }
      }
    }
  }
  updatePixels();
}

void pixilate(){
  loadPixels();
  int pixLength = pixels.length;
  for( int i=0; i<pixLength; i++){
    int c = levelSplit*(int(brightness(pixels[i]))/levelSplit);
    if(useColor){
      pixels[i] = lerpColor(A,B,c/255.0);
    }else{
      pixels[i] = color(c);
    }
  }
  updatePixels();
}

void keyPressed(){
  if(key == 't'){
    toggleImg = !toggleImg;
  }
  
  if(key == 's'){
    // Save Image //
    saveFrame(str(int(random(1000)))+".png");
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
//

