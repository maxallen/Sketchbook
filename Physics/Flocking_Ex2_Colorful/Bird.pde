class BirdObject
{
  PVector pos;
  boolean viewBackwards=false; // optional "flipping" of viewing direction (= 180 degree offset)
  boolean bounce=false;        // if on, birds turn around at the boarder, else they warp around.
  float viewAngle = 25;        // opening half-angle of view
  float viewDistance = 100;    // Dinstance of view
  float dirAngle=0;            // direction of birds
  float offsetAngle=0;         // offset of direction to be added to flying direction => direction of view
  float randomDirAngle=radians(random(4)+-2);  // magnitude of random direction changes
  float randomSpeedChange=random(1)-0.5;       // magnitude of random speed changes
  int unrest=10;                                // % chance of random changes
  float speed=0;
  float minSpeed=1;                            // lower speed limit
  float maxSpeed=3;                            // upper speed limit
  float BirdSize=10;                           // drawing size of bird
  float dampSpeed=0.3;                         // damping of speed adjustment (multiplicative to difference)
  float dampDir=0.25;                           // damping of directioin adjustment (multiplicative to difference)
  int   adjustmentMode=3;                      // mode of calculating the adjustment. 1=adapt to closest, 2=adapt to furtherst; 3=adapt to mean;
  float SpeedDiff;
  float AngleDiff;
  color col;
  color storCol;
  BirdObject(float inX, float inY,color inCol,float inSPEED, float inDirAngle)
  {
    pos = new PVector(inX,inY); storCol=inCol; speed = inSPEED;  dirAngle=inDirAngle;    
  }
  boolean CheckVisible(PVector ObjectPos)
    {
      PVector dir = new PVector(cos(dirAngle+offsetAngle),sin(dirAngle+offsetAngle));
      if (viewBackwards) dir.mult(-1);
      if ((degrees(PVector.angleBetween( PVector.sub(ObjectPos,pos),dir))<=viewAngle) && (pos.dist(ObjectPos)<viewDistance)) return true;
      return false;
    }
  void CheckGroup(ArrayList Others)
  {
     // find "closest other bird in view"
     boolean found=false;
     float count=0;
     BirdObject ClosestBird = new BirdObject(0,0,0,0,0);
     if (adjustmentMode==1) ClosestBird = new BirdObject(width*10,height*10,0,0,0);  //dummybird out of range = new BirdObject(width*10,height*10,0,0,0);  //dummybird out of range
     if (adjustmentMode==2) ClosestBird = new BirdObject(pos.x,pos.y,0,50,0);  //dummybird out of range = new BirdObject(width*10,height*10,0,0,0);  //dummybird out of range
     SpeedDiff=0;
     AngleDiff=0;
     col = color(0,150,0);
     for (int i=0; i<Others.size();i++)
       {
         BirdObject Test = (BirdObject) Others.get(i);
         if (Test!=this) if(CheckVisible(Test.pos))
           {
             found=true;
             if (adjustmentMode==1) if (pos.dist(ClosestBird.pos) >  pos.dist(Test.pos) ) ClosestBird=Test;
             if (adjustmentMode==2) if (pos.dist(ClosestBird.pos) <= pos.dist(Test.pos) ) ClosestBird=Test;
             if (adjustmentMode==3)
               {
                 count+=pos.dist(Test.pos);
                 SpeedDiff+=Test.speed*pos.dist(Test.pos);
                 float calc = Test.dirAngle-dirAngle;
                 if (calc>PI) calc-=TWO_PI;
                 if (calc<-PI) calc+=TWO_PI; 
                 AngleDiff+=calc*pos.dist(Test.pos);
               }
             col =  storCol;
           }
       }
     if (found)
       {
         if (adjustmentMode==3)
         {
          SpeedDiff*=1/count;
          SpeedDiff-=speed;
          AngleDiff*=1/count;
         }
         else
         {
          SpeedDiff = ClosestBird.speed-speed;
          AngleDiff = ClosestBird.dirAngle-dirAngle;
         }
       }
     if (AngleDiff>PI) AngleDiff-=TWO_PI;
     if (AngleDiff<-PI) AngleDiff+=TWO_PI; 
  }
  void Adjust()
  {
    speed+=dampSpeed*SpeedDiff;
    dirAngle+=dampDir*AngleDiff;
    if (dirAngle>=TWO_PI) dirAngle-=TWO_PI;     
    if (dirAngle<0) dirAngle+=TWO_PI;   
  }
  void Move()
    {
      PVector moveStep = new PVector(cos(dirAngle),sin(dirAngle));
      moveStep.mult(speed);
      pos.add(moveStep);
      // check boarder condition
      if ( (pos.x<0)||(pos.x>=width)||(pos.y<0)||(pos.y>=height) )
        {
          if (bounce)
          {
            // Reset the last move
              speed*=-1;
              this.Move();
              speed*=-1;
            // try turning
            if (random(100)<50) dirAngle+=radians(90);
            else dirAngle-=radians(90);
          }
          else
          {
            if (pos.x<0) pos.x+=width;
            if (pos.x>=width) pos.x-=width;
            if (pos.y<0) pos.y+=height;
            if (pos.y>=height) pos.y-=height;
          }
        }
      // RandomChange the movement
      if (random(100)<unrest)
        {
          dirAngle+=randomDirAngle;
          randomDirAngle+=radians(random(1)-0.5);
          if (randomDirAngle>PI/32) randomDirAngle=-1*random(PI/32);
          if (randomDirAngle<-PI/32) randomDirAngle=random(PI/32);
          speed += randomSpeedChange;
          randomSpeedChange += 0.05-random(0.1);
          randomSpeedChange = constrain(randomSpeedChange,-0.3,0.3);
          speed = constrain(speed,minSpeed,maxSpeed);
        }
    }
  void Draw(boolean DrawBird, boolean DrawView)
  {
    PVector dir;
    if (DrawView) 
    {    
      strokeWeight(1);
      if (adjustmentMode==1)          // adapt to closest bird
        {
        fill(color(255,255,0,50));
        stroke(color(250,250,050,100));
        }
      if (adjustmentMode==2)          // adapt to most distant bird
        {
        fill(color(255,0,255,50));
        stroke(color(250,050,250,100));
        }
      if (adjustmentMode==3)          // adapt to mean
        {
        fill(color(0,255,255,50));
        stroke(color(050,250,250,100));
        }
      if (viewBackwards)
          {
            dirAngle+=PI;
            if (dirAngle>=TWO_PI) dirAngle-=TWO_PI;
          }
      dir = new PVector(cos(dirAngle+offsetAngle+radians(viewAngle)),sin(dirAngle+offsetAngle+radians(viewAngle)));
      dir.mult(viewDistance);
      line(pos.x,pos.y,pos.x+dir.x,pos.y+dir.y);
      dir = new PVector(cos(dirAngle+offsetAngle-radians(viewAngle)),sin(dirAngle+offsetAngle-radians(viewAngle)));
      dir.mult(viewDistance);
      line(pos.x,pos.y,pos.x+dir.x,pos.y+dir.y);
      arc(pos.x,pos.y,viewDistance*2,viewDistance*2,dirAngle+offsetAngle-radians(viewAngle),dirAngle+offsetAngle+radians(viewAngle));
      if (viewBackwards)
          {
            dirAngle+=PI;
            if (dirAngle>=TWO_PI) dirAngle-=TWO_PI;
          }
    }
    if (DrawBird)
    {
       
      dir = new PVector(cos(dirAngle),sin(dirAngle));
      strokeWeight(1);
      fill(col);
      stroke(col);
      beginShape();
        vertex(pos.x+dir.x*BirdSize,pos.y+dir.y*BirdSize);
        vertex(pos.x-dir.y*BirdSize*0.3,pos.y+dir.x*BirdSize*0.3);
        vertex(pos.x+dir.y*BirdSize*0.3,pos.y-dir.x*BirdSize*0.3);
      endShape();
    }
  }
     
}

