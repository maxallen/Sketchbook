int num = 5000;
int time;
int tfinal = 4000;
PVector[] pos = new PVector[num];
PVector[] vel = new PVector[num];
PVector[] acc = new PVector[num];

int PWidth = 2000;
int PHeight = 3000;

boolean useColor = false;

PGraphics sketch;
boolean record = false;

void setup(){
  time = 0;
  sketch = createGraphics(PWidth, PHeight);
  sketch.beginDraw();
  sketch.smooth();
  sketch.background(255);
  sketch.fill(255, 50);
  sketch.stroke(100, 255);
  for(int i = 0; i < num; i++) {
      pos[i] = new PVector(random(0, PWidth), random(0, PHeight));
      vel[i] = new PVector(0, 0);
      acc[i] = new PVector(0, 0);
  }
  noiseDetail(7);
  
  // ----------- //
  float R1 = random(0, 255);
  float R2 = random(0, 255);
  float G1 = random(0, 255);
  float G2 = random(0, 255);
  float B1 = random(0, 255);
  float B2 = random(0, 255);
  float noisy = .008;
  
  while (time < tfinal){
    for(int i = 0; i < num; i++) {
      if (useColor){
        sketch.stroke(R1, G1, B1, 10);
      }else{
        sketch.stroke(0,0,0,10);
      }
      sketch.point(pos[i].x, pos[i].y);
      vel[i].x = 10*noise(200+pos[i].x*.007, 200+pos[i].y*.007, noisy*2)*cos(4*PI*noise(pos[i].x*.007, pos[i].y*.007, noisy*.5));
      vel[i].y = 10*noise(200+pos[i].x*.007, 200+pos[i].y*.007, noisy*2)*sin(4*PI*noise(pos[i].x*.007, pos[i].y*.007, noisy*.5));
      pos[i].add(vel[i]);
      if(pos[i].x < 0 || pos[i].y < 0 || pos[i].x > PWidth || pos[i].y > PHeight){
        pos[i].x = random(0, PWidth);
        pos[i].y = random(0, PHeight);
        vel[i].x = 0;
        vel[i].y = 0;
      }
      acc[i].x = 0;
      acc[i].y = 0;
    }
    noisy += .007;
    time++;
  }
  
  sketch.endDraw();
  sketch.save(str(int(random(999)))+".tif");
  exit();
}

/*
void mousePressed(){
  R1 = random(0, 255);
  R2 = random(0, 255);
  G1 = random(0, 255);
  G2 = random(0, 255);
  B1 = random(0, 255);
  B2 = random(0, 255);
}
void keyPressed(){
  if(record){
    endRecord();
    record = false;
  }
}
*/

