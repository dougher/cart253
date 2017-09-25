
void setup(){
  println("Deathly hollows.");
  size(640, 480);

  background(255);
  
}
void draw(){
  fill(0, 0, 0, 2);
  stroke(255, 255, 255);
  
  ellipse(320, 240, 400, 400);
  triangle(320, 40, 145, 340, 495, 340);
  line(320, 40, 320, 440);
}

void mousePressed(){
  noStroke();
  fill (255);
  ellipse(mouseX, mouseY, 15, 15);
}