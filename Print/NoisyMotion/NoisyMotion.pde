PGraphics pg;
int pWidth = 2000;
int pHeight = 2000;
boolean record = true;

int NUM_AGENTS = 10000;
float noiseScale, noiseStrength;
int noiseDetail, noiseSeed;
Agent[] agents = new Agent[NUM_AGENTS];

void setup(){
  size(600,600);
  if(record){
    pg = createGraphics(pWidth,pHeight);
    pg.beginDraw();
    pg.background(255);
    pg.stroke(0,10);
  }
  
//  colorMode(HSB,360);
  for(int i=0; i<NUM_AGENTS; i++){
    agents[i] = new Agent();
  }
  
  noiseStrength = 360.0;
  noiseScale = 1000.0;
  noiseDetail = 7;
  noiseSeed = int(random(1000));
  noiseSeed(noiseSeed);
  println("Noise Seed: " + str(noiseSeed));
  noiseDetail(noiseDetail);
  
//  background(color(0,0,360));
  background(255);
  stroke(0,10);
  textSize(12);
  
  frameRate(20);
}

void draw(){
//  noFill();
//  stroke(0,20);
  if(record){
    for(int i=0; i<NUM_AGENTS; i++){
      agents[i].update2(pg);
    }
  }else{
    for(int i=0; i<NUM_AGENTS; i++){
      agents[i].update1();
    }
  }
  fill(255,255,255);
  rect(0,height-70, 170, height);
  fill(255,0,0);
  text("Noise Detail (+/-): " + str(noiseDetail), 10,height-10);
  text("Noise Scale (>/<): " + str(noiseScale), 10, height-30);
  text("Noise Strength (^/v): " + str(noiseStrength), 10,height-50);
}

void mouseClicked(){
  background(255);
  if(record){
    pg.background(255);
  }
}

void keyPressed(){
  // Change noiseDetail //
  if(key == '='){
    noiseDetail++;
  }else if(key == '-'){
    noiseDetail--;
  }
  // Change noiseStrength //
  if(keyCode == UP){
    noiseStrength += 5.0;
  }else if(keyCode == DOWN){
    noiseStrength -= 5.0;
  }
  
  // Change noiseScale
  if(keyCode == RIGHT){
    noiseScale *= 1.3;
  }else if(keyCode == LEFT){
    noiseScale *= .7;
  }
  
  if(key == 'r'){
    noiseSeed = int(random(1000));
    println("Noise Seed: " + str(noiseSeed));
    noiseSeed(noiseSeed);
  }
  
  if(key == 's'){
    if(record){
      pg.endDraw();
      pg.save(str(int(random(1000)))+".tif");
      pg.beginDraw();
      println("Frame Saved");
    }
  }
}
