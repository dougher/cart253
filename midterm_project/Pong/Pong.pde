// Pong
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// No scoring. (Yet!)
// No score display. (Yet!)
// Pretty ugly. (Now!)
// Only two paddles. (So far!)

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;
Water[] waters;

//Two-index variable to keep track of each score
int[] score = {0, 0};

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

// The background colour during play (black)
color backgroundColor = color(0);

//Nb of water drops displayed
int WATER_DROPS = 150;

// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(640, 480);

  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, '1', 'q');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, '0', 'p');

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
  waters = new Water[WATER_DROPS];

  for (int i=0; i<waters.length; i++) {
    waters[i] = new Water(width/2, height/2, random(-3, 3), random(-3, 3));

    if (waters[i].vx < 1)
      waters[i].vx++;
    if (waters[i].vy < 1)
      waters[i].vy++;
  }

  //Create the score array
  println(score[0], score[1]);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // Fill the background each frame so we have animation
  background(backgroundColor);

  // Update the paddles and ball by calling their update methods
  leftPaddle.update();
  rightPaddle.update();
  ball.update();

  // Check if the ball has collided with either paddle
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);
  ball.collide(waters);

  // Check if the ball has gone off the screen
  if (ball.isOffScreen() > 0) {
    // If it has, reset the ball
    if (ball.isOffScreen() == 1)
      score[0]++;
    else if (ball.isOffScreen() == 2)
      score[1]++;

    ball.reset();

    println("Score : Left has " + score[1] + "pts, Right has " + score[0] + "pts.");
  }

  //Display the water first so it doesn't hide the ball
  for (int i=0; i<waters.length; i++) {
    waters[i].update();
    waters[i].collide(leftPaddle);
    waters[i].collide(rightPaddle);
    waters[i].display();
  }

  // Display the paddles and the ball
  leftPaddle.display();
  rightPaddle.display();
  ball.display();

  if (applyScore()) {
    ball.x = -15;
    ball.y = -15;
    noLoop();
    gameOver();
  }
}

//The score is displayed through the colors of the paddles. The larger the gap 
//between the points, the more colored they end up being. The game is won once the
//gap is wider or equal to 8. The method ends by sending a boolean that says whether
// the gap is wide enough (at which point the game is over). 
boolean applyScore() {
  int gap = abs(score[0] - score[1]);
  color winner = color(0);
  color loser = color(0);

  gap = constrain(gap, 0, 8);

  switch (gap) {
  case 0:
    leftPaddle.paddleColor = color(255);
    rightPaddle.paddleColor = color(255);
    break;
  case 1:
    winner = color(255, 240, 195);
    loser = color(245, 230, 220);
    break;
  case 2:
    winner = color(230, 235, 160);
    loser = color(235, 200, 185);
    break;
  case 3:
    winner = color(220, 225, 115);
    loser = color(225, 175, 155);
    break;
  case 4:
    winner = color(230, 240, 100);
    loser = color(225, 140, 105);
    break;
  case 5:
    winner = color(240, 215, 100);
    loser = color(220, 90, 90);
    break;
  case 6:
    winner = color(230, 210, 100);
    loser = color(225, 60, 60);
    break;
  case 7:
    winner = color(245, 215, 45);
    loser = color(245, 20, 20);
    break;
  case 8:
    winner = color(245, 215, 45);
    loser = color(215, 0, 0);
    break;
  }

  if (gap > 0) {
    if (score[0] > score[1]) {
      leftPaddle.changeColor(loser);
      rightPaddle.changeColor(winner);
    } else {
      leftPaddle.changeColor(winner);
      rightPaddle.changeColor(loser);
    }
  }

  if (gap == 8)
    return true;
  else
    return false;
}

void gameOver() {
  textSize(24);
  textAlign(CENTER,CENTER);
  fill(255);
  
  if (score[0] > score[1])
    text("The Left player won!", width/2, height/1.8);
  else
    text("The Right player won!", width/2, height/1.8);
    
  textSize(18);
  text("Click to restart the game...", width/2, height/1.5);
}

void reset(){
  score[0] = 0;
  score[1] = 0;
  leftPaddle.reset(PADDLE_INSET, height/2);
  rightPaddle.reset(width - PADDLE_INSET, height/2);
  ball.reset();
  
  for (int i=0; i<waters.length;i++){
    waters[i].reset();
  }
}

// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}

//Restarts the game
void mousePressed(){
  reset(); 
  loop(); 
}