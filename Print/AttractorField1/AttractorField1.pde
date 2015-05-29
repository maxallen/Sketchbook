int NUM_ATTRACTORS = 5;
int NUM_PARTICLES = 10000;

Attractor[] attractors = new Attractor[NUM_ATTRACTORS];
Node[] nodes = new Node[NUM_PARTICLES];

void setup(){
  size(600,600);
  initGrid();
  background(255);
  stroke(0,20);
}

void draw(){
//  background(255,.1);
  for(int i=0; i<NUM_ATTRACTORS; i++){
    for(int j=0; j<NUM_PARTICLES; j++){
      attractors[i].attract(nodes[j]);
    }
//    ellipse(attractors[i].position.x,attractors[i].position.y,10,10);
  }
  
  for(int i=0; i<NUM_PARTICLES; i++){
    nodes[i].update();
//    point(nodes[i].x,nodes[i].y);
  }
  
}

void initGrid(){
  for(int i=0; i<NUM_ATTRACTORS; i++){
    attractors[i] = new Attractor(random(width),random(height),random(150,250));
  }
  for(int i=0; i<NUM_PARTICLES; i++){
    nodes[i] = new Node(random(width),random(height),random(-1,1),random(-1,1));
  }
}
