//--------------------------//
// Andy Warhol Picture V 1.0
// 
// Turns pictures into cirlces
//--------------------------//

// The image
PImage img;
PImage newImg;

void setup() {
  img = loadImage("paintsplat.jpg");
  newImg = createImage(img.width, img.height, ARGB);
  size(img.width,img.height);
  smooth();
}
