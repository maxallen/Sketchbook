// Mesh Crypto Decoded

int b,i,t,d,a,n,c,e = 0;

void setup() {
  size(500,500);
  /*
  println("B = " + str(b));
  println("I = " + str(i));
  println("T = " + str(t));
  println("D = " + str(d));
  println("A = " + str(a));
  println("N = " + str(n));
  println("C = " + str(c));
  println("E = " + str(e));
  */
//  println(1E6);
  frameRate(1);
}

void draw() {
  // Bounds n to [0,64)
  n=key&63;
  
  background(0);
  for(i=1; i < n*n; i++){
    // Get new psedo-random values
    a=f();
    b=f();
    c=f();
    d=f();
    
    // The higher the key alphabetically, the larget the distance between the points can be //
    e=int(n-dist(a,b,c,d));
    
    // Set line color
    stroke(255,e);
    
    // Draw Line //
    if(e>0){
      line(a,b,c,d);
    }
  }
}

int f(){
  
//  println("T= " + t);
  println("T= " + (t++%4));
  if (t%4 > 1 ){
    return int(500*noise(i/n,t%2*n+t/1000000.0));
  }else {
    return int(500*noise(i%n,t%2*n+t/1000000.0));
  }
  
//  return int(500*noise(t++%4>1?i/n:i%n,t%2*n+t/1000000.0));
  
  
}
