float x,y,xn,yn;
float a,b,c,d,a0,b0,c0,d0;
float i,j,k,l;
PGraphics p;
int pWidth = 3200;
int pHeight = 2000;

boolean variation = false;
boolean record = false;
boolean useColor = false;

void setup(){
  size(800,500);
  x = random(1);
  y = random(1);
//  a = random(-2.5,2.5);
//  b = random(-2.5,2.5);
//  c = random(-2.5,2.5);
//  d = random(-2.5,2.5);
  
  // Ring //
//  a = 1.40;
//  b = 1.56;
//  c = 1.40;
//  d = -6.56;

  a0 = -0.709;
  b0 = 1.638;
  c0 = 0.452;
  d0 = 1.740;
  
  a = a0;
  b = b0;
  c = c0;
  d = d0;
  
  if(record){
    p = createGraphics(pWidth, pHeight);
    p.beginDraw();
    p.background(255);
    if(useColor){
      p.stroke(161,76,0,3);
    }else{
      p.stroke(0,5);
    }
  }
  background(255);
  if(useColor){
    stroke(161,76,0,3);
  }else{
    stroke(0,3);
  }
  
  println("A: " + str(a));
  println("B: " + str(b));
  println("C: " + str(c));
  println("D: " + str(d));
  println();
}

void draw(){
  for(int m=0; m<100000; m++){
    if(!variation){
      xn = sin(a*y) - cos(b*x);
      yn = sin(c*x) - cos(d*y);
      
      x = xn;
      y = yn;
      
      i = map(x,-2.1,2.1,0,width);
      j = map(y,-2.1,2.1,0,height);
      
      if(record){
        k = map(x,-2.1,2.1,0,pWidth);
        l = map(y,-2.1,2.1,0,pHeight);
        p.stroke(k,l);
      }
      
      point(i,j);
    }else{
      xn = d*sin(a*x) - sin(b*y);
      yn = c*cos(a*x) + cos(b*y);
      
      x = xn;
      y = yn;
      
      i = map(x,d-1.1,-d+1.1,0,width);
      j = map(y,-c-1.1,c+1.1,0,height);
      
      if(record){
        k = map(x,d-1.1,-d+1.1,0,pWidth);
        l = map(y,-c-1.1,c+1.1,0,pHeight);
        p.point(k,l);
      }
      
      point(i,j);
    }
  }
  println("looped");
}

void mouseClicked(){
//  setup();
  println("Redraw");
  x = random(1);
  y = random(1);
}

void keyPressed(){
  if(key == 's'){
    p.endDraw();
    p.save(str(int(random(1000)))+".tif");
    p.beginDraw();
  }
}
