final int UNSAFE = 100;
final int SAFE = 101;

class Sentient extends Vehicle{
  Vehicle body;
  BaseEntity target;
  Vector2D nextPos = new Vector2D(0, 0);
  Clock myClock = new Clock(Factor.Normal);
  
  boolean active = false;
  boolean safe = true;
  boolean moving = false;
  
  int action = 0;
  int hunger = 10;
  int walking = 0; //Number of walking cycles.
  
  color c = color(255, 255, 255);

  
  Sentient(double _x, double _y, double initSize, double maxVel){
    super(
      new Vector2D(_x, _y), //Position on screen. 
      initSize, 
      new Vector2D(0, 0), //Velocity.
      maxVel, 
      new Vector2D(1, 1), //Heading or initial direction of the AI.
      1, 
      0.5, //To be verified later, the AI's ability to turn should reflect its mass, e.g. 
      //the bigger it is the slower it will turn.
      2000 //Not quite sure what to put here yet, placeholder value.
    );
    addFSM();
}

  void AI(){
    if (active){
      Instinct();
    }  else if (!active && moving){ //If I was recently deactivated but am still moving...
      Break();
      println("Breaking");
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
  
  void Instinct(){
    double dist = abs(dist((float) this.pos.x, (float) this.pos.y, mouseX, mouseY));
    
    if (dist < DISTANCE){
       Dispatcher.dispatch(500, this.ID(), this.ID(), UNSAFE); 
    } else {
      
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
      this.velocity.sub(Vector2D.div(Vector2D.PLUS_I, 3)); 
    else
      this.velocity.sub(Vector2D.div(Vector2D.MINUS_I, 3));
      
    if (this.velocity.y > 0)  
      this.velocity.sub(Vector2D.div(Vector2D.PLUS_J, 3));
    else
      this.velocity.sub(Vector2D.div(Vector2D.MINUS_J, 3));
      
    //println(this.velocity);
    
    boolean xCloseToZero = this.velocity.x <= 0.4 && this.velocity.x >= -0.4;
    boolean yCloseToZero = this.velocity.y <= 0.4 && this.velocity.y >= -0.4;
      
    if (xCloseToZero && yCloseToZero){
      this.velocity.set(Vector2D.ZERO);
      moving = false;
      AP().wanderOff();
      println("Yipee kay yay motherfucker");
    }
  }
 
  void Regulate(){
    
  }
  
  Vector2D GetPos(){
    return pos; 
  }
}

class SentientPic extends PicturePS {
  int head, eye;
  float size;
  
  SentientPic(PApplet app, float _size, int _head, int _eye){
    super(app);
    this.size = _size;
    this.head = _head;
    this.eye = _eye;
  }
  
  SentientPic(PApplet app, float _size){
    this(app, _size, color(255), color (0));  
  }
  
  void draw(BaseEntity user, float posX, float posY, float VelX,
  float velY, float headX, float headY, float etime) {
  
    float angle = PApplet.atan2(headY, headX);
    
    pushStyle();
    pushMatrix();
    translate(posX, posY);
    rotate(angle);
    
    ellipseMode(PApplet.CENTER);
    fill(head);
    noStroke();
    ellipse(headX, headY, size, size);
    
    fill(eye);
    ellipse(0.12f*size, 0.18f*size, 0.12f*size, 0.22f*size);
    ellipse(0.12f*size, -0.18f*size, 0.12f*size, 0.22f*size);
    
    popMatrix();
    popStyle();
  }
}