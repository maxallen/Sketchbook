class Paddle {
  PVector location;
  
  Paddle (float x, float y, int minHeight, int maxHeight){
    location = new PVector(x,y);
  }
  
  void draw() {
    // Draw rect 50 px tall, 10 px wide //
    rectMode(CENTER);
    rect(location.x, location.y, 50, 10);
  }
}
