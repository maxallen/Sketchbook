int Max_Dist = 100;
ArrayList<Node> Nodes;
int time = 0;

void setup() {
  size(900,500);
  background(255);
  Nodes = new ArrayList<Node>();
}

void draw() {
  time++;
}

void mousePressed() {
  addNode();
}

void mouseDragged() {
  addNode();
}

void keyPressed(){
  if(key == 'c'){
    Nodes.clear();
  }
  if(key == 'r'){
    Nodes.clear();
    background(255);
  }
  if(key == 's'){
    saveFrame(str(int(random(1000)))+".jpg");
  }
}

void addNode(){
  if(time%5 == 0){
    // Creat node and add it to the Node list //
    float x = mouseX;
    float y = mouseY;
//    println("X: " + x + "     Y: " + y);
    Nodes.add(new Node(x,y));
    stroke(0);
    point(x,y);
    
    // Go through all nodes in the list //
    for(Node n : Nodes){
      // If the distance to the above node is less than the Max_Dist, draw a line with appropriate color //
      float d = dist(n.getX(),n.getY(),x,y);
      if(d <= Max_Dist){
//        stroke(d*(255.0/Max_Dist),30);
        stroke(0,80-(d*(80.0/Max_Dist)));
        line(x,y,n.getX(),n.getY());
      }
    }
    
    // Print total nodes to the screen //
    println(Nodes.size());
  }
}

class Node {
  PVector position;
  Node(float x, float y){
    position = new PVector(x,y);
  }
  
  float getX(){
    return position.x;
  }
  
  float getY(){
    return position.y;
  }
}
