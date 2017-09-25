final int CIRCLE_SPEED = 7;
final color NO_CLICK_FILL_COLOR = color(250, 100, 100);
final color CLICK_FILL_COLOR = color(100, 100, 250);
final color BACKGROUND_COLOR = color(250, 150, 150);
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50;

int circleX;
int circleY;
int circleVX;
int circleVY;

void setup() {
  size(640, 480);
  circleX = width/2;
  circleY = height/2;
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
  stroke(STROKE_COLOR);
  fill(NO_CLICK_FILL_COLOR);
  background(BACKGROUND_COLOR);
  
  //The ellipse is first place in the center of the screen with a stroke color the same as the background
}

void draw() {
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) { //if the distance mouse->ellipse (center) is smaller than half diameter (inside ellipse): use this color
    fill(CLICK_FILL_COLOR); 
  }
  else {
    fill(NO_CLICK_FILL_COLOR);
  }
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);
  circleX += circleVX;
  circleY += circleVY;
  
  //Every frame the circle moves by (-)7 in each direction.
  
  //The ball will stay within the limits of the screen.
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) { //Remove half its dimaeter to avoid it going half off screen.
    circleVX = -circleVX; //Changes direction.
    
  }
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY; //Ditto.
  }
}

void mousePressed() {
  background(BACKGROUND_COLOR); //Clean background when mouse clicked. Otherwise, drawings are accumulated indefinitely.
}