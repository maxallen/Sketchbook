int NUM_AGENTS = 5000;
float noiseScale, noiseStrength;
int noiseDetail;
Agent[] agents = new Agent[NUM_AGENTS];

void setup(){
  size(600,600);
//  colorMode(HSB,360);
  for(int i=0; i<NUM_AGENTS; i++){
    agents[i] = new Agent();
  }
  
  noiseStrength = 360.0;
  noiseScale = 1000.0;
  noiseDetail = 7;
  noiseDetail(noiseDetail);
  
//  background(color(0,0,360));
  background(255);
  stroke(0,20);
  textSize(12);
  
  frameRate(20);
}

void draw(){
//  noFill();
//  stroke(0,20);
  for(int i=0; i<NUM_AGENTS; i++){
    agents[i].update1();
  }
  
  fill(255,0,0);
  text("Noise Detail (+/-): " + str(noiseDetail), 10,height-10);
  text("Noise Scale (>/<): " + str(noiseScale), 10, height-30);
  text("Noise Strength (^/v): " + str(noiseStrength), 10,height-50);
}

void mouseClicked(){
  background(255);
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
}
