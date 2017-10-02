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
int paddleMode; // changes the paddle color.

int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
color ballColor = color(255);

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
  ballVX = ballSpeed;
  ballVY = ballSpeed;
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
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   rect(x,y,staticSize,staticSize);
  }
}

/* Paddle is moved and contained within the screen's limit. Only changes when user 
press arrows. */

void updatePaddle() { 
  paddleX += paddleVX;  
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
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
  for (int i = 0; i <= 6; i++){
    switch (paddleMode){
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
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
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
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
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
  return (ballY - ballSize/2 > height);
}

//Keep the ball within the sides and top of the screen.
void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }
  
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
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