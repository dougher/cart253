//CHANGED Class created for the Point point on the screen to be able to do mathematic manipulations to 
//a self-managed entity (e.g. collision, remembering colours...)

int BOUNCER_EFFECT = 15;

class Point {
  // A PVector allows us to store an x and y location in a single object
  // When we create it we give it the starting x and y (which I'm setting to -1, -1
  // as a default value). 
  // CHANGED Also added a PVector for size.
  PVector position = new PVector(-50,-50);
  int size = 0;
  
  color c;
  float red, green, blue;
  boolean increment = true; //this boolean checks whether the point is completely black
  //or completely white. Once that happens, the bouncers affect the point inversely:
  //if it was getting increasingly lighter, it now gets increasingly dark.
  
  //We initialize the variables with the received parameter.
  Point(int _size){
    size = _size;
    
    //The color is now black and increments bits of the colour from the bouncers
    //to the point.
    red = 0;
    green = 0;
    blue = 0;
    
    c = color(red, green, blue);
  }
  
  //This function is sent each bouncer to verify whether they are
  //colliding with current Point.
  void handleCollision(Bouncer current){
    boolean collideLeft = (current.x + current.size/2) > (position.x - size/2);
    boolean collideRight = (current.x - current.size/2) < (position.x + size/2);
    boolean collideUp = (current.y + current.size/2) > (position.y - size/2);
    boolean collideDown = (current.y - current.size/2) < (position.y + size/2);
    
    if (collideLeft && collideRight && collideUp && collideDown){
      if (increment){
        red += red(current.fillColor) / BOUNCER_EFFECT;
        green += green(current.fillColor) / BOUNCER_EFFECT;
        blue += blue(current.fillColor) / BOUNCER_EFFECT;
        
        println("Red: " + red + "/ Green: " + green + "/ Blue: " + blue);
      } else {
        red -= red(current.fillColor) / BOUNCER_EFFECT;
        green -= green(current.fillColor) / BOUNCER_EFFECT;
        blue -= blue(current.fillColor) / BOUNCER_EFFECT;
        
        println("Red: " + red + "/ Green: " + green + "/ Blue: " + blue);
      }
      
    }
  }
  
  //Calls the handleCollision() method to check whether the Point's color needs to
  //be changed.
  void update(Bouncer current){
    handleCollision(current);
    regulate();
  }
  
  void regulate(){
     red = constrain(red, 0 , 255);
     green = constrain(green, 0 , 255);
     blue = constrain(blue, 0 , 255);
     
     if (red == 255 && green == 255 && blue == 255)
       increment = false;
     
     if (red == 0 && green == 0 && blue == 0)
       increment = true;
  }

  
  void display(){
    c = color(red, green, blue);
    
    //CHANGED: the colour of the bright point is modifuied: The aim is to have it 
    //influenced by the bouncer(s) it collides with.
    fill(c);
    noStroke();
    ellipse(position.x,position.y,size,size);
  }
}