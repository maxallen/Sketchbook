/*
//  Program in which I try and rotate the 3D coordinate system so that a vectore will point in the positive X direction
//
//
*/

import java.lang.Math.*;

PVector ray; 
PVector vertex1;
PVector vertex2;
PVector i;
boolean print = false;

void setup(){
  size(500,500,P3D);
  background(0);
  stroke(255);
  i = new PVector(1,0,0);
  vertex1 = new PVector(random(-100,100),random(-100,100),random(-100,100));
  vertex2 = new PVector(random(-100,100),random(-100,100),random(-100,100));
  vertex1.setMag(200);
  vertex2.setMag(200);
  ray = PVector.sub(vertex1,vertex2);
  noFill();
  println("Ray.x = " + str(ray.x));
  println("Ray.y = " + str(ray.y));
  println("Ray.z = " + str(ray.z));
  println();
}

void draw(){
  background(255);
  translate(width/2,height/2,0);
  // rotate the canvas when the mouse moves
  rotateX(map(mouseY, 0, height, -PI/2, PI/2));
  rotateY(map(mouseX, 0, width, -PI/2, PI/2));
  stroke(0);
  line(0,0,0,100,0,0);
  stroke(100);
  line(0,0,0,0,100,0);
  stroke(200);
  line(0,0,0,0,0,100);
  
  // Original //
  stroke(255,0,0); // RED
  line(0,0,0,vertex1.x,vertex1.y,vertex1.z);
  line(0,0,0,vertex2.x,vertex2.y,vertex2.z);
  PVector ra = PVector.add(ray,vertex2);
  stroke(0,255,0);
  line(vertex2.x,vertex2.y,vertex2.z,ra.x,ra.y,ra.z);
  
  
  
  // PVector 2: Rotated //
  translate(vertex2.x,vertex2.y,vertex2.z);
  stroke(0,0,255); //BLUE
  pushMatrix();
  float r = sqrt(pow(ray.x,2) + pow(ray.y,2) + pow(ray.z,2));
  float theta = atan(ray.x/ray.z);
  float phi = acos(-ray.y/r);
  
  if(print){
    print = false;
    println("Theta = " + str(degrees(theta)));
    println("Phi = " + str(degrees(phi)));
//    println("Ray.x = " + str(ray.x));
//    println("Ray.y = " + str(ray.y));
//    println("Ray.z = " + str(ray.z));
    println();
  }
  if(ray.z<0){
    rotateY(PI+theta);
  }else{
    rotateY(theta);
  }
  rotateX(-phi);
  
//  line(0,0,0,ray.x,ray.y,ray.z);
  line(0,0,0,0,-ray.mag(),0);
  popMatrix();
  
}

void mouseClicked(){
  setup();
}

void keyPressed(){
  if(key == 'p'){
    print = true;
  }
}
