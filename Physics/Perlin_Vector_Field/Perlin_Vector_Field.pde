// Practice with Random Vector fields based on perlin noise //

int dim = 600;
float offset = 100.0;
int[][] bitMap; 

int numParticles;
Particle[] particles;

void setup() {
  size(dim,dim);
  ellipseMode(CENTER);
  background(255);
  stroke(0,50);
  
  // Populate the Bitmap vector field with brightness values //
  bitMap = new int[dim][dim];
  for(int i=0; i<dim; i++){
    for(int j=0; j<dim; j++){
      bitMap[i][j] = int(255*noise(i/offset,j/offset));
    }
  }
  
  // Add particles 
  numParticles = 200;
  particles = new Particle[numParticles];
  for(int i=0; i<numParticles; i++){
    particles[i] = new Particle(random(width),random(height));
  }
}

void draw() {
  // Display brightness field //
  /*
  loadPixels();
  for(int i=0; i<dim; i++){
    for(int j=0; j<dim; j++){
      pixels[width*i + j] = color(bitMap[i][j]);
    }
  }
  updatePixels();
  */
  
  // Move particles //
  for(int i=0; i<numParticles; i++){
    particles[i].update();
  }
}

class Particle {
  PVector location;
  PVector velocity;
  int rotation;
  
  Particle(float _x, float _y) {
    location = new PVector(_x,_y);
    velocity = new PVector(0,0);
    rotation = 0;
  }
  
  void update(){
    // Check location boundaries //
    if(int(location.x) < 0 || int(location.x) >= width || int(location.y) >= height || int(location.y) < 0){
      // Calculate new location //
      location.x = random(width);
      location.y = random(height);
    }
    
    // Calculate new velocity //
    int brit = bitMap[int(location.x)][int(location.y)];
    float rot = radians((brit/255.0)*360);
    velocity.x = cos(rot);
    velocity.y = sin(rot);
    velocity.normalize(); // Move 1 pixel each frame //
    
    location.add(velocity);
    this.display();
  }
  
  void display(){
    point(location.x,location.y);
  }
}
