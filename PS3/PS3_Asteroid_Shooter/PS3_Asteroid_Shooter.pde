// ---------------------- //
// Classic Arcade Shooter //  Pong Next???
//                        //
// Max Allen V 1.0        //
// ---------------------- //

import procontroll.*;
import java.io.*;

ControllIO controll;

ControllDevice PSController, XBController;
ControlStick PSLeftStick, PSRightStick, XBLeftStick, XBRightStick;


void setup() {
  size(600,600);
  background(255);
  
  // Device Setup //
  controll = ControllIO.getInstance(this);
  PSController = controll.getDevice("PLAYSTATION(R)3 Controller");
  XBController = controll.getDevice("Afterglow Gamepad for Xbox 360");
  
  
  // Stick Setup //
  PSLeftStick = PSController.getStick("y x"); // the stick name comes from the previous printSticks() command
  PSLeftStick.setTolerance(0.10f); // this indicates how much you must tilt the stick before it registers as a press
  PSRightStick = PSController.getStick("rz z");
  PSRightStick.setTolerance(0.10f);
  
  XBLeftStick = XBController.getStick(0);
  XBLeftStick.setTolerance(0.10f);
  XBRightStick = XBController.getStick(1);
  XBRightStick.setTolerance(0.10f);
  
  
  
}

void draw(){
  background(255);
  
  // Collision Detection //
  
  
  // Button Update //
  
  // Draw New Frame //
  
  
}
