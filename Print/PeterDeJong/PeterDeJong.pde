float x,y,xn,yn;
float a,b,c,d,a0,b0,c0,d0;
float i,j,k,l;
PGraphics pg;
int pWidth = 3200;
int pHeight = 2000;
int numIts = 0;

boolean variation = false;
int numSketch = 0;
boolean record = false;
boolean useColor = false;
boolean DEBUG = false;

void setup(){
  size(800,500);
  x = random(1);
  y = random(1);
  
  
  // Ring //
  if(variation){
  a0 = 1.40;
  b0 = 1.56;
  c0 = 1.40;
  d0 = -6.56;
  }else{
    switch(numSketch){
      case 1:
        // Variation 1: Shell //
        a0 = -0.709;
        b0 = 1.638;
        c0 = 0.452;
        d0 = 1.740;
        break;
      case 2:
        a0 = 1.4;
        b0 = -2.3;
        c0 = 2.4;
        d0 = -2.1;
        break;
      case 3:
        a0 = 0.55906534;
        b0 = -1.8964622;
        c0 = 2.1276922;
        d0 = -1.5523964;
        break;
      case 4:
        a0 = 0.7570813;
        b0 = -2.1255865;
        c0 = -1.8610203;
        d0 = -2.1480603;
        break;
      case 5:
        a0 = -2.0;
        b0 = -2.0;
        c0 = -1.2;
        d0 = 2.0;
        break;
      case 6:
        a0 = 1.2053893;
        b0 = 2.3183727;
        c0 = -0.23930073;
        d0 = -2.217876;
        break;
//      case 7: // Occupies Mostly Left side //
//      a0 = -1.6819336;
//      b0 = 0.16984177;
//      c0 = -2.3834083;
//      d0 = 2.2350268;
//      break;
      default:
        a0 = random(-2.5,2.5);
        b0 = random(-2.5,2.5);
        c0 = random(-2.5,2.5);
        d0 = random(-2.5,2.5);
        break;
    }
  
  }
  
  a = a0;
  b = b0;
  c = c0;
  d = d0;
  
  if(record){
    pg = createGraphics(pWidth, pHeight);
    pg.beginDraw();
    pg.background(255);
    if(useColor){
      pg.stroke(161,76,0,3);
    }else{
      pg.stroke(0,0,0,5);
    }
    
  }
  
  background(255);
  if(useColor){
    stroke(161,76,0,3);
  }else{
    stroke(0,0,0,3);
  }
  
  println("A: " + str(a));
  println("B: " + str(b));
  println("C: " + str(c));
  println("D: " + str(d));
  println();
}

void draw(){
  numIts++;
  for(int m=0; m<100000; m++){
    if(!variation){
      // Peter de Jong //
      xn = sin(a*y) - cos(b*x);
      yn = sin(c*x) - cos(d*y);
      
      x = xn;
      y = yn;
      
      i = map(x,-2.1,2.1,0,width);
      j = map(y,-2.1,2.1,0,height);
      
      // Variation 1 //
//      i = map(x,-1.4,1.4,0,width);
//      j = map(y,-1.7,1.,0,height);
      
      if(record){
        k = map(x,-2.1,2.1,0,pWidth);
        l = map(y,-2.1,2.1,0,pHeight);
        // Variation 1 bounds //
//        k = map(x,-1.4,1.4,0,pWidth);
//        l = map(y,-1.7,1.,0,pHeight);
        pg.point(k,l);
      }
      if(m == 0 && DEBUG){
        println("Point: (" + str(i) + "," + str(j) + ")");
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
        pg.point(k,l);
      }
      
      point(i,j);
    }
  }
  if(numIts%21 == 20){
    if(record){
      println("Saved Frame: " + str(numIts));
      pg.endDraw();
  //    pg.save(str(int(random(1000)))+"_" + str(numIts) + ".tif");
      pg.save("a"+str(a0)+"b"+str(b)+"c"+str(c)+"d"+str(d)+"/"+str(numIts)+".tif");
      pg.beginDraw();
    }
  }
}

void mouseClicked(){
  background(255);
  if(record){
    pg.background(255);
  }
  println("Redraw");
  x = random(1);
  y = random(1);
  
  // Ring //
  if(variation){
  a0 = 1.40;
  b0 = 1.56;
  c0 = 1.40;
  d0 = -6.56;
  }else{
    switch(numSketch){
      case 1:
        // Variation 1: Shell //
        a0 = -0.709;
        b0 = 1.638;
        c0 = 0.452;
        d0 = 1.740;
        break;
      case 2:
        a0 = 1.4;
        b0 = -2.3;
        c0 = 2.4;
        d0 = -2.1;
      default:
        a0 = random(-2.5,2.5);
        b0 = random(-2.5,2.5);
        c0 = random(-2.5,2.5);
        d0 = random(-2.5,2.5);
        break;
    }
  
  }
  
  a = a0;
  b = b0;
  c = c0;
  d = d0;
  println("A: " + str(a));
  println("B: " + str(b));
  println("C: " + str(c));
  println("D: " + str(d));
  println();
}

void keyPressed(){
  if(key == 's'){
    if(record){
      pg.endDraw();
  //    pg.save(str(int(random(1000)))+"_" + str(numIts) + ".tif");
      pg.save("a"+str(a0)+"b"+str(b)+"c"+str(c)+"d"+str(d)+"/"+str(numIts)+".tif");
      pg.beginDraw();
      println("Frame Saved");
    }
  }
}
