DoublePendulum pend = new DoublePendulum();
PGraphics bg;                       //the trace will be drawn into this
PGraphics big;
 
float posx, posy, newposx, newposy; //these keep track of the tip's position
float centerx, centery;             //anchor point of the pendulum
int w;
int h;
float s = 30.;                      //scaling factor for drawing the arms
float scale = 3.0;

boolean whiteOnBlack = true;
 
void setup() {
  size(800,800);
  w = 800;
  h = 800;
  
  // Graphics Buffers //
  bg = createGraphics(w,h);
  big = createGraphics((int)(scale*w),(int)(scale*h));
  
  bg.beginDraw();
  bg.colorMode(RGB,255);
  if (whiteOnBlack){
    bg.background(0);
  }else{
    bg.background(255);
  }
  
  
//  bg.smooth();
  bg.endDraw();
  
  big.beginDraw();
  big.colorMode(RGB,255);
  if (whiteOnBlack){
    big.background(0);
  }else{
    big.background(255);
  }
  
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
  
  if (whiteOnBlack){
    background(0);
  }else{
    background(255);
  }
}
 
void draw() {
  for (int dfsa=0; dfsa<10;dfsa++){
    pend.update(0.003);
    newposx = centerx + s*pend.l1*sin(pend.x[0]) + s*pend.l2*sin(pend.x[2]);
    newposy = centery + s*pend.l1*cos(pend.x[0]) + s*pend.l2*cos(pend.x[2]);
     
   
    float vel = sqrt((posx-newposx)*(posx-newposx) + (posy-newposy)*(posy-newposy));
    // should calculate vel wrt the actual states instead of the xy pos as it doesn't scale well right now
    
    bg.beginDraw(); 
    bg.strokeWeight(1.5);
    if (whiteOnBlack){
      bg.stroke(255,50);
    }else{
      bg.stroke(0,30);
    }
    
    bg.line(posx,posy,newposx,newposy);
    bg.endDraw();
    
    big.beginDraw();
    big.strokeWeight(1.5*scale);
    if (whiteOnBlack){
      big.stroke(255,50);
    }else{
      big.stroke(0,30);
    }
    
    big.line(posx*scale, posy*scale, newposx*scale, newposy*scale);
    
    posx = newposx;
    posy = newposy;
     
    image(bg,0,0);
    if (whiteOnBlack){
      stroke(220,50);
    }else{
      stroke(20,50);
    }
    
    strokeWeight(2);
    pend.draw();
  }
  
  // Movie Frames //
  if(whiteOnBlack){
    
  }else{
    saveFrame("frames2/####.png");
  }
    saveFrame("frames/####.png");
  }
 
void mouseClicked() {
  this.setup();
}

void keyPressed() {
  if(key == 's'){
    big.save(str(random(1000))+".tiff");
  }
  if(key == 'e'){
    exit();
  }
}

