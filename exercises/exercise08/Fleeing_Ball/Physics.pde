int RANGE = 1;

enum CollDir{
    Null, Top, TopRight, Right, DownRight, Down, DownLeft, Left, TopLeft;
  };

class Physics{
  float x;
  float y;
  float w;
  float h;
  float mass; //really just square area because magic 2D land.
  
  float vx;
  float vy;
  float easing = 0.1;
  boolean moving = false;
  
  CollDir dirPush;
  
  Physics(float _x, float _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    vx = 0;
    vy = 0;

    dirPush = CollDir.Null;
    
    mass = w * h;
  }
  
  //any form of move, whether intentional or not.
  void Move() {
    if (!moving)
      moving = true;
    
    x -= vx;
    y -= vy;
  }
  
  //"Premedited" move; called from either Stroll() or Flight() function in Ball.
  void IntentMove(float _distX, float _distY, boolean fleeing){
    vx = (DISTANCE - _distX) * easing;
    vy = (DISTANCE - _distY) * easing; 
    println(vx + " " + vy);
    
    if (fleeing){
      if (mouseX - x < 0) 
        vx = -vx;
  
      if (mouseY - y < 0) 
        vy = -vy;
    } else{
      
    }

    Move();
  }
  
  boolean InMotion(){
    if (abs(vx) < easing || abs(vy) < easing)
        return false;
    else  
        return true;
  }
  
  void ReverseV(boolean horizontal, float newV){
    if (horizontal){
      if (newV - x > 0)
        vx = -vx;
    } else {
      if(newV - y > 0)
        vy = -vy;
    }
      
  }
  
  boolean Brake() {
    x = x - vx;
    y = y - vy;

    if (vx > 0)
      vx -= easing;
    else
      vx += easing;

    if (vy > 0)
      vy -= easing;
    else
      vy += easing;

    println("Breaking.");
    if (abs(vx) < easing || abs(vy) < easing) {
      moving = false;
      vx = 0;
      vy = 0;

      println("Stopped.");
      return true;
    }
    else
      return false;
  }
  
  //Simple method that verifies if the current object is colliding with other objects
  void Collide(Physics collider){
    boolean insideTop = (y + h/2 > collider.y - w/2);
    boolean insideDown = (y - h/2 < collider.y + w/2);
    boolean insideLeft = (x + w/2 > collider.x - w/2);
    boolean insideRight = (x - w/2 < collider.x + w/2);
    
    if (insideTop && insideDown && insideLeft && insideRight){
      if (mass > collider.mass)
        collider.Push(mass, CheckDirection(collider));
      else{
        //if (collider.mass > 1000), then force the object to not move in that direction
      }
        
    }
  }
  
    CollDir CheckDirection(Physics coll){
    float distX = x - coll.x;
    float distY = y - coll.y;
    
    //We first check if the collision is from a "simple" direction (top, down, left,
    //right) by verifying that the x or y is within a certain range from the collider's
    //equivalent position.
    if (distY > 0 && x <= coll.x + RANGE && x >= coll.x - RANGE)
      return CollDir.Top;
    else if (distY < 0 && x <= coll.x + RANGE && x >= coll.x - RANGE)
      return CollDir.Down;
    else if (distX < 0 && y <= coll.y + RANGE && y >= coll.y - RANGE)
      return CollDir.Left;
    else if (distX > 0 && y <= coll.y + RANGE && y >= coll.y - RANGE)
      return CollDir.Right;
    else if (distX > 0 && distY < 0)
      return CollDir.TopRight;
    else if (distX > 0 && distY > 0)
      return CollDir.DownRight;
    else if (distX < 0 && distY < 0)
      return CollDir.TopLeft;
    else if (distX < 0 && distY > 0)
      return CollDir.DownLeft;
    else
      return CollDir.Null;
  }
  
  //This method uses the direction determined by CheckDirection() of the collided object
  //to assign the opposite direction it should go towards of. It is only called when the
  //mass of the object is smaller than that of the collider.
  void Push(float force, CollDir hitFrom){
    switch (hitFrom){
      case Top:
        dirPush = CollDir.Down;
        break;
      case TopRight:
      dirPush = CollDir.DownLeft;
        break;
      case Right:
      dirPush = CollDir.Left;
        break;
      case DownRight:
      dirPush = CollDir.TopLeft;
        break;  
      case Down:
      dirPush = CollDir.Top;
        break; 
      case DownLeft:
      dirPush = CollDir.TopRight;
        break; 
      case Left:
      dirPush = CollDir.Right;
        break; 
      case TopLeft:
      dirPush = CollDir.DownRight;
        break; 
      case Null:
        println("Error on calculating direction of impact.");
        break;
    }
  }
  
  float DistWith(Physics target){
    float d;
    d = dist(target.x, target.y, x, y);
    return d;
  }
  
  void Regulate() {
    x = constrain(x, (w/2), width - (w/2));
    y = constrain(y, (h/2), height - (h/2));
  }
  
  boolean getMoving(){
     return moving; 
  }

}