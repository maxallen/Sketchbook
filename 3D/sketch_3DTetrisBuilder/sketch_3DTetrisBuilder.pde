static int num = 4;
boolean found = false;
int iterat = 0;
static int maxIterations = 5;
ArrayList<PVector> dirs = new ArrayList<PVector>();
ArrayList<PVector> availableBlocks = new ArrayList<PVector>();
ArrayList<Piece> pieces = new ArrayList<Piece>();
ArrayList<Integer> pieceIteration = new ArrayList<Integer>();
boolean[][][] cube = new boolean[num][num][num];

void setup(){
  
  for(int i=0; i<cube.length; i++){
    for(int j=0; j<cube[0].length; j++){
      for(int k=0; k<cube[0][0].length; k++){
        cube[i][j][k] = false;
        availableBlocks.add(new PVector(i,j,k));
      }
    }
  }
  
  
  dirs.add(new PVector(1,0,0));
  dirs.add(new PVector(0,1,0));
  dirs.add(new PVector(0,0,1));
  dirs.add(new PVector(-1,0,0));
  dirs.add(new PVector(0,-1,0));
  dirs.add(new PVector(0,0,-1));
  
  while(!found){
    PVector pos = getRandomPosition();
    Piece p = makePiece(pos);
    if(p == null){
      // Oh shit //
      println("Couldn't Make Piece");
  //    exit();
      
      // Should end up popping the last piece off the pieces stack if the iterations are too high //
      int s = pieceIteration.size();
      int pinum = pieceIteration.get(s-1);
      if(pinum >= maxIterations){
        // Pop //
        Piece p2 = pieces.remove(s-1);
        p2.reallocate();
        pieceIteration.remove(s-1);
      }else{
        // Don't Pop //
        pieceIteration.set(s-1, pinum+1);
        continue;
      }
      Piece p2 = pieces.remove(s-1);
      p2.reallocate();
    }else{
      // Need to store iteration information //
      pieces.add(p);
      pieceIteration.add(1);
    }
    
    if(availableBlocks.size() == 0){
      found = true;
      println("Found a solution");
    }
    
    if(iterat%50 == 0){
      println("Number of pieces");
      println(pieces.size());
      println();
    }
    iterat++;
  }
  
  // Found a solution //
  println(pieces.toString());
  exit();
}

public Piece makePiece(PVector p){
  return makePiece(int(p.x),int(p.y),int(p.z));
}

public Piece makePiece(int x, int y, int z){
  // Returns a valid piece that fits into the cuve //
  // Returns null is there is no such piece //
  Piece p = new Piece(x,y,z);
  boolean abort = false;
  int it = 0;
  while(p.notDone()){
    // Add a block //
    int iit = 0;
    it++;
    ArrayList<PVector> dir = new ArrayList<PVector>(dirs);
    while(!dir.isEmpty()){
      // Choose a direction and check if valid //
      iit++;
      if(iit > maxIterations){
        exit();
      }
      int s = dir.size();
      int pick = int(random(s));
      PVector newPos = dir.remove(pick);
      println("Picked out of dir: " + newPos.toString());
      newPos.add(p.lastBlockPos());
      println("Combined Position: " + newPos.toString());
      // Check if the newPos is in the cube //
      if(newPos.x < 0 || newPos.y < 0 || newPos.z < 0 || newPos.x >= num || newPos.y >= num || newPos.z >= num){
        continue;
      }else if(cube[int(newPos.x)][int(newPos.y)][int(newPos.z)] == false){
        cube[int(newPos.x)][int(newPos.y)][int(newPos.z)] = true;
        availableBlocks.remove(newPos);
        p.addBlock(newPos);
        println("Block Successful");
        break;
      }
      
      if(dir.isEmpty()){
        // Can't make a block //
        abort = true;
        println("Abort");
        break;
      }
    }
    // Either a block was sucessfully added or none of the sides worked (aka trapped) //
    if(abort){
      abort = false;
      if(it > maxIterations){
        abort = true;
        break;
      }else{
        // Pop the last block unless it's the first block //
        if (p.getIndex() == 1){
          println("Shitskies. The whole block was popped!");
          abort = true;
          break;
        }
        p.popLastBlock();
      }
    }
    if(abort){
      break;
    }
  }
  
  // See if the pice is complete and return it or return null //
  if(p.notDone()){
    // Piece can't fit in this point //
    p.reallocate();
    return null;
  }else{
   return p;
  }
}

public PVector getRandomPosition(){
  int asize = availableBlocks.size();
  int rpos = int(random(asize));
  return availableBlocks.remove(rpos); // Should this be removed? //
}

public void recursiveFunction(int level){
  
}

class Piece {
  PVector[] blocks;
  int index;
  public Piece(int x, int y, int z){
    this.blocks = new PVector[num];
    this.blocks[0] = new PVector(x,y,z);
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
    return this.index < num;
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
    for(int i=0; i<num; i++){
      ret = ret + this.blocks[i].toString();
    }
    ret = ret + "\nEnd Block\n";
    return ret;
  }
}
