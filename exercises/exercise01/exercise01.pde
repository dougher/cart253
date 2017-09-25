final int CIRCLE_SPEED = 7;
final color NO_CLICK_FILL_COLOR = color(250, 100, 100);
final color CLICK_FILL_COLOR = color(100, 100, 250);
final color BACKGROUND_COLOR = color(250, 150, 150);
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50;
final int DISTANCE_FACTOR = 2; //CHANGED: distance factor between mouse and ellipse to start using deviate velocity.

int circleX;
int circleY;
int circleVX;
int circleVY;
float deviateX; //CHANGED: new variables to deviate ellipse.
float deviateY;
float dist; // CHANGED: alleviate code with a dist() variable.

void setup() {
  size(640, 480);
  circleX = width/2;
  circleY = height/2;
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
  stroke(STROKE_COLOR);
  fill(NO_CLICK_FILL_COLOR);
  background(BACKGROUND_COLOR);
  
  deviateX = 0;
  deviateY = 0;
  dist = 100;
  
  //The ellipse is first placed in the center of the screen with a stroke color the same as the background
}

void draw() {
    dist = dist(mouseX, mouseY, circleX, circleY);
  
    if (dist < CIRCLE_SIZE*DISTANCE_FACTOR) { //CHANGED: The if now checks if the mouse is getting close to the circle.
      deviateX = dist / (float) circleVX;
      deviateY = dist / (float) circleVY;
      
      //CHANGED: Check if x & y velocity are both + or -; if so, change only one of them to ensure deviation.
      if (circleVX < 0 && circleVY < 0){
        println(deviateX);
        deviateX = -CIRCLE_SPEED + deviateX;
        deviateY = -CIRCLE_SPEED;
      }else if (circleVX >= 0 && circleVY >= 0){
        deviateX = CIRCLE_SPEED;
        deviateY = CIRCLE_SPEED + deviateY;
      }else{
        deviateX = CIRCLE_SPEED + deviateX;
        deviateY = CIRCLE_SPEED + deviateY;
      }
      
      circleX += deviateX;
      circleY += deviateY;
      
      println(circleX);

  }
  else {
    circleX += circleVX;
    circleY += circleVY;
  }
  
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);
  
  //Every frame the circle moves by (-)7 in each direction.
  
  //The ball will stay within the limits of the screen.
  if (circleX + CIRCLE_SIZE/2 >= width || circleX - CIRCLE_SIZE/2 <= 0) { //Remove half its dimaeter to avoid it going half off screen.
    circleVX = -circleVX; //Changes direction.
  }
  if (circleY + CIRCLE_SIZE/2 >= height || circleY - CIRCLE_SIZE/2 <= 0) {
    circleVY = -circleVY; //Ditto.
  }
  
}

void mousePressed() {
  background(BACKGROUND_COLOR); //Clean background when mouse clicked. Otherwise, drawings are accumulated indefinitely.
}