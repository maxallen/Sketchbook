import java.util.*;

static int cubeSize = 4;
static int NUM_ITERATIONS = 100;
// pieces is a stack that will hold Piece objects of the cube //
// when pieces need to be popped off, pieces.pop() will return the piece to be reallocated //
Deque<Piece> pieces;
// directions is an arraylist containing all the possible directions to move in //
// this arraylist is copied for each of the loops (1-3) when making the pieces //
ArrayList<PVector> directions;
// availableBlocks is an arraylist containing all the available blocks to choose from 
// when choosing the next point for a piece to start from //
// when this list's length is zero, a solution has been found //
ArrayList<PVector> availableBlocks;
boolean[][][] cube;
int iterations;

void setup(){
  // Basics //
  size(600,600,P3D);
  pieces = new ArrayDeque<Piece>();
  directions = new ArrayList<PVector>();
  availableBlocks = new ArrayList<PVector>();
  cube = new boolean[cubeSize][cubeSize][cubeSize];
  iterations = 0;
  
  // Set up cube and availableBlocks // 
  for(int i=0; i<cubeSize; i++){
    for(int j=0; j<cubeSize; j++){
      for(int k=0; k<cubeSize; k++){
        availableBlocks.add(new PVector(i,j,k));
        cube[i][j][k] = false;
      }
    }
  }
  
  // Set up directions //
  for(int i=-1; i<=1; i++){
    for(int j=-1; j<=1; j++){
      for(int k=-1; k<=1; k++){
        directions.add(new PVector(i,j,k));
      }
    }
  }
  
  // Start the Brute Force Search //
//  while(availableBlocks.size() > 0){
  for(iterations = 0; iterations < NUM_ITERATIONS && availableBlocks.size() > 0; iterations++){
//    iterations++;
//    if(iterations > 200){
//      exit();
//    }
    println("Num available blocks: " + str(availableBlocks.size()));
    // Get random start position //
    PVector start = availableBlocks.get(int(random(availableBlocks.size())));
    makeOccupied(start);
    // Start Building Block //
    Piece p = new Piece(start);
    // Loop 1 //
    boolean successful1 = false;
    ArrayList<PVector> dirs = new ArrayList<PVector>(directions);
    while(dirs.size() > 0){
      PVector dir = dirs.remove(int(random(dirs.size())));
      PVector newPos = PVector.add(dir,start);
      if(!isOccupied(newPos)){
        // Add the block to the piece //
        p.addBlock(newPos);
        makeOccupied(newPos);
        
        // Loop 2 //
        println("Enter loop 2");
        boolean successful2 = false;
        ArrayList<PVector> dirs2 = new ArrayList<PVector>(directions);
        while(dirs2.size() > 0 ){
          PVector dir2 = dirs2.remove(int(random(dirs2.size())));
          PVector newPos2 = PVector.add(dir2,newPos);
          if(!isOccupied(newPos2)){
            p.addBlock(newPos2);
            makeOccupied(newPos2);
            
            // Loop 3 //
            println("Enter loop 3");
            boolean successful3 = false;
            ArrayList<PVector> dirs3 = new ArrayList<PVector>(directions);
            while(dirs3.size() > 0){
              PVector dir3 = dirs3.remove(int(random(dirs3.size())));
              PVector newPos3 = PVector.add(dir3,newPos2);
              if(!isOccupied(newPos3)){
                p.addBlock(newPos3);
                makeOccupied(newPos3);
                // Done? //
                println("Should say made piece");
                successful3 = true;
                break;
              }else{
                // Spot is occupied, go to the next iteration unless the size is now zero //
                if(dirs3.size() == 0){
                  // None of the blocks worked //
                  successful3 = false;
                  break;
                }
              }
            }
            // Successful or not?
            if(!successful3){
              p.popLastBlock();
            }else{
              // Successful //
              successful2 = true;
              break;
            }
          }else{
            // Either the spot is occupied or out of the cube grid //
            if(dirs2.size() == 0){
              successful2 = false;
              break;
            }
          }
        }
        // Successful or not?
        if(!successful2){
          p.popLastBlock();
        }else{
          successful1 = true;
          break;
        }
      }else{
        // Either the spot is occupied or out of the cube grid //
        if(dirs.size() == 0){
          successful1 = false;
          break;
        }
      }
    }
    // Successful or not?
    if(!successful1){
      // Piece is broken //
      p.popLastBlock();
      println("Piece blew up");
      // Should I pop a piece from the pieces Deque? //
    }else{
      // Sucessful Piece made //
      println("Piece made");
      pieces.push(p);
    }
  }

  noLoop();
  
}

public boolean isOccupied(PVector pos){
  if (pos.x < 0 || pos.x >= cubeSize || pos.y < 0 || pos.y >= cubeSize || pos.z < 0 || pos.z >= cubeSize){
    return true;
  }else{
    return cube[int(pos.x)][int(pos.y)][int(pos.z)];
  }
}

public void makeOccupied(PVector pos){
  if(cube[int(pos.x)][int(pos.y)][int(pos.z)]){
    println("Trying to occupy a taken spot");
    exit();
  }else{
    cube[int(pos.x)][int(pos.y)][int(pos.z)] = true;
    availableBlocks.remove(pos);
  }
}

// ----------------------------- //
// ---------Piece Class--------- //
// ----------------------------- //

class Piece {
  PVector[] blocks;
  int index;
  public Piece(PVector s){
    this.blocks = new PVector[cubeSize];
    this.blocks[0] = s.get();
    this.index = 1;
  }
  
  public void addBlock(int x, int y, int z){
    if(this.index == this.blocks.length){
      println("Abort. Index Error!!!");
      exit();
    }else{
      this.blocks[this.index] = new PVector(x,y,z);
      this.index++;
    }
  }
  
  public void addBlock(PVector v){
    if(this.index == this.blocks.length){
      println("Abort. Index Error!!!");
      exit();
    }else{
      this.blocks[this.index] = v.get();
      index++;
    }
  }
  
  public int getIndex(){
    return index;
  }
  
  public boolean notDone(){
    return this.index < cubeSize;
  }
  
  public PVector lastBlockPos(){
    return this.blocks[index-1];
  }
  
  public void popLastBlock(){
    index --;
    cube[int(this.blocks[index].x)][int(this.blocks[index].y)][int(this.blocks[index].z)] = false;
    availableBlocks.add(this.blocks[index].get());
  }
  
  public void reallocate(){
    // Make the blocks currently in the piece back to false in the cube //
    while(this.index >=0){
      cube[int(this.blocks[index].x)][int(this.blocks[index].y)][int(this.blocks[index].z)] = false;
      availableBlocks.add(this.blocks[index].get());
      index--;
    }
  }
  
  public String toString(){
    String ret = "Block Start:\n";
    for(int i=0; i<cubeSize; i++){
      ret = ret + this.blocks[i].toString();
    }
    ret = ret + "\nEnd Block\n";
    return ret;
  }
}
