void setup(){
  size (255, 480);
}

void draw(){
  int w = width;
  
  if (mouseX > 0 && mouseX < w + 1){
     background(w - mouseX); 
  }
  
  if (w < 0 || w > 255)
    w = constrain(w, 0, width);
}