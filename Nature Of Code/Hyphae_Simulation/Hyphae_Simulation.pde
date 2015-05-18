
// Create an array of Nodes (food) //
int numFood = 50;
Node[] food = new Node[numFood];

// Create an ArryList of Hyphae //
ArrayList<Hypha> Hyphae;

int time = 0;

void setup() {
  size(500,500);
  background(255);
  frameRate(5);
  ellipseMode(CENTER);
  initialize();
}

void initialize() {
  // Make randomized food array
  for (int i=0; i<food.length; i++) {
    food[i] = new Node(random(0,width),random(0,height));
    food[i].display();
  }
  // Make an ArrayList with one hypha in it to start //
  Hyphae = new ArrayList<Hypha>();
  Hyphae.add(new Hypha(width/2,height, new PVector(0,-1)));
}

void draw() {
  time++;
  for( int i=Hyphae.size()-1; i>=0; i--) {
    Hyphae.get(i).update();
  }
//  println(time);
}

class Hypha {
  PVector prevLoc;
  PVector location;
  PVector direction;
  boolean isAlive;
  
  Hypha (float x, float y, PVector direction_) {
    prevLoc = new PVector(x,y);
    location = new PVector(x,y);
    direction = direction_.get();
    isAlive = true;
  }
  
  void calcDir() {
    // Find all the food particles within 30 degrees of the direction (15 degrees on either side) //
    // If there are no food particles, then the Hypha dies //
    
    int bestNodeIndex = -1;
    float distFromNode = 100000.0; // Set to rediculously high number //
    for(int i=0; i<food.length; i++) {
      if(!food[i].isEaten() && dist(food[i].location.x,food[i].location.y,location.x,location.y) < distFromNode) {
        bestNodeIndex = i;
        distFromNode = dist(food[i].location.x,food[i].location.y,location.x,location.y);
        break;
      }
    }
    
    if(bestNodeIndex == -1) {
      // If there are no more food particles left,
      // keep the same direction and stop the draw loop
      noLoop();
      return;
    }else{
      // Use the closest node to calculate the direction of the Hypha //
      PVector curr = direction.get();
      curr.mult(40);
      PVector currNode = new PVector(food[bestNodeIndex].location.x-location.x,food[bestNodeIndex].location.y-location.y);
      direction = PVector.add(curr,currNode); // Vector will be normalized later in loop
    }
  }
  
  void update() {
    if(isAlive){
      // Update the direction and location //
      calcDir();
      prevLoc.x = location.x;
      prevLoc.y = location.y;
      direction.normalize();
      direction.mult(5.0);
      location.add(direction);
      
      // Check for branching //
      checkBranching();
      
      // Display //
      display();
    }
  }
  
  void checkBranching() {
    // If the Node is close enough to a Food source, it branches //
    for (int i=0; i<food.length; i++) {
      // Check distance for Food a distance of 30 or less and whether it is not eaten//
      if(dist(food[i].location.x,food[i].location.y,location.x,location.y) <= 30.0 && !food[i].isEaten()) {
        // Make new Hypha //
        // Get the direction toward the food particle
        PVector dirToFood = new PVector(food[i].location.x-location.x,food[i].location.y-location.y);
        Hypha h = new Hypha(location.x,location.y,dirToFood);
        Hyphae.add(h);
        
        // Mark this food particle as eaten //
        food[i].eaten();
        break;
      }
    }
  }
  
  void display() {
    // Draw a line from last point to this point //
    stroke(0,0,0,50);
    line(prevLoc.x, prevLoc.y, location.x, location.y);
    println("(" + location.x + "," + location.y + ")");
  }
}

class Node {
  PVector location;
  boolean eaten;
  
  Node(float x, float y) {
    location = new PVector(x,y);
    eaten = false;
  }
  
  boolean isEaten() {
    return eaten;
  }
  
  void eaten() {
    eaten = true;
  }
  
  void display() {
    // Cirlce with radius 1 //
    ellipse(location.x,location.y,2,2);
  }
}
