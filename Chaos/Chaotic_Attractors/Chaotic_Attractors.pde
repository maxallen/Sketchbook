PGraphics pg;
int pWidth = 2400;
int pHeight = 1800;
boolean record = true;

int NUM_PARTICLES  = 10000;
int NUM_ATTRACTORS = 6;

Particle[] particle;
Attractor[] attractor;

float damp = 0.00002;
float accel = 10000;

int time = 0;
boolean run = true;

class Particle {
  float x,y,vx,vy,x0,y0;
  Particle() {
    x = random(width);
    y = random(height);
    vx = random(-accel/2,accel/2);
    vy = random(-accel/2,accel/2);
  }
  void step() {
    for (int i = 0; i < attractor.length; i++) {
      float d2 = sq(attractor[i].x-x) + sq(attractor[i].y-y);
      if (d2 > 0.1) {
        vx += accel * (attractor[i].x-x) / d2;
        vy += accel * (attractor[i].y-y) / d2;
      }
    }
    x += vx;
    y += vy;
    vx *= damp;
    vy *= damp;
    if(record){
      x0 = map(x,0,width,0,pWidth);
      y0 = map(y,0,height,0,pHeight);
      pg.point(x0,y0);
    }
    point(x,y);
  }
}

class Attractor {
  float x,y;
  Attractor() {
    x = random(width);
    y = random(height);
  }
}

void setup() {
  size(800,600);
  if(record){
    pg = createGraphics(pWidth,pHeight);
    pg.beginDraw();
    pg.background(0);
  }
  
  attractor = new Attractor[NUM_ATTRACTORS];
  particle = new Particle[NUM_PARTICLES];
  scatter();
}

void draw() {
  for(int i=0; i<10; i++){
    for (int j = 0; j < particle.length; j++) {
      particle[j].step();
    }
  }
}

void scatter() {
  if(record){
    pg.background(0);
    pg.stroke(232,41,8,5);
  }
  background(0);
//  stroke(255,255,0,3); // Yellow
stroke(232,41,8,5); // Orange
  for (int i = 0; i < attractor.length; i++) {
    attractor[i] = new Attractor();
  }
  for (int i = 0; i < particle.length; i++) {
    particle[i] = new Particle();
  }
}

void mousePressed() {
  scatter();
}

void keyPressed(){
  if(key == 's'){
//    saveFrame(str(int(random(1000)))+".png");
    if(record){
      pg.save(str(int(random(1000)))+".tif");
      println("Frame Saved");
    }
  }
}
