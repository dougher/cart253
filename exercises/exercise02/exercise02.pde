/*We make all the variables for the program, including static data, paddle data and 
 ball data.*/

color backgroundColor = color(0);

int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);

int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);
int paddleMode; //CHANGED: changes the paddle color.

int ballX;
int ballY;
int ballVX;
int ballVY;
int recordVX; //CHANGED: Record VX and VY for when the ball stays on place.
int recordVY;
int ballSpeed = 5;
int ballW; //CHANGED: Differentiate width and height.
int ballH;
color ballColor = color(255);
boolean bouncing; //CHANGED: Handles ball bouncing on the sides.
boolean retracting; //CHANGED: Handles if ball is retracting (or "squishing").
int ballSide = 0; /*CHANGED: Variable to check which side the ball is on (1 = left, 
 2 = top, 3 = right.*/
final int PRESSURE = 3; //CHANGED: The pressure on the ball hitting the walls.
final int BALL_SIZE = 16; //CHANGED: constant to remember the ball size.
final int BALL_MAX_PRESSURE = 10;

/* The setup calls two other setups to initialize the paddle's & ball's "physical" 
 properties and movement. */
void setup() {
  size(640, 480);

  setupPaddle();
  setupBall();
}

void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
  paddleMode = 0;
}

void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballW = BALL_SIZE;
  ballH = BALL_SIZE;
  
  ballVX = ballSpeed;
  ballVY = ballSpeed;
  recordVX = 0;
  recordVY = 0;
  
  bouncing = false;
  retracting = false;
  
}

void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

// 999 static are added to the screen randomly every frame.
void drawStatic() { 
  for (int i = 0; i < numStatic; i++) {
    float x = random(0, width);
    float y = random(0, height);
    float staticSize = random(staticSizeMin, staticSizeMax);
    fill(staticColor);
    rect(x, y, staticSize, staticSize);
  }
}

/* Paddle is moved and contained within the screen's limit. Only changes when user 
 press arrows. */

void updatePaddle() { 
  paddleX += paddleVX;  
  paddleX = constrain(paddleX, 0+paddleWidth/2, width-paddleWidth/2);
}

/* The ball moves autonomously and calls other functions that check the ball's 
 collisions. */
void updateBall() { 
  ballX += ballVX;
  ballY += ballVY;

  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

void drawPaddle() {
  rectMode(CENTER);
  noStroke();

  /* CHANGED: We change the paddle color through the paddleMode to go from green to
   yellow to red everytime it collisions with the ball, showing visually the ball's 
   growing speed. */
  for (int i = 0; i <= 6; i++) {
    switch (paddleMode) {
    case 0:
      fill(paddleColor);
      break;
    case 1:
      fill(140, 220, 125);
      break;
    case 2:
      fill(170, 220, 125);
      break;
    case 3:
      fill(210, 230, 110);
      break;
    case 4:
      fill(230, 180, 110);
      break;
    case 5:
      fill(195, 80, 60);
      break;
    default:
      fill(215, 55, 40);
      break;
    }
  }

  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

void drawBall() {
  noStroke();
  fill(ballColor);
  //CHANGED: Ball bounces looks better with an ellipse.
  ellipse(ballX, ballY, ballW, ballH); 
}

void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballH/2;
    ballVY = -ballVY;

    //CHANGED: Make ball go faster every time it hits the paddle.
    if (ballVX < 0)
      ballVX -=1;
    else
      ballVX +=1;

    if (ballVY < 0)
      ballVY -=1;
    else
      ballVY +=1;

    paddleMode++;
  }
}

/* Return true when  ball and paddle overlap. If "if" doesn't happen, return false 
 by default. */
boolean ballOverlapsPaddle() {
  if (ballX - ballW/2 > paddleX - paddleWidth/2 && ballX + ballW/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}

//Reset ball's position when/if it goes off screen.
void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
    ballVX = ballSpeed; // CHANGED: Reset ball's speed.
    ballVY = ballSpeed;

    paddleMode = 0;
  }
}

boolean ballOffBottom() {
  return (ballY - ballH/2 > height);
}

//Keep the ball within the sides and top of the screen.
void handleBallHitWall() {
  if (ballX - ballW/2 < 0 && !bouncing) {
    println("Ball hit left wall.");
    bouncing = true;
    retracting = true;
    ballSide = 1;

    ballX = 0 + ballW/2;
    recordVX = -ballVX;
    recordVY = ballVY;
    ballVX = 0;
    ballVY = 0;
  } else if (ballX + ballW/2 > width && !bouncing) {
    println("Ball hit right wall.");
    bouncing = true;
    retracting = true;
    ballSide = 3;

    ballX = width - ballW/2;
    recordVX = -ballVX;
    recordVY = ballVY;
    ballVX = 0;
    ballVY = 0;
  }

  if (ballY - ballH/2 < 0 && !bouncing) {
    println("Ball hit top wall.");
    bouncing = true;
    retracting = true;
    ballSide = 2;

    ballY = 0 + ballH/2;
    recordVY = -ballVY;
    recordVX = ballVX;
    ballVY = 0;
    ballVX = 0;
  }

  ballBounces();
}

/*CHANGED: Adds elasticity to the ball when it hits the walls.
The bouncing and retracting variable are turned to true once the ball touches 
whichever side (at which point it stays in position). The ball's width or height
gets smaller until it reaches the ball's max pressure point, at which point
the retracting variable becomes false (so the programs knows when to switch
from substraction to addition of the size) and the ball regains its normal size.
Once this happens, bouncing becomes false and we put back the recorded VX and VY
in the proper variables to resume the ball's movements.
*/
void ballBounces() {
  if (bouncing) {
    switch (ballSide) {
    case 1: //CHANGED: Ball its left wall.
      if (ballW > BALL_SIZE - BALL_MAX_PRESSURE && retracting) {
        ballW -= PRESSURE;
        ballX -= PRESSURE/2;
        
        if (ballW <= BALL_SIZE - BALL_MAX_PRESSURE)
          retracting = false;
      } else {
        ballW += PRESSURE;
        ballX += PRESSURE/2;
      }
      break;
    case 2: //CHANGED: Ball hits top wall.
      if (ballH > BALL_SIZE - BALL_MAX_PRESSURE && retracting) {
        ballH -= PRESSURE;
        ballY -= PRESSURE/2;
        
        if (ballH <= BALL_SIZE - BALL_MAX_PRESSURE)
          retracting = false;
      } else {
        ballH += PRESSURE;
        ballY += PRESSURE/2;
      }
      break;
    case 3: //CHANGED: Ball hits right wall.
      if (ballW > BALL_SIZE - BALL_MAX_PRESSURE && retracting) {
        println("Shake it break it bake it bounce!");
        ballW -= PRESSURE;
        ballX += PRESSURE/2;
        
        if (ballW <= BALL_SIZE - BALL_MAX_PRESSURE)
          retracting = false;
      } else {
        ballW += PRESSURE;
        ballX -= PRESSURE/2;
      }
      break;
    }
    
    if (ballSide != 2 && ballW >= BALL_SIZE) {
      bouncing = false;
      ballVX = recordVX;
      ballVY = recordVY;
      ballSide = 0;
      ballW = BALL_SIZE;
    } else if (ballSide == 2 && ballH >= BALL_SIZE){
      bouncing = false;
      ballVX = recordVX;
      ballVY = recordVY;
      ballSide = 0;
      ballH = BALL_SIZE;
    }
  }
}

/* Move the paddle when side arrow keys pressed through the VX, which is then 
 put back to 0 when the key is released. */
void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}