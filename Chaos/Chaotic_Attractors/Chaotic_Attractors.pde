
int NUM_PARTICLES  = 10000;
int NUM_ATTRACTORS = 6;

Particle[] particle;
Attractor[] attractor;

float damp = 0.00002;
float accel = 10000;

int time = 0;
boolean run = true;

class Particle {
  float x,y,vx,vy;
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
  attractor = new Attractor[NUM_ATTRACTORS];
  particle = new Particle[NUM_PARTICLES];
  scatter();
//  strokeWeight(5);
  background(0);
}

void draw() {
  if(run){
//    if (time == 0){
//      for (int i=0; i < attractor.length; i++){
//        // Print a circle for the attractor //
//        stroke(255,255,0);
//        ellipse(attractor[i].x, attractor[i].y, 3,3);
//        println(attractor[i].x + "," + attractor[i].y);
//      }
//      time++;
//    }
    
    stroke(255,255,0,8);
    for (int j = 0; j < particle.length; j++) {
      particle[j].step();
    }
  }
}

void scatter() {
  background(0);
  stroke(255,255,0,8);
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
  if(key == 't'){
    run = !run;
  }
  if(key == 's'){
    saveFrame(str(int(random(1000)))+".png");
  }
}
