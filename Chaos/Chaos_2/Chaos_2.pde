// Chaos creater V 2.0

// Global Variables //
ArrayList<Bean> beans;
float x,y,x_off,y_off;

void setup() {
  size(500,500);
  background(0);
  //stroke(255,0,0,20);
  beans = new ArrayList<Bean>();
}

void draw() {
  // noise() needs an "offset" argument //
  x_off = frameCount * 0.0005;
  y_off = x_off + 30;
  
  // Get X and Y coords based on offset //
  x = noise(x_off) * width;
  y = noise(y_off) * height;
  
  // Make a point //
  //point(x,y);
  
  // Every 20 frames, create a bean //
  if (frameCount % 10 == 0) {
    beans.add(new Bean(x,y,x_off,y_off,3,-.003));
  }
  
  // Draw all beans //
  int s = beans.size();
  for (int i=s-1; i>=0; i--) {
    Bean temp = beans.get(i);
    if (temp.vel <= 0) {
      beans.remove(i);
    }else{
      temp.draw();
    }
  }
}

class Bean {
  // Keep track of various properties of a "bean" particle //
  float x, y, x_off, y_off, vel, acc;
  
  Bean(float X, float Y, float XO, float YO, float VEL, float ACC) {
    x = X;
    y = Y;
    x_off = XO;
    y_off = YO;
    vel = VEL;
    acc = ACC;
  }
  
  void draw() {
    if (vel <= 0) {
      return;
    }
    
    // Do this if Velocity is > 0 //
    
    // Increment offsets
    x_off += 0.0007;
    y_off += 0.0007;
    
    // Update Velocity
    vel += acc;
    
    // Get new position //
    x += noise(x_off) * vel - vel/2;
    y += noise(y_off) * vel - vel/2;
    
    // Set color to draw with //
    //stroke(0,255,0,3);
    setColor();
    point(x,y);
  }
  
  void setColor() {
    colorMode(HSB,360,100,100);
    // Hue is the noise of the average of the x and y offsets //
    float h = noise((x_off+y_off)/2)*360;
    int s = 100;
    int b = 100;
    int a = 6;
    stroke(h,s,b,a);
  }
}


