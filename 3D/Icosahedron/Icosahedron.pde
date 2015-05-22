import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import unlekker.data.*;
import unlekker.mb2.externals.*;
import java.util.*;

int thickness = 10;
float scale = 100.0;
float edge = scale*2;
float smallEdge = edge-2*thickness;
float phi = (1.0+sqrt(5))/2.0;

UGeo model;


void setup(){
  size(800,800,P3D);
  stroke(0);
//  noFill();
  fill(230);
  UMB.setGraphics(this);
  buildModel();
}

void draw(){
  background(255);
  translate(width/2 , height/2, 0);
  
  // rotate the canvas when the mouse moves
  rotateX(map(mouseY, 0, height, -PI/2, PI/2));
  rotateY(map(mouseX, 0, width, -PI/2, PI/2));
  
  model.draw();
//  model.drawNormals(20.0);
}

void keyPressed(){
  if (key == 's'){
    model.writeSTL("/Users/maxallen/Documents/Processing/Sketchbook/3D/Icosahedron/Icosahedron.stl");
    println("STL written");
  }
}

void buildModel(){
  model = new UGeo();
  // This builds a hollow model with solid walls //
  UVertexList outerVertices = getVertices(scale);
  UVertexList innerVertices = getVertices(scale-thickness);
  
  // Method 1 //
//  UTriangulate outTri = new UTriangulate(outerVertices);
//  UTriangulate inTri = new UTriangulate(innerVertices);
  
  // Method 2 //
//  UGeo outerModel = model.triangulation(outerVertices);
//  UGeo innerModel = model.triangulation(innerVertices);
  
  // Method 3 //
  for(int i=0; i<outerVertices.size(); i++){
    for(int j=i+1; j<outerVertices.size(); j++){
      for(int k=j+1; k<outerVertices.size(); k++){
        // If vertices are within radius distance //
        if( (outerVertices.get(i).dist(outerVertices.get(j))) < edge+1.0 && (outerVertices.get(i).dist(outerVertices.get(k))) < edge +1.0 && (outerVertices.get(j).dist(outerVertices.get(k))) < edge + 1.0 ){
          model.addFace(outerVertices.get(i), outerVertices.get(j), outerVertices.get(k));
        }  
      }
    }
  }
  
  for(int i=0; i<innerVertices.size(); i++){
    for(int j=i+1; j<innerVertices.size(); j++){
      for(int k=j+1; k<innerVertices.size(); k++){
        if( (innerVertices.get(i).dist(innerVertices.get(j))) < (smallEdge)+1.0 && (innerVertices.get(i).dist(innerVertices.get(k))) < (smallEdge)+1.0 && (innerVertices.get(j).dist(innerVertices.get(k))) < (smallEdge)+1.0 ){
          UFace f = new UFace(innerVertices.get(i), innerVertices.get(j), innerVertices.get(k));
          f.reverse();
          model.addFace(f);
          
          println("Inner face added.");
        }
      }
    }
  }
  
  // Method 1//
//  model.add(outTri.mesh);
//  model.add(inTri.mesh);

  // Method 2//
//  model.add(outerModel);

  println("Number of Faces:");
  print(model.sizeF());
}

UVertexList getVertices(float s){
  float ph = phi*s;
  UVertexList ver = new UVertexList();
  UVertex[] verts = {new UVertex(0,s,ph), new UVertex(0,-s,ph), new UVertex(0,s,-ph), new UVertex(0,-s,-ph), new UVertex(s,ph,0), new UVertex(-s,ph,0), new UVertex(s,-ph,0), new UVertex(-s,-ph,0), new UVertex(ph,0,s), new UVertex(-ph,0,s), new UVertex(ph,0,-s), new UVertex(-ph,0,-s)};
  ver.add(verts);
  return ver;
}


