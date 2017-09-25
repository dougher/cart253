void setup(){
  size (255, 255);
  background(255);
  line (width/2, 0, width/2, height);
  line (0, height/2, width, height/2);
}

void draw(){
  int x;
  int y;
  
  if (mouseX < width/2 && mouseY < height/2){
     x = 0;
     y = 0;
  } else if (mouseX > width/2 && mouseY < height/2){
     x = width/2;
     y = 0;
  } else if (mouseX < width/2 && mouseY > height/2){
     x = 0;
     y = height/2;
  } else{
     x = width/2;
     y = height/2;
  }
  
  background(255);
  line (width/2, 0, width/2, height);
  line (0, height/2, width, height/2);
  
  fill (0);
  rect(x, y, width/2, height/2);
}