DoublePendulum pend = new DoublePendulum();
PGraphics bg;                       //the trace will be drawn into this
PGraphics big;
 
float posx, posy, newposx, newposy; //these keep track of the tip's position
float centerx, centery;             //anchor point of the pendulum
int w;
int h;
float s = 30.;                      //scaling factor for drawing the arms
 
float scale = 3.0;
 
void setup() {
  size(800,800);
  w = 800;
  h = 800;
  
  // Graphics Buffers //
  bg = createGraphics(w,h);
  big = createGraphics((int)(scale*w),(int)(scale*h));
  
  bg.beginDraw();
  bg.colorMode(RGB,255);
  bg.background(255);ls
  
//  bg.smooth();
  bg.endDraw();
  
  big.beginDraw();
  big.colorMode(RGB,255);
  big.background(255);
  big.smooth();
  big.endDraw();
  
  // Simulation setup //
  centerx = w/2.;
  centery = h/2.;
  pend.m1=random(2,6);
  pend.m2=random(1,4);
  pend.l1=random(1.6,8);
  pend.l2=10-pend.l1;
  pend.g=10; 
  pend.x[0]=3;
  pend.x[1]=0;
  pend.x[2]=3.14;
  pend.x[3]=0;
  
  posx = centerx + s*pend.l1*sin(pend.x[0]) + s*pend.l2*sin(pend.x[2]);
  posy = centery + s*pend.l1*cos(pend.x[0]) + s*pend.l2*cos(pend.x[2]);
  
  background(0);
  smooth();
   
}
 
void draw() {
  background(255);
  for (int dfsa=0; dfsa<10;dfsa++){
    pend.update(0.003);
    newposx = centerx + s*pend.l1*sin(pend.x[0]) + s*pend.l2*sin(pend.x[2]);
    newposy = centery + s*pend.l1*cos(pend.x[0]) + s*pend.l2*cos(pend.x[2]);
     
   
    float vel = sqrt((posx-newposx)*(posx-newposx) + (posy-newposy)*(posy-newposy));
    // should calculate vel wrt the actual states instead of the xy pos as it doesn't scale well right now
    
    bg.beginDraw(); 
    bg.strokeWeight(1);
    bg.stroke(0,30);
    bg.line(posx,posy,newposx,newposy);
    bg.endDraw();
    
    big.beginDraw();
    big.strokeWeight(scale);
    big.stroke(0,30);
    big.line(posx*scale, posy*scale, newposx*scale, newposy*scale);
    
    posx = newposx;
    posy = newposy;
     
    image(bg,0,0); 
    stroke(100,100,100);
    strokeWeight(2);
    pend.draw();
  }
}
 
void mouseClicked() {
  this.setup();
}

void keyPressed() {
  if(key == 's'){
    big.save(str(random(1000))+".tiff");
  }
}

