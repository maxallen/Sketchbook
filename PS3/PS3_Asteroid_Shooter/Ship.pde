class Ship {
  PVector position;
  PVector velocity;
  int direction; // Angle the ship is facing //
  ArrayList bullets;
  
  Ship(){
    // Set position to center screen //
    position = new PVector(width/2,height/2);
    // Set velocity to zero //
    velocity = new PVector(0,0);
    // Facing upward //
    direction = 90;
  }
  
  void draw(){
    // Draw an icosoles triangle //
    fill(0);
    stroke(0);
    pushMatrix();
    
    // Translate the grid //
    // Rotate the grid //
    
    triangle();
    
    popMatrix();
  }
}
