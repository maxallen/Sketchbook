import nervoussystem.obj.*;
import java.lang.Math.*;

boolean record = false;

int thickness = 10;
float scale = 100.0;
float edge = scale*2;
float smallEdge = edge-2*thickness;
float phi = (1.0+sqrt(5))/2.0;
int numEdges = 10; // For drawing the cylinder //

ArrayList<Edge> edges;
ArrayList<PVector> vertexes;
PVector[] vertices; 

void setup() {
  size(600,600,P3D);
  rectMode(CENTER);
  edges = new ArrayList<Edge>();
  vertexes = new ArrayList<PVector>();
  vertices = getVertices(scale);
}

void draw() {
  background(255);
  
  if(record) {
    OBJExport obj = (OBJExport) createGraphics(10,10,"nervoussystem.obj.OBJExport","IcosaSkeleton.obj");
    obj.beginDraw();
    obj.rectMode(CENTER);
    drawNoise(obj);
    obj.endDraw();
    obj.dispose();
    record = false;
    println("OBJ Exported!");
  }
  translate(width/2,height/2,0);
  // rotate the canvas when the mouse moves
  rotateX(map(mouseY, 0, height, -PI/2, PI/2));
  rotateY(map(mouseX, 0, width, -PI/2, PI/2));
  drawNoise(this.g);
  edges.clear();
  vertexes.clear();
}

void drawNoise(PGraphics pg) {
  for(int i=0; i<vertices.length; i++){
    for(int j=i+1; j<vertices.length; j++){
      for(int k=j+1; k<vertices.length; k++){
        // If vertices are within radius distance //
        if((vertices[i].dist(vertices[j])) < edge+4.0 && (vertices[i].dist(vertices[k])) < edge +4.0 && (vertices[j].dist(vertices[k])) < edge + 4.0 ){
          // Draw 3 cylinders: //
          // Cylinder 1: From j to i//
          if(!drawnEdge(vertices[i],vertices[j])){
            // Draw edge //
            PVector ji = PVector.sub(vertices[i],vertices[j]);
            pg.pushMatrix();
            pg.translate(vertices[j].x,vertices[j].y,vertices[j].z);
            drawCylinder(pg,ji.get());
//            line(0,0,0,ji.x,ji.y,ji.z);
            pg.popMatrix();
            // Add edge to edges //
            edges.add(new Edge(vertices[i],vertices[j]));
          }
          
          // Cylinder 2: From k to i//
          if(!drawnEdge(vertices[i],vertices[k])){
            // Draw Edge //
            PVector ki = PVector.sub(vertices[i],vertices[k]);
            pg.pushMatrix();
            pg.translate(vertices[k].x,vertices[k].y,vertices[k].z);
            drawCylinder(pg,ki.get());
//            line(0,0,0,ki.x,ki.y,ki.z);
            pg.popMatrix();
            // Add edge to edges //
            edges.add(new Edge(vertices[i],vertices[k]));
          }
          
          // Cylinder 3: From k to j//
          if(!drawnEdge(vertices[j],vertices[k])){
            // Draw Edge //
            PVector kj = PVector.sub(vertices[j],vertices[k]);
            pg.pushMatrix();
            pg.translate(vertices[k].x,vertices[k].y,vertices[k].z);
            drawCylinder(pg,kj.get());
//            line(0,0,0,kj.x,kj.y,kj.z);
            pg.popMatrix();
            // Add edge to edges //
            edges.add(new Edge(vertices[j],vertices[k]));
          }
        }  
      }
    }
  }
  
  for(int i=0; i<vertices.length; i++){
    if(!drawnVertex(vertices[i])){
      pg.pushMatrix();
      pg.translate(vertices[i].x,vertices[i].y,vertices[i].z);
      pg.sphere(thickness);
      pg.popMatrix();
      vertexes.add(vertices[i]);
    }
  }
}

void drawCylinder(PGraphics pg, PVector ray){
  // Draw from (0,0,0) to (0,-mag,0), //
  float mag = ray.mag();
  
  // Rotate to the proper angle of edge //
  pg.pushMatrix();
  float r = sqrt(pow(ray.x,2) + pow(ray.y,2) + pow(ray.z,2));
  float theta = atan(ray.x/ray.z);
  float phi = acos(-ray.y/r);
  if(!isNaN(theta)){
    if(ray.z<0){
      pg.rotateY(PI+theta);
    }else{
      pg.rotateY(theta);
    }
  }
  pg.rotateX(-phi);
  
  // Draw Cylinder //
  // Bottom //
  pg.pushMatrix();
  pg.rotateX(-PI/2);
  pg.rect(0,0,thickness,thickness);
  pg.popMatrix();
  
  // Back //
  pg.pushMatrix();
  pg.translate(0,0,-thickness/2);
  pg.rotateY(PI);
  pg.rect(0,-mag/2,thickness,mag);
  pg.popMatrix();
  
  // Front //
  pg.pushMatrix();
  pg.translate(0,0,thickness/2);
  pg.rect(0,-mag/2,thickness,mag);
  pg.popMatrix();
  
  // Right Side //
  pg.pushMatrix();
  pg.rotateY(PI/2);
  pg.translate(0,0,thickness/2);
  pg.rect(0,-mag/2,thickness,mag);
  pg.popMatrix();
  
  // Left Side //
  pg.pushMatrix();
  pg.rotateY(-PI/2);
  pg.translate(0,0,thickness/2);
  pg.rect(0,-mag/2,thickness,mag);
  pg.popMatrix();
  
  // Top //
  pg.pushMatrix();
  pg.rotateX(PI/2);
  pg.translate(0,0,mag);
  pg.rect(0,0,thickness,thickness);
  pg.popMatrix();
  
  // End Cylinder //
  pg.popMatrix();
}

void keyPressed()
{
  if (key == 'r') {
    record = true;
    
  }
}

PVector[] getVertices(float s){
  float ph = phi*s;
  PVector[] ver = {new PVector(0,s,ph), new PVector(0,-s,ph), new PVector(0,s,-ph), new PVector(0,-s,-ph), new PVector(s,ph,0), new PVector(-s,ph,0), new PVector(s,-ph,0), new PVector(-s,-ph,0), new PVector(ph,0,s), new PVector(-ph,0,s), new PVector(ph,0,-s), new PVector(-ph,0,-s)};
  return ver;
}

public boolean drawnEdge(PVector a, PVector b){
  for(int i=0; i<edges.size(); i++){
    if(edges.get(i).sameEdgeAs(a,b)){
      return true;
    }
  }
  return false;
}

public boolean drawnVertex(PVector a){
  for(int i=0; i<vertexes.size(); i++){
    if(vertexes.get(i).equals(a)){
      return true;
    }
  }
  return false;
}

boolean isNaN(float x){return x != x;}
