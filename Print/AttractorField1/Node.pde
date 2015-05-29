class Node extends PVector{
  PVector velocity;
  float minX, minY, maxX, maxY;
  float damping;
  
  public Node(float xPos, float yPos, float xVel, float yVel){
    this.x = xPos;
    this.y = yPos;
    minX = 0.0;
    minY = 0.0;
    maxX = width;
    maxY = height;
    velocity = new PVector(xVel, yVel);
    damping = .001;
  }
  
  public void update(){
    x += velocity.x;
    y += velocity.y;
    
    if(x < minX || x > maxX){
      velocity.x *=-1.0;
      x = constrain(x, minX,maxX);
    }
    if(y < minY || y > maxY){
      velocity.y *=-1.0;
      y = constrain(y, minY,maxY);
    }
    
    velocity.x *= (1-damping);
    velocity.y *= (1-damping);
    velocity.x = constrain(velocity.x, -5, 5);
    velocity.y = constrain(velocity.y, -5, 5);
    point(x,y);
  }
}
