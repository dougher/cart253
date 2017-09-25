
void setup(){
  println("Colorful circles.");
  size(640, 480);

  background(255);
  
}
void draw(){
  int x = (int) random(640);
  int y = (int) random(480);
  int w = (int) random(1, 100);
  int h = (int) random(1, 100);
  int r = (int) random(1, 255);
  int g = (int) random(1, 255);
  int b = (int) random(1, 255);
  
  fill(r, g, b);
  noStroke();
  
  ellipse(x, y, w, w);
}

void mousePressed(){
  background(255);
}