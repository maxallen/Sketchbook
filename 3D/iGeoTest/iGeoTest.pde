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

//  new ISurface(0,0,0, 40,40,40, 80,0,0, 40,-40,40);
//  
//  // 3 corner points (triangle)
//  new ISurface(-50,40,0, -10,40,0, -50,0,0).clr(0,0,1.);
//  
//  // rectangle
//  new ISurface(-50,-10,0, -10,-10,0, -10,-40,0, -50,-40,0).clr(0,1.,1.);

//  IVec[] cpts1 = new IVec[4];
//  
//  cpts1[0] = new IVec(-30, 10, 0);
//  cpts1[1] = new IVec(-10, 10, 0);
//  cpts1[2] = new IVec(-10, 30, 0);
//  cpts1[3] = new IVec(-30, 30, 0);
//  // curve 1 (red)
//  new ICurve(cpts1, 3).clr(1.,0,0);
//  
//  
//  IVec[] cpts2 = new IVec[10];
//  for(int i=0; i < cpts2.length; i++){
//    if(i%2==0){ cpts2[i] = new IVec(i*10, 0, 0); }
//    else{ cpts2[i] = new IVec(i*10, 10, 0); }
//  }
//  // curve 2 (blue)
//  new ICurve(cpts2, 1).clr(0,0,1.);
//  
//  IVec[] cpts3 = new IVec[16];
//  for(int i=0; i < cpts3.length; i++){
//    if(i%4==0){ cpts3[i] = new IVec(-30, -10, i*5); }
//    else if(i%4==1){ cpts3[i] = new IVec(-10, -10, i*5); }
//    else if(i%4==2){ cpts3[i] = new IVec(-10, -30, i*5); }
//    else{ cpts3[i] = new IVec(-30, -30, i*5); } // same with i%4==3
//  }
//  // curve 3 (cyan)
//  new ICurve(cpts3, 3).clr(0,1.,1.);

  IVec[][] cpts1 = new IVec[2][2];
  cpts1[0][0] = new IVec( 0, 0, 0);
  cpts1[1][0] = new IVec(-30, 0, 0);
  cpts1[0][1] = new IVec( 0,-30, 0);
  cpts1[1][1] = new IVec(-30,-30, 0);
  // surface 1 (gray)
  new ISurface(cpts1);
  
  IVec[][] cpts2 = new IVec[10][2];
  for(int i=0; i < cpts2.length; i++){
    if(i%2==0){
      cpts2[i][0] = new IVec(i*10,0,0);
      cpts2[i][1] = new IVec(i*10,0,20);
    }
    else{
      cpts2[i][0] = new IVec(i*10,-10,0);
      cpts2[i][1] = new IVec(i*10,10,10);
    }
  }
  // surface 2 (purple)
  new ISurface(cpts2).clr(.5,0,1);
  
  IVec[][] cpts3 = new IVec[4][4];
  for(int i=0; i < cpts3.length; i++){
    for(int j=0; j < cpts3[i].length; j++){
      if( (i==0||i==3) && (j==1||j==2) ){
        cpts3[i][j] = new IVec(-i*10, j*10, 20);
      }
      else{ cpts3[i][j] = new IVec(-i*10, j*10, 0); }
    }
  }
  // surface 3 (pink)
  new ISurface(cpts3,3,3).clr(1,.5,1);

}
