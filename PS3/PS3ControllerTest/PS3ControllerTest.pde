import procontroll.*;
import java.io.*;

ControllIO controll;
ControllDevice device;
ControllStick stick1, stick2;
ControllButton button;

void setup(){
  size(400,400);
  
  controll = ControllIO.getInstance(this);

  device = controll.getDevice("PLAYSTATION(R)3 Controller");
  
  device.printSticks();
  
  stick1 = device.getStick("y x"); // the stick name comes from the previous printSticks() command
  stick1.setTolerance(0.10f); // this indicates how much you must tilt the stick before it registers as a press
  stick2 = device.getStick("rz z");
  stick2.setTolerance(0.10f);
  
  button = device.getButton("14"); // sets up the x button
}

void draw()
{
  background(255);

  float y1 = stick1.getX();
  y1 = map(y1,-1,1,0,height); 
  float x1 = stick1.getY();
  x1 = map(x1,-1,1,0,width);
  fill(255,0,0);
  ellipse(x1,y1,20,20);

  float y2 = stick2.getX();
  y2 = map(y2,-1,1,0,height); 
  float x2 = stick2.getY();
  x2 = map(x2,-1,1,0,width);
  fill(0,0,255);
  ellipse(x2,y2,20,20);


//Print cicle
//print(Yval1 + "        ");
//println(Xval1);
//float Yval2 = stick2.getX();
//println(Yval2);



//int leftStick = int(map(Yval1,-1,1,80,10));
//int rightStick = int(map(Yval2,-1,1,80,10));

}



