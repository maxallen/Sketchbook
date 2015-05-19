import processing.opengl.*;

import igeo.*;
import igeo.p.*;
import igeo.io.*;
import igeo.gui.*;

void setup(){
  size(800,600, IG.GL);
  
  IPoint origin = new IPoint(0,0,0);
  IVec i = new IVec(1,0,0);
  IVec j = new IVec(0,1,0);
  IVec k = new IVec(0,0,1);
  
  new ISurface(origin, i, i.dup().add(k), k); // Right
  new ISurface(origin, j, j.dup().add(k), k); // Left
  new ISurface(origin, i, i.dup().add(j), j); // Bottom
  new ISurface(k, k.dup().add(i), k.dup().add(j.dup().add(i.dup())), k.dup().add(j)); // Top
  new ISurface(i, i.dup().add(j), k.dup().add(j.dup().add(i.dup())), i.dup().add(k)); // Back Right
  new ISurface(j, j.dup().add(i), k.dup().add(j.dup().add(i.dup())), j.dup().add(k)); // Back Left
  
  IG.save("test_output_file.obj");
}
