// Brightness Level Curve Portrait //
//
// Max Allen //

PImage p;
PGraphics sketch;
int time = 0;
int NUM_LEVELS = 4;
boolean useColor = false;
int levelSplit = 255/NUM_LEVELS;
color A = color(0,0,0);
color B = color(255,255,255);

boolean toggleImg = true;

void setup() {
  p = loadImage("Heisenberg2.jpg");
  sketch = createGraphics(p.width, p.height);
  sketch.beginDraw();
//  sketch.background(255);
  sketch.smooth();
  sketch.endDraw();
  size(p.width, p.height);
  colorMode(HSB,250);
  noLoop();
}

void draw() {
  time++;
  background(255);
  
  // Use the brightness value in HSB to print the PImage out in Black and White //
  image(p,0,0);
  loadPixels();
  int pixLength = pixels.length;
  for( int i=0; i<pixLength; i++){
    int c = levelSplit*(int(brightness(pixels[i]))/levelSplit);
    if(useColor){
      pixels[i] = color(lerpColor(A,B,c/255.0));
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

