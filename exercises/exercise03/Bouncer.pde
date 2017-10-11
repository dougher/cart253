class Bouncer {
  /*Class for the Bouncer object. All attributes are fairly straightforward: three
   attributes are assigned to color: one that is used as the attribute assigned to 
   the fill() function (fillColor) and two that can be assigned to the former to 
   change its value.
   Otherwise the class handles the Boucner's mouvements, limits and visual state 
   depending on the mouse. */

  int x;
  int y;
  int vx;
  int vy;
  int size;
  color fillColor;
  color defaultColor;
  color hoverColor;

  int prevRand; //CHANGED: Remember previous side from handleBounce();

  //Constructor
  Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    size = tempSize;
    defaultColor = tempDefaultColor;
    hoverColor = tempHoverColor;
    fillColor = defaultColor;

    prevRand = 0;
  }

  void update() {
    x += vx;
    y += vy;

    handleBounce();
    handleMouse();
  }

  /*CHANGED: the Bouncer now teleports as soon as it disappears from the screen to an
   random location. */
  void handleBounce() {
    if (x + size/2 < 0 || x - size/2 > width || y + size/2 < 0 || y - size/2 > height) { 
      //CHANGED: If the Bouncer just came out of the screen.   

      int rand = 0, otherRand = 0; 

      do { //Do this at least once without checking the condition.
        rand = (int) random(1, 5); // Variable to test which side to reappear from.
      } while (rand == prevRand); //If same as previous side: reroll.

      otherRand = (int) random (1, 3); //Another variable to switch the appropriate velocity's polarity.

      /* The switch serves to decide from which side the Bouncer will appear from. For left and right, 
      the x is set to a specific place (right outside of the screen) and the y is randomized for the 
      Bouncer's vertical position. For top and bottom, vice-versa.
      */
      switch (rand) {
      case 1: //Appear from left.
        x = 0 - size/2;
        y = (int) random(0+size/2, height-size/2); 

        vx = abs(vx); //Make sure Bouncer goes in the screen.

        if (otherRand == 1)
          vy = -(abs(vy)); // Make sure the vy is negative.
        else if (otherRand == 2)
          vy = abs(vy); // Make the vy positive.
        break;
      case 2: //Appear from top.
        y = 0 - size/2;
        x = (int) random(0+size/2, width-size/2);

        vy = abs(vy); //Make sure Bouncer goes in the screen.

        if (otherRand == 1)
          vx = -(abs(vx)); // Make sure the vx is negative.
        else if (otherRand == 2)
          vx = abs(vx); // Make the vx positive.
        break;
      case 3: //Appear from right.
        x = width + size/2;
        y = (int) random(0+size/2, height-size/2);

        vx = -(abs(vx)); //Make sure Bouncer goes in the screen.

        if (otherRand == 1)
          vy = -(abs(vy)); // Make sure the vy is negative.
        else if (otherRand == 2)
          vy = abs(vy); // Make the vy positive.
        break;
      case 4: //Appear from bottom.
        y = height + size/2;
        x = (int) random(0+size/2, width-size/2);

        vy = - (abs(vy)); //Make sure Bouncer goes in the screen.

        if (otherRand == 1)
          vx = -(abs(vx)); // Make sure the vx is negative.
        else if (otherRand == 2)
          vx = abs(vx); // Make the vx positive.
        break;
      }
     prevRand = rand; // Remember the last random so the Bouncer doesn't reappear from the same side.
    }
  }

  void handleMouse() {
    if (dist(mouseX, mouseY, x, y) < size/2) { //If the mouse is within the Bouncer's edge, assign this color to FillColor
      fillColor = hoverColor;
    } else { //If the mouse isn't, keep the default color as the color used.
      fillColor = defaultColor;
    }
  }

  void draw() { //Draw th ellipse without stroke and with the fillColor determined in handleMouse() 
    noStroke();
    fill(fillColor);
    ellipse(x, y, size, size);
  }
}