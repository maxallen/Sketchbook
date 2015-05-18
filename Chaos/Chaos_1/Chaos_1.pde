// Chaos creater V 1.0

void setup() {
  size(500,500);
  background(0);
  stroke(255,0,0,20);
}

void draw() {
  // noise() needs an "offset" argument //
  float x_off = frameCount * 0.0005;
  float y_off = x_off + 20;
  
  // Get X and Y coords based on offset //
  float x = noise(x_off) * width;
  float y = noise(y_off) * height;
  
  // Make a point //
  point(x,y);
  
  //background(frameRate);
  //text(str(frameRate),10,10);
}


