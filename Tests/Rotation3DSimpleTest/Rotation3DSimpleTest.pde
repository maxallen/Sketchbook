float xRot;
float yRot;

void setup(){
  size(500,500,P3D);
  background(255);
  stroke(0);
  
  xRot = 0.0;
  yRot = 0.0;
}

void draw(){
  background(255);
  translate(width/2,height/2,0);
  
  pushMatrix();
  rotateY(radians(yRot));
  rotateX(radians(xRot));
  fill(200);
  box(100);
  line(0,0,0,0,-100,0);
  popMatrix();
  
//  pushMatrix();
//  rotateX(radians(xRot));
//  rotateY(radians(yRot));
//  fill(240);
//  box(100);
//  line(0,0,0,0,-100,0);
//  popMatrix();
}

void keyPressed(){
  
  if(keyCode == UP){
    xRot+=10;
  }else if(keyCode == DOWN){
    xRot-=10;
  }
  
  if(keyCode == RIGHT){
    yRot+=10;
  }else if(keyCode == LEFT){
    yRot-=10;
  }
}
