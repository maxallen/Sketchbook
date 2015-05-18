class Bullet {
  PVector position;
  int radius = 1;
  color c;
  
  Bullet(float x, float y) {
    position = new PVector(x,y);
    c = new Color(random(255),random(255),random(255));
  }
  
  void draw(){
    stroke(c);
    fill(c);
    ellipseMode(RADIUS);
    ellipse(position.x, position.y, radius, radius);
  }
}
