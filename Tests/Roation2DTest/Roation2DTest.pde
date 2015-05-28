PVector ray;
PVector i;

void setup(){
  size(500,500);
  background(255);
  stroke(0);
  i = new PVector(1,0);
  ray = new PVector(random(-100,100),random(-100,100));
  ray.setMag(200);
}

void draw(){
  background(255);
  pushMatrix();
  translate(width/2,height/2);
  ellipseMode(CENTER);
  stroke(100);
  ellipse(0,0,200,200);
  
  ray.x = mouseX-width/2;
  ray.y = mouseY-height/2;
//  ray.setMag(200);
  
  // Original //
  stroke(255,0,0);
  line(0,0,ray.x,ray.y);
  
  // Shifted //
  pushMatrix();
  stroke(0,255,0);
  float theta = PVector.angleBetween(i,ray);
  if(ray.y < 0){
    rotate(theta);
  }else{
    rotate(-theta);
  }
  line(0,0,ray.x,ray.y);
  popMatrix();
  
  // Backwards - draw origional vector in blue //
  pushMatrix();
  stroke(0,0,255);
  if(ray.y < 0){
    rotate(-theta);
  }else{
    rotate(theta);
  }
  line(0,0,ray.mag(),0);
  popMatrix();
  
  popMatrix();
  
  textSize(14);
  fill(0);
  text("Theta= "+str(degrees(theta)),10,10);
  noFill();
  
}

void mouseClicked(){
  setup();
}
