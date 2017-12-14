final int UNSAFE = 100;
final int SAFE = 101;
final int TRANSITING = 102;

class Sentient extends Vehicle{
  BaseEntity target;
  game2dai.maths.Vector2D nextPos = new game2dai.maths.Vector2D(0, 0);
  Clock myClock = new Clock(Factor.Normal);
  //ArrayList<Sprite> body = new ArrayList<Sprite>();
  
  boolean active = false;
  boolean moving = false;
  
  int action = 0;
  int hunger = 10;
  int walking = 0; //Number of walking cycles. This influences the Clock setting 
  //used when the Pet is in its Wander state.
  
  color tint = color(255, 255, 255);

  
  Sentient(double _x, double _y, double initSize, double maxVel){
    super(
      new game2dai.maths.Vector2D(_x, _y), //Position on screen. 
      initSize, 
      new game2dai.maths.Vector2D(0, 0), //Velocity.
      maxVel, 
      new game2dai.maths.Vector2D(1, 1), //Heading or initial direction of the AI.
      1, 
      0.5, //To be verified later, the AI's ability to turn should reflect its mass, e.g. 
      //the bigger it is the slower it will turn.
      2000 //Not quite sure what to put here yet, placeholder value.
    );
    addFSM();
    
}

  void AI(){
    if (active){
    }  else if (!active && moving){ //If I was recently deactivated but am still moving...
      Break();
       
      //Tell the Global state that we are transiting and ensure the Pet doesn't
      //start other states.
    } else{
       if (myClock.Cycle()){
         active = true;
         println("Processing cycle completed.");
         
         if (hunger <= 4)
            action = 2;
          else
            action = 1;
       }
    }
  }
  
  // The Instinct method is where the Pet knows in which state to puts itself (mostly,
  // should probably be the ONLY place that happens).
  void Instinct(){
    if (!IsSafe())
      Dispatcher.dispatch(500, ID(), ID(), UNSAFE);
    else{
      if (IsBreaking()){

        Break();
        Dispatcher.dispatch(500, ID(),ID(), TRANSITING);
      //println("Breaking");
      } else {
        Dispatcher.dispatch(500, ID(),ID(), SAFE); // Ditto.
      }
    }
  }

  void TakeOff(){
    if (this.velocity.x <= VELOCITY)
      this.velocity.add(EASING);
      
      moving = true;
  }
  
  void Break(){
    //The Break method ensures that the pet is slowly stopped before going back
    //to checking with its needs. (Idle state)
    //It conditionally changes, depending on polarity, the x and why by using 
    //constants internal to Vector2D to ensure maximal compatibility.
    if (this.velocity.x > 0)
      this.velocity.sub(game2dai.maths.Vector2D.div(game2dai.maths.Vector2D.PLUS_I, 3)); 
    else
      this.velocity.sub(game2dai.maths.Vector2D.div(game2dai.maths.Vector2D.MINUS_I, 3));
      
    if (this.velocity.y > 0)  
      this.velocity.sub(game2dai.maths.Vector2D.div(game2dai.maths.Vector2D.PLUS_J, 3));
    else
      this.velocity.sub(game2dai.maths.Vector2D.div(game2dai.maths.Vector2D.MINUS_J, 3));
      
    //println(this.velocity);
    
    //We check, thorugh this booleans, if the Pet's x and y are close enough to
    //zero since they never exactly reach it. If they are close enough, it means its
    //virtually static.
    boolean xCloseToZero = this.velocity.x <= 0.4 && this.velocity.x >= -0.4;
    boolean yCloseToZero = this.velocity.y <= 0.4 && this.velocity.y >= -0.4;
      
    if (xCloseToZero && yCloseToZero){
      this.velocity.set(game2dai.maths.Vector2D.ZERO);
      moving = false;
      myClock.Reset();
      Dispatcher.dispatch(500, ID(), ID(), SAFE);
      //println("Is safe.");
    }
  }
 
  void Regulate(){
    game2dai.maths.Vector2D theta = new game2dai.maths.Vector2D(this.heading);
    double thetaX = theta.x;
    double thetaY = theta.y;
    
    //body.setX(this.pos.x);
    //body.setY(this.pos.y);
    //body.setSpeed(this.velocity, thetaX);
    //eyes.setX(this.pos.x);
    //eyes.setY(this.pos.y);
    //eyes.setSpeed(this.velocity, thetaY);
  }
  
  game2dai.maths.Vector2D GetPos(){
    return pos; 
  }
  
  double GetMaxSpeed(){
    return maxSpeed; 
  }
  
    
  boolean IsSafe(){
    if (pos.distance(player.GetPos()) < DISTANCE) {
      return false;
      } else {
        return true;
      } 
  }
  
  boolean IsBreaking(){
    if (!active && moving)
      return true;
    else
      return false;
  }
  
  boolean IsStill(){
    if (!active && !moving)
      return true;
    else
      return false;
  }
}

class SentientPic extends BitmapPic {
  Sprite body;
  Sprite eyes;
  float size = 60;
  
  SentientPic(Sentient p){
    super(sketch, "pet_eyes.png");
    game2dai.maths.Vector2D temp = new game2dai.maths.Vector2D(p.pos());
    double x = temp.x;
    double y = temp.y;
    
    body = new Sprite(sketch, "pet_body.png", 1, true);
    eyes = new Sprite(sketch, "pet_eyes.png", 3, 1, 2, true);
    
    body.setRot(1.5);
    eyes.setRot(1.5);
  }
  
  void draw(BaseEntity user, float posX, float posY, float VelX,
  float velY, float headX, float headY, float etime) {
    //int size = 30;
    float angle = PApplet.atan2(headY, headX);
    
    pushStyle();
    pushMatrix();
    translate(posX, posY);
    rotate(angle);
    
    body.draw();
    eyes.draw();
    //ellipseMode(PApplet.CENTER);
    //fill(255);
    //stroke(0);
    //ellipse(headX, headY, size, size);
    
    //fill(0);
    //ellipse(0.12f*size, 0.18f*size, 0.12f*size, 0.22f*size);
    //ellipse(0.12f*size, -0.18f*size, 0.12f*size, 0.22f*size);

    popMatrix();
    popStyle();
  }
}