Light[] lights;
int numLights = 3;

int dim = 400;
int grid_Dim = 9;
float box_Width = dim / (float)grid_Dim;

void setup(){
  size(dim,dim);
  frameRate(1);
  rectMode(CENTER);
  noLoop();
  
  lights = new Light[numLights];
  lights[0] = new Light(color(166,13,26,180)); // Red
  lights[1] = new Light(color(23,144,191,180)); // Blue
  lights[2] = new Light(color(217,184,20,180)); // Yellow
}

void draw(){
  background(255);
  for(int i=0; i<numLights; i++){
    lights[i].step();
    lights[i].display();
  }
}

void mousePressed(){
  redraw();
}

class Light {
  PVector smallBoxLocation;
  PVector largeBoxLocation;
  color c;
  
  Light(){
    smallBoxLocation = new PVector(0,0);
    largeBoxLocation = new PVector(0,0);
    step();
    c = color(random(255),random(255),random(255),255);
  }
  
  Light(color c_){
    smallBoxLocation = new PVector(0,0);
    largeBoxLocation = new PVector(0,0);
    step();
    c = c_;
  }
  
  void step(){
    // Change placement of small and large boxes //
    // Only exception is that the x and y values of the two boxes can't be the same //
    int sx = int(random(0,grid_Dim));
    int sy = int(random(0,grid_Dim));
    int bx,by;
    do {
      bx = int(random(0,grid_Dim-1));
      by = int(random(0,grid_Dim-1));
    }while(bx+1 == sx || by+1 == sy || by+1 == sx || bx+1 == sy);
    
    println("Small: (" + sx + "," + sy + ")");
    println("Large: (" + bx + "," + by + ")");
    
    smallBoxLocation.x = sx*box_Width+box_Width/2;
    smallBoxLocation.y = sy*box_Width+box_Width/2;
    largeBoxLocation.x = bx*box_Width+box_Width+box_Width/2;
    largeBoxLocation.y = by*box_Width+box_Width+box_Width/2;
  }
  
  void display(){
    // First display the large box //
    noStroke();
    fill(c);
    rect(largeBoxLocation.x,largeBoxLocation.y,3*box_Width,3*box_Width);
    
    // Then display the connection between the small and large box //
    if(largeBoxLocation.x >= smallBoxLocation.x && largeBoxLocation.y <= smallBoxLocation.y){
      // The larger box is either to the upper right or bottom left of the small box //
      quad(smallBoxLocation.x-(box_Width/2),smallBoxLocation.y-(box_Width/2),
           smallBoxLocation.x+(box_Width/2),smallBoxLocation.y+(box_Width/2),
           largeBoxLocation.x+box_Width+(box_Width/2),largeBoxLocation.y+box_Width+(box_Width/2),
           largeBoxLocation.x-box_Width-(box_Width/2),largeBoxLocation.y-box_Width-(box_Width/2));
    }else if(largeBoxLocation.x <= smallBoxLocation.x && largeBoxLocation.y >= smallBoxLocation.y){
      // The larger box is either to the upper right or bottom left of the small box //
      quad(smallBoxLocation.x-(box_Width/2),smallBoxLocation.y-(box_Width/2),
           smallBoxLocation.x+(box_Width/2),smallBoxLocation.y+(box_Width/2),
           largeBoxLocation.x+box_Width+(box_Width/2),largeBoxLocation.y+box_Width+(box_Width/2),
           largeBoxLocation.x-box_Width-(box_Width/2),largeBoxLocation.y-box_Width-(box_Width/2));
    }else{
      // The larger box is either to the upper left or the bottom right of the small box //
      quad(smallBoxLocation.x-(box_Width/2),smallBoxLocation.y+(box_Width/2),
           smallBoxLocation.x+(box_Width/2),smallBoxLocation.y-(box_Width/2),
           largeBoxLocation.x+box_Width+(box_Width/2),largeBoxLocation.y-box_Width-(box_Width/2),
           largeBoxLocation.x-box_Width-(box_Width/2),largeBoxLocation.y+box_Width+(box_Width/2));
    }
    
    // Finally fill the small box //
    fill(0);
    rect(smallBoxLocation.x,smallBoxLocation.y,box_Width,box_Width);
  }
  
}
