// Water
//
// A class defining water drops, which act as a visual distraction for the game
// It is based on the ball class but behaves differently in its managing of
// collisions, movements and the screen.

class Water {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 3;
  int SIZE = 16;

  // The location of the water drop
  float x;
  float y;

  // The velocity of the water drop
  float vx;
  float vy;

  // The colour of the ball
  color c = color(0, 0, 255, 90);

  /////////////// Constructor ///////////////

  Water(float _x, float _y, float _vx, float _vy) {
    x = _x;
    y = _y;
    vx = _vx;
    vy = _vy;
  }

  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the water drop move
  // and also checks whether it should bounce of the sides of the screen

  void update() {
    // First update the location based on the velocity
    x += vx;
    y += vy;

    // The water drop differs from the ball because it can't leave the screen and is
    // constrained inside from all sides. It also calls randomizeDirection() to 
    //modify their velocity and direction.
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      randomizeDirection();
    }
    
    if (x - SIZE/2 < 0 ||x + SIZE/2 > width) {
      randomizeDirection();
    }
  }
  
  void reset() {
    x = width/2;
    y = height/2;
  }
  // collide(Paddle paddle)
  //
  // Checks whether the water drop is colliding with the paddle passed as an argument
  // If it is, it makes the water drop's movement is redirected through another method
  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);
    
    // Check if the water drop overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
       randomizeDirection(paddle);
    }
  }
  
  //This overloaded method serves to make the water's displacement more random 
  //This version is called by collide(), which check whether it touches the paddle
  void randomizeDirection(Paddle paddle){
    int side = (int) random(1, 7); //Randomize the movement of the water drop
      
      if (vx < 0) {
        switch (side){ //Switch for the left paddle
          case 1: // go towards top-left
            x = paddle.x + paddle.WIDTH/2 + SIZE/2;
            vx = - (abs(vx));
            vy = - (abs(vy));
            break;
          case 2: // go towards top
            x = paddle.x + paddle.WIDTH/2 + SIZE/2;
            vx = 0;
            vy = - SPEED;
            break;
          case 3: // go towards top-right
            x = paddle.x + paddle.WIDTH/2 + SIZE/2;
            vx = abs(vx);
            vy = - (abs(vy));
            break;
          case 4: // go towards right
            x = paddle.x + paddle.WIDTH/2 + SIZE/2;
            vx = -vx;
            vy = 0;
            break;
          case 5: // go towards bottom-right
            x = paddle.x + paddle.WIDTH/2 + SIZE/2;
            vx = abs(vx);
            vy = abs(vy);
            break;
          case 6: // go towards bottom
            x = paddle.x + paddle.WIDTH/2 + SIZE/2;
            vx = 0;
            vy = SPEED;
            break;
          case 7: // go towards bottom-left
            x = paddle.x + paddle.WIDTH/2 + SIZE/2;
            vx = - (abs(vx));
            vy = abs(vy);
            break;
        }
      } else if (vx > 0) {
        switch (side){ // Switch for the right paddle
          case 1: // go towards top-right
            x = paddle.x - paddle.WIDTH/2 - SIZE/2;
            vx = abs(vx);
            vy = - (abs(vy));
            break;
          case 2: // go towards top
            x = paddle.x - paddle.WIDTH/2 - SIZE/2;
            vx = 0;
            vy = -SPEED;
            break;
          case 3: // go towards top-left
            x = paddle.x - paddle.WIDTH/2 - SIZE/2;
            vx = - (abs(vx));
            vy = - (abs(vy));
            break;
          case 4: // go towards left
            x = paddle.x - paddle.WIDTH/2 - SIZE/2;
            vx = -vx;
            vy = 0;
            break;
          case 5: // go towards bottom-left
            x = paddle.x - paddle.WIDTH/2 - SIZE/2;
            vx = - (abs(vx));
            vy = abs(vy);
            break;
          case 6: // go towards bottom
            x = paddle.x - paddle.WIDTH/2 - SIZE/2;
            vx = 0;
            vy = SPEED;
            break;
          case 7: // go towards bottom-right
            x = paddle.x - paddle.WIDTH/2 - SIZE/2;
            vx = abs(vx);
            vy = abs(vy);
            break;
        }
      }
  }
  
  //This overloaded method serves to make the water's displacement more random 
  //This version is called from the update(), which keeps the water within the screen,
  //this time using random()
  void randomizeDirection(){
      if (x < 0 + SIZE/2) {
        vx = random(1, 3);
        vy = random(-3, 3);
 
      } else if (x > width - SIZE/2) {
        vx = random(-3, -1);
        vy = random(-3, 3);
      
      }
      
      if (y < 0 + SIZE/2){
        vy = random(1, 3);
        vx = random(-3, 3);
      } else if (y > height - SIZE/2){
        vy = random(-3, -1);
        vx = random(-3, 3);
      }
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
    noStroke();
    fill(c);
    rectMode(CENTER);

    // Draw the ball
    rect(x, y, SIZE, SIZE);
  }
}