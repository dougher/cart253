import sprites.*;
import sprites.maths.*;
import sprites.utils.*;
WhiteNigger wn;

void setup() {
  size(768, 1024); //IPad Mini size.
  
  wn = new WhiteNigger(false, "White Nigger", "Vodou");
}

void draw(){
  background(0);
  
  if (wn.activated){
    wn.Active();
  } else{
    wn.Idle();
  }
}

void mousePressed(){
  wn.Contact(true);
}

void mouseReleased(){
  wn.Contact(false);
}

//Pressing the number keys changes the current animation. So far three are 
//implemented.
void keyPressed(){
  int currKey;
  
  switch (key){
    case '0':
      currKey = 0;
      break;
    case '1':
      currKey = 1;
      break;
    case '2':
      currKey = 2;
      break;
    case '3':
      currKey = 3;
      break;
    default:
      currKey = 0;
      break;
  }
  
  wn.ChangeCurrent(currKey);
}