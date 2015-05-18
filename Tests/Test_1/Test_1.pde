size(600, 600);
smooth();
background(0);
strokeWeight(10);

for(int i = width-1; i > 0; i -= 20) {
  float r = random(255);
  float x = random(0, width);
  stroke(r,90);
  line(i, 0, x, height);
}
