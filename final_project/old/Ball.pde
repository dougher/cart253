int DISTANCE = 90;

class Ball {
  Clock myClock;
  
  int diam;
  color c;

  float x;
  float y;
  float distX;
  float distY;
  float newX;
  float newY;

  float VX;
  float VY;
  float easing;

  boolean active;
  boolean safe;
  boolean moving;
  float hunger;

  int ticks;
  int action;

  Ball(int w, int h) {
    myClock = new Clock(Factor.Normal);
    
    diam = 30;
    c = color(255, 255, 255);

    x = w/2;
    y = h/2;
    distX = 100;
    distY = 100;
    newX = x;
    newY = y;

    VX = 0;
    VY = 0;
    easing = 0.1;

    active = false;
    safe = true;
    moving = false;
    hunger = 10;

    ticks = 0;
    action = 0;
  }

  void AI() {

    if (safe) { 
      if (active) //Only becomes true after a full cycle. At init = false.
        Instinct();
      else if (!active && moving) //"I've just been deactivated."
        Brake();
      else{ //Should be first condition met on initialization.
        if (myClock.Cycle()){ //Calls boolean function that returns false as long as a cycle hasn't passed.
          active = true;
          if (hunger <= 4)
            action = 2;
          else
            action = 1;
        }
      }
    } else
      Flight();

    if (abs(mouseX- x) < DISTANCE && abs(mouseY - y) < DISTANCE) { 
      safe = false;
    }
    println("active: " + active);
    println("safe: " + safe);

    Regulate();
    Display();
  }

  void Instinct() {
    switch(action) {
    case 1:
      Stroll();
      break;
    case 2:
      //Eat();
      break;
    case 3: 
      //Sleep();
      break;
    }

    if (abs(mouseX- x) < DISTANCE && abs(mouseY - y) < DISTANCE) { 
      safe = false;
    }
  }

  void Stroll() {
    if (!moving) {
      newX = random(x-DISTANCE, x+DISTANCE);
      newY = random(x-DISTANCE, y+DISTANCE);

      moving = true;
    }

    if (safe) {
      distX = abs(newX - x);
      distY = abs(newY - y);
      println(newX + "(newX) - " + x + " (x) = " + distX);
      println(newY + "(newY) - " + y + " (y) = " + distY);

      VX = distX * easing;
      VY = distY * easing;
      println(VX + " < VX | VY > " + VY);

      if (abs(VX) < easing || abs(VY) < easing)
        active = false;

      if (newX - x > 0) 
        VX = -VX;

      if (newY - y > 0) 
        VY = -VY;

      Move();
    }
  }

  void Flight () {
    distX = abs(mouseX - x);
    distY = abs(mouseY - y);

    println("Que hora es?!");

    VX = (DISTANCE - distX) * easing;
    VY = (DISTANCE - distY) * easing;

    if (mouseX - x < 0) 
      VX = -VX;

    if (mouseY - y < 0) 
      VY = -VY;

    Move();

    if (abs(distX) >= DISTANCE || abs(distY) >= DISTANCE) {
      safe = true;
      active = false;
      ticks = 0;
    }
  }

  void Move() {
    moving = true;
    x -= VX;
    y -= VY;
  }

  void Brake() {
    x = x - VX;
    y = y - VY;

    if (VX > 0)
      VX -= easing;
    else
      VX += easing;

    if (VY > 0)
      VY -= easing;
    else
      VY += easing;

    //println("Bananas!");
    if (abs(VX) < easing || abs(VY) < easing) {
      moving = false;
      VX = 0;
      VY = 0;

      myClock.Reset();
      println("Uncle dolan pls.");
    }
  }

  void Regulate() {
    x = constrain(x, (diam/2), width - (diam/2));
    y = constrain(y, (diam/2), height - (diam/2));

    if (ticks > CLOCK)
      ticks = CLOCK;
  }

  void Display() {
    fill(c);
    ellipse(x, y, diam, diam);
  }
}