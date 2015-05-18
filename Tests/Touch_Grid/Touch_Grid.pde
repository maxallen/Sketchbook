// The Grid itself is a multi-dimensional array of "Cells"
Cell[][] grid;

// Number of Columns and Rows //
int cols = 10;
int rows = 10;

void setup() {
  size(400,400);
  grid = new Cell[rows][cols];
  // Set each cell object to the color white //
  for (int r=0; r<rows; r++) {
    for (int c=0; c<cols; c++) {
      grid[r][c] = new Cell(c*(width/cols),r*(height/rows),(width/cols),(height/rows),255);//random(255));
    } 
  }
}

void draw() {
  // Find which cell the mouse is on... //
  float x = mouseX;
  float y = mouseY;
  
  
  if (mouseX < (width-10) && mouseX > 10 && mouseY > 10 && mouseY < (height-10)) {
    // Get column and row //
    int colIndex = int((mouseX - (mouseX % (width/cols))) / (width/cols));
    int rowIndex = int((mouseY - (mouseY % (height/rows))) / (height/rows));
    
    // Update the color and redraw the Cell //
    Cell temp = grid[rowIndex][colIndex];
    temp.touched();
    temp.display();
  }
}

// Cell Class //
class Cell {
  // Instance Variables //
  float x,y;
  float w,h;
  int colour;
  
  // Constructor //
  Cell(float X, float Y, float W, float H, int C) {
    x = X;
    y = Y;
    w = W;
    h = H;
    colour = C;
    display();
  }
  
  void touched() {
    if (colour > 0) {
      colour -= 1;
    }
  }
  
  void display() {
    stroke(255);
    fill(colour);
    rect(x,y,w,h);
  }
}
