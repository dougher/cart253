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

  
  //We initialize the variables with the received parameter.
  Point(int _size){
    size = _size;
    
    red = 255;
    green = 255;
    blue = 255;
    
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
      red -= red(current.fillColor) / BOUNCER_EFFECT;
      green -= green(current.fillColor) / BOUNCER_EFFECT;
      blue -= blue(current.fillColor) / BOUNCER_EFFECT;
      
    }
  }
  
  //Calls the handleCollision() method to check whether the Point's color needs to
  //be changed.
  void update(Bouncer current){
    handleCollision(current);
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