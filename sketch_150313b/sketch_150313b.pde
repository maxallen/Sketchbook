
int boxRadius = int(200/sqrt(2));
int circleRadius = 200;

PVector direction;
PVector newDirection;

void setup() {
  background(0);
  size(600,600);
  direction = new PVector(0,0);
  newDirection = new PVector(0,0);
  //newDirection.limit(circleRadius);
  
  ellipseMode(CORNER);
  stroke(255);
  noFill();
}

void draw() {
  background(0);
  stroke(255);
  // Draw Box //
  rect(width/2 - boxRadius, height/2 - boxRadius, 2*boxRadius, 2*boxRadius);
  
  // Draw Circle //
  ellipse(width/2 - circleRadius, height/2 - circleRadius, 2*circleRadius, 2*circleRadius);
  
  
  
  // Draw Mouse Vector //
  direction.x = mouseX - width/2;
  //print(direction.x + ",");
  direction.y = height/2 - mouseY;
  direction.limit(circleRadius);
  //println(direction.y);
  line(width/2,height/2,(width/2)+direction.x,(height/2)-direction.y);
  //println(direction.mag());
  
  // Get Angle //
  newDirection.x = direction.x;
  newDirection.y = direction.y;
  float theta = atan(abs(direction.y)/abs((float)direction.x));
  println(theta);
  //float scale = ((sqrt(2)-1)/2)*cos(4*theta)+1+((sqrt(2)-1)/2);
  //newDirection.mult(scale);
  float a = ((float)direction.x/boxRadius);
  //println(a);
  newDirection.x = circleRadius*sin(theta)*a;
  newDirection.y = newDirection.x*tan(theta);
  
  // Draw New Vector //
  stroke(255,0,0);
  line(width/2,height/2, (width/2)+newDirection.x,(height/2)-newDirection.y);
  
}
