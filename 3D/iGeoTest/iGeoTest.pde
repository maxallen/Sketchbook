import processing.opengl.*;

import igeo.*;
import igeo.p.*;
import igeo.io.*;
import igeo.gui.*;

void setup(){
  size(800,600, IG.GL);
  
//  new ICurve(0,0,0, 30,30,30);
//  new ICurve(0,-10,0, 30,10,20).clr(0.5,0,0);
//  new ICurve(0,-20,0, 30,-10,10).clr(1.0,0,0); // NOTE: float is put in clr()
//  new ICurve(0,-30,0, 30,-30,0).clr(1,0,0);

//  double[][] controlPoints1 =
//    {{0,0,0}, {20,20,20}, {-20,20,0}};
//  new ICurve(controlPoints1, 2); // degree = 2
//  
//  // degree 1 curve (polyline)
//  double[][] controlPoints2 = 
//    {{-60,-30,0}, {-60,-10,0}, {-40,-30,0}, {-40,-10,0}};
//  new ICurve(controlPoints2, 1).clr(0,1.,1.);
//  new ICurve(controlPoints2, 3).clr(0,1.,1.);
//  
//  // degree 2 curve
//  double[][] controlPoints4 = 
//    {{0,-30,0}, {0,-10,0}, {20,-30,0}, {20,-10,0}};
//  new ICurve(controlPoints4,2).clr(.5,0,1.);

  new ISurface(0,0,0, 40,40,40, 80,0,0, 40,-40,40);
  
  // 3 corner points (triangle)
  //new ISurface(-50,40,0, -10,40,0, -50,0,0).clr(0,0,1.);
  
  // rectangle
  //new ISurface(-50,-10,0, -10,-10,0, -10,-40,0, -50,-40,0).clr(0,1.,1.);
}
