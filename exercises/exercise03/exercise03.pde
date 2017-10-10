color backgroundColor = color(200,150,150);
Bouncer bouncer;
Bouncer bouncer2;

/*The main file where everything happens; very simple, it creates two Bouncer objects,
sends required information to its constructor and uses its two main functions (update
and bounce) to update them every frame. */

void setup() {
  size(640,480);
  background(backgroundColor);
  //Call constructors with different parameters.
  bouncer = new Bouncer(width/2,height/2,2,2,50,color(150,0,0,50),color(255,0,0,50));
  bouncer2 = new Bouncer(width/2,height/2,-2,2,50,color(0,0,150,50),color(0,0,255,50));
}

void draw() {
  //Call the Bouncers' main functions.
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
}