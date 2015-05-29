class Attractor {
  PVector position;
  float radius;
  float strength;
  public Attractor(float x, float y, float r){
    position = new PVector(x,y);
    radius = r;
    strength = .5;
  }
  
  void attract(Node n){
    // Get distance between node and attractor //
    float dist = dist(position.x, position.y, n.x, n.y);
    if(dist < radius){
      float dx = position.x-n.x;
      float dy = position.y-n.y;
      float s = dist/radius;
      float f = 1/pow(s,0.5)-1;
      f = f/radius;
      
      n.velocity.x += f*dy*strength;
      n.velocity.y += f*dx*strength;
    }
  }
}
