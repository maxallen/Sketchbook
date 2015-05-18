PImage img;
PImage edgeImg;
int time = 0;
int bWidth = 4;
int bHeight = 4;

float v = 1.0 / 9.80;
float[][] kernel = {{ v, v, v }, 
                    { v, v, v }, 
                    { v, v, v }};

void setup() {
  img = loadImage("P4261646.JPG");
  size(img.width, img.height);
  colorMode(RGB);
  edgeImg = createImage(img.width, img.height, RGB);
  smooth();
  noLoop();
}

void draw() {
  time++;
  background(255);
  clusterize();
  //image(p,0,0);
  
  // Blur //
  // Create an opaque image of the same size as the original
  edgeImg.loadPixels();

  // Loop through every pixel in the image
  for (int y = 1; y < img.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < img.width-1; x++) {  // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*img.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(img.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      edgeImg.pixels[y*img.width + x] = color(sum);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();
  scale(0.1);
  image(edgeImg,0,0); // Draw the new image
  
}

void clusterize(){
  // Goes through the image in 4x4 pixel clusters and then uses the average brightness to convert to a density plot //
  img.loadPixels();
  for(int col=0; col<(width-(bWidth-1)); col+=bWidth){
    for(int row=0; row<(height-(bHeight-1)); row+=bHeight){
      // Col and Row are position of top left corner of 4x4 box //
      
      // Get average brightness of all the pixels in that box //
      int totB = 0;
      for(int i=col; i<(col+bWidth); i++){
        for(int j=row; j<(row+bHeight); j++){
          totB += brightness(img.pixels[width*row + col]);
        }
      }
      float aveB = totB/(bHeight*bWidth);
      if(col == row){
        println(aveB);
      }
      // Populate the new box based on the aveare brightness //
      float highProb = 255.0/(bWidth*bHeight);
      float aveProb = aveB/(bWidth*bHeight);
      for(int i=col; i<(col+bWidth); i++){
        for(int j=row; j<(row+bHeight); j++){
          // Probability Density Function //
          if(random(highProb)<aveProb){
            img.pixels[width*j + i] = color(255);
          }else{
            img.pixels[width*j + i] = color(0);
          }
        }
      }
      
    }
  }
  
  img.updatePixels();
}
