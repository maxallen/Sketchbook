// Movers
int numMovers = 20;
Particle[] movers = new Particle[numMovers];

// Constant Forces
PVector wind = new PVector(.01,0);
Liquid liquid;

// Attraction 
Attractor a;
Particle p;
int G = 1;

void setup() {
  size(1000,600);
  ellipseMode(CENTER);
  a = new Attractor();
  p = new Particle(random(.5,2.0));
  /*
  liquid = new Liquid(0,height*(2.0/3),width,height/2,0.1);
  for (int i=0; i<numMovers; i++) {
    movers[i] = new Particle(random(.5,2.0));
  }
  */
}

void draw() {
  // Background //
  background(255);
  
  /* ------------------------------------------------------------ */
  /* -----------------PLAYING WITH ATTRACTION-------------------- */
  /* ------------------------------------------------------------ */
  
  PVector force = a.attract(p);
  p.applyForce(force);
  p.update();
  
  a.display();
  p.display();
  
  /* ------------------------------------------------------------ */
  /* -------------------PLAYING WITH FORCES---------------------- */
  /* ------------------------------------------------------------ */
  /*
  // Forces //
  PVector gravity;
  PVector friction;
  PVector drag;
  
  // Go through movers, apply forces, and update //
  for (int i=0; i<numMovers; i++) {
    gravity = new PVector(0,.1*movers[i].mass);
    
    friction = movers[i].velocity.get();
    friction.normalize();
    friction.mult(-1);
    float mu = 0.01;
    float normal = 1;
    float frictionMag = mu*normal;
    friction.mult(frictionMag);
    
    if (movers[i].isInside(liquid)) {
      movers[i].drag(liquid);
    }
    
    movers[i].applyForce(gravity);
//    movers[i].applyForce(wind);
    movers[i].applyForce(friction);
    
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
  
  liquid.display();
  */
}

/* -------------------------------------------------------- */
/* -------------------------------------------------------- */
/* -------------------------------------------------------- */

class Liquid {
  float x,y,w,h;
  float c; // Constant of drag 
  
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  void display() {
    noStroke();
    fill(10,20,150,100);
    rect(x,y,w,h);
  }
}

class Particle {
  // Variables //
  PVector location, velocity, acceleration;
  float mass;
  int radius;
  
  Particle(float m) {
    mass = m;
    radius = int(10*mass);
    
    location = new PVector(random(radius, width-radius),random(radius, height/2-radius));
    velocity = new PVector(random(0,2),random(0,2));
    acceleration = new PVector(0,0);
  }
  
  void update() {
    // Motion 101 updating velocity and location //
    velocity.add(acceleration);
    location.add(velocity);
    
    // Clear acceleration for next frame //
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void drag(Liquid l) {
    PVector drag = velocity.get();
    drag.normalize();
    drag.mult(-1);
    float speed = velocity.mag();
    float dragMagnitude = speed*speed* l.c;
    drag.mult(dragMagnitude);
    
    this.applyForce(drag);
  }
  
  void display() {
    stroke(0);
    fill(175);
    
    // Draw circle with radius 16 times its mass //
    ellipse(location.x, location.y, radius*2, radius*2);
  }
  
  void checkEdges() {
    if (location.x + radius > width) {
      location.x = width - radius;
      velocity.x = abs(velocity.x) * -1;
    } else if (location.x - radius < 0) {
      velocity.x = abs(velocity.x) * -1;
      location.x = radius;
    }
 
    if (location.y + radius > height) {
      velocity.y = abs(velocity.y) * -1;
      location.y = height - radius;
    }
  }
  
  boolean isInside(Liquid l) {
    if (location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y<l.y+l.h) {
      return true;
    }else {
      return false;
    }
  }
  
}

class Attractor {
  float mass;
  PVector location;
 
  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 20;
  }
  
  PVector attract(Particle p) {
    // Gravatational attraction formula //
    PVector force = PVector.sub(location, p.location);
    float distance = force.mag();
    distance = constrain(distance,5,25);
    force.normalize();
    float strength = (G*mass*p.mass) / (distance*distance);
    force.mult(strength);
    return force;
  }
 
  void display() {
    stroke(0);
    fill(175,200);
    ellipse(location.x,location.y,mass*2,mass*2);
  }
}
