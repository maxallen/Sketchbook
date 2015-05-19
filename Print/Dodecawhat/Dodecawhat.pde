PGraphics canvas;
PGraphics bigCanvas;
int w = 800;
int h = 800;
int scale = 3;



void setup(){
  size(w,h);
  smooth();
  noFill();
  background(255);
  
  canvas = createGraphics(w,h);
  bigCanvas = createGraphics(scale*w, scale*h);
  
  
}

void draw(){
  // Draw moment //
  background(255);
  
  
  
  // Draw on canvas if mouse is dragged //
  if(mousePressed){
    
  }
  
  // Draw canvas on the sketch //
  image(canvas,0,0);
}
