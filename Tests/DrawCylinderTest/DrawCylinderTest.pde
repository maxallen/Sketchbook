int mag = 200;
int thickness = 10;

void setup(){
  size(500,500,P3D);
  rectMode(CENTER);
  
}

void draw(){
  background(255);
  translate(width/2,height/2);
  rotateX(radians(mouseX));
  rotateY(radians(mouseY));
//  noFill();
  
  // Bottom //
  pushMatrix();
  rotateX(-PI/2);
  rect(0,0,thickness,thickness);
  popMatrix();
  
  // Back //
  pushMatrix();
  translate(0,0,-thickness/2);
  rotateY(PI);
  rect(0,-mag/2,thickness,mag);
  popMatrix();
  
  // Front //
  pushMatrix();
  translate(0,0,thickness/2);
  rect(0,-mag/2,thickness,mag);
  popMatrix();
  
  // Right Side //
  pushMatrix();
  rotateY(PI/2);
  translate(0,0,thickness/2);
  rect(0,-mag/2,thickness,mag);
  popMatrix();
  
  // Left Side //
  pushMatrix();
  rotateY(-PI/2);
  translate(0,0,thickness/2);
  rect(0,-mag/2,thickness,mag);
  popMatrix();
  
  // Top //
  pushMatrix();
  rotateX(PI/2);
  translate(0,0,mag);
  rect(0,0,thickness,thickness);
  popMatrix();
}
