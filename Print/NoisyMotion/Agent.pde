class Agent {
  PVector p, pOld;
  float stepSize, angle;
  //float noiseScale, noiseStrength;
  
  public Agent(){
    p = new PVector(random(width), random(height));
    pOld = new PVector(p.x, p.y);
    stepSize = random(1,5); // How far does the particle travel each step //
//    noiseScale = 100;
//    noiseStrength = 360;
  }
  
  public void update1(){
    // Get new position //
    angle = noise(p.x/noiseScale, p.y/noiseScale)*noiseStrength;
    p.x += cos(radians(angle))*stepSize;
    p.y += sin(radians(angle))*stepSize;
    
    // Bounding Box //
    if(p.x < 0 || p.x > width || p.y < 0 || p.y > height){
      p = new PVector(random(width), random(height));
      pOld.set(p);
    }
    
    // Draw change in position //
//    stroke(angle,360,360);
    stroke(0,0,0,8);
    line(pOld.x, pOld.y, p.x, p.y);
    pOld.set(p);
  }
  
  public void update2(PGraphics pg){
    // Get new position //
    angle = noise(p.x/noiseScale, p.y/noiseScale)*noiseStrength;
    p.x += cos(radians(angle))*stepSize;
    p.y += sin(radians(angle))*stepSize;
    
    // Bounding Box //
    if(p.x < 0 || p.x > width || p.y < 0 || p.y > height){
      p = new PVector(random(width), random(height));
      pOld.set(p);
    }
    
    // Draw change in position //
//    stroke(angle,360,360);
    
    
    stroke(0,0,0,8);
    line(pOld.x, pOld.y, p.x, p.y);
    pg.stroke(0,0,0,8);
    float OldxL, xL, OldyL, yL;
    OldxL = map(pOld.x,0,width,0,pWidth);
    OldyL = map(pOld.y,0,height,0,pHeight);
    
    yL = map(p.y,0,height,0,pHeight);
    xL = map(p.x,0,width,0,pWidth);
    pg.line(OldxL, OldyL, xL, yL);
    pOld.set(p);
  }
}
