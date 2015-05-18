// Box Variables //

int box_Width = 200;
int box_Height = 200;
int box_Length = 600;
PVector location;
PVector velocity;


void setup(){
  size(500,500,P3D);
  background(0);
  noStroke();
  fill(255);
  translate(width/2,height/2,0);
  
  // Set location to a random location //
  location = new PVector(random(0,box_Width/2),random(0,box_Height/2),-1*random(100,box_Length));
  pushMatrix();
  translate(location.x,location.y,location.z);
  sphere(100);
  popMatrix();
  
  // Set velocity //
  velocity = new PVector(2,2,2);
}

void draw(){
  // Clear and draw bounding box//
  background(0);
  lights();
//  noFill();
//  stroke(0);
//  
  // Translate to center //
//  translate(width/2 - (box_Width/2),height/2 - (box_Height/2),-box_Length/2);
  translate(width/2, height/2, 0);
  noStroke();
  fill(255);
  
  
  // Add velocity vector to location vector and update location 
  location.add(velocity);
  if (location.x<-box_Width || location.x>box_Width){
    velocity.x*=-1;
    println("Reverse X");
  }
  if (location.y<-box_Height || location.y >box_Height){
    velocity.y*=-1;
    println("Reverse Y");
  }
  if (location.z>-100 || location.z< -1*box_Length){
    velocity.z*=-1;
    println("Reverse Z");
  }
  pushMatrix();
  translate(location.x,location.y,location.z);
  sphere(100);
  popMatrix();
  
}
