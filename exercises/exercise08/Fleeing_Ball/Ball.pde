int DISTANCE = 90;
int DIAM = 30;

class Ball {
  Clock myClock;
  Physics myBody;
  
  color c;

  float x;
  float y;
  float distX;
  float distY;
  float newX;
  float newY;

  float VX;
  float VY;

  boolean active;
  boolean safe;
  float hunger;

  int ticks;
  int action;

  Ball(int w, int h) {
    myClock = new Clock(Factor.Normal);
    myBody = new Physics(w/2, h/2, DIAM, DIAM);
    
    c = color(255, 255, 255);

    distX = 100;
    distY = 100;
    newX = myBody.x;
    newY = myBody.y;

    active = false;
    safe = true;
    hunger = 10;

    action = 0;
  }

  void AI() {

    if (safe) { 
      if (active) //Only becomes true after a full cycle. At init = false.
        Instinct();
      else if (!active && myBody.moving){ //"I've just been deactivated."
        if (myBody.Brake()){
          myClock.Reset();
          println("Internal clock restarted. Ticks: " + myClock.ticks);
        }
      }
      else{ //Should be first condition met on initialization.
        if (myClock.Cycle()){ //Calls boolean function that returns false as long as a cycle hasn't passed.
          active = true;
          println("Cycle completed.");
          if (hunger <= 4)
            action = 2;
          else
            action = 1;
        }
      }
    } else
      Flight();
      
    if (abs(mouseX- myBody.x) < DISTANCE && abs(mouseY - myBody.y) < DISTANCE) { 
      safe = false;
    }
    //println("active: " + active);
    //println("safe: " + safe);

    myBody.Regulate();
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

    if (abs(mouseX- myBody.x) < DISTANCE && abs(mouseY - y) < DISTANCE) { 
      safe = false;
    }
  }

  void Stroll() {  
    if (!myBody.getMoving()) {
      newX = random(myBody.x-DISTANCE, myBody.x+DISTANCE);
      newY = random(myBody.x-DISTANCE, myBody.y+DISTANCE);
    }

    if (safe) {
      distX = abs(newX - myBody.x);
      distY = abs(newY - myBody.y);
      
      println(newX + "(newX) - " + myBody.x + " (x) = " + distX);
      println(newY + "(newY) - " + myBody.y + " (y) = " + distY);

      //println(myBody.vx + " < VX | VY > " + myBody.vy);

        if (!myBody.InMotion())
          active = false;
        
        myBody.ReverseV(true, newX);
        myBody.ReverseV(false, newY);
        
        myBody.IntentMove(distX, distY, false);
    }
  }

  void Flight () {
    distX = abs(mouseX - myBody.x);
    distY = abs(mouseY - myBody.y);
    
    myBody.IntentMove(distX, distY, true);

    println("Flight!");

    if (abs(distX) >= DISTANCE || abs(distY) >= DISTANCE) {
      safe = true;
      active = false;
    }
  }

  void Display() {
    fill(c);
    ellipse(myBody.x, myBody.y, myBody.w, myBody.h);
  }
}