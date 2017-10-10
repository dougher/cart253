class Bouncer {
 /*Class for the Bouncer object. All attributes are fairly straightforward: three
 attributes are assigned to color: one that is used as the attribute assigned to 
 the fill() function (fillColor) and two that can be assigned to it to change depending
 on the mouse's pos. 
 Otherwise the class handles the Boucner's mouvements, limits and visual state depending
 on the mouse. */
 
 int x;
 int y;
 int vx;
 int vy;
 int size;
 color fillColor;
 color defaultColor;
 color hoverColor;
 
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
 }
 
 void update() {
   x += vx;
   y += vy;
   
   handleBounce();
   handleMouse();
 }
 
 //Keeps the Bouncer within the limits of the screen.
 void handleBounce() {
   if (x - size/2 < 0 || x + size/2 > width) { //If the Bouncer's edge is smaller or bigger than the screen's horizontal size, change its direction.    vx = -vx; 
   }
   
   if (y - size/2 < 0 || y + size/2 > height) { //If the Bouncer's edge is smaller or bigger than the screen's vertical size, change its direction. 
     vy = -vy;
   }
   
   //Keep Bouncer's pos within the screen size.
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 
 void handleMouse() {
   if (dist(mouseX,mouseY,x,y) < size/2) { //If the mouse is within the Bouncer's edge, assign this color to FillColor
    fillColor = hoverColor; 
   }
   else { //If the mouse isn't, keep the default color as the color used.
     fillColor = defaultColor;
   }
 }
 
 void draw() { //Draw th ellipse without stroke and with the fillColor determined in handleMouse() 
   noStroke();
   fill(fillColor);
   ellipse(x,y,size,size);
 }
}