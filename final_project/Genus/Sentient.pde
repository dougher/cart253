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
  
  color c = color(255, 255, 255);

  
  Sentient(double _x, double _y, double initSize, double maxVel){
    super(
      new Vector2D(_x, _y), //Position on screen. 
      initSize, 
      new Vector2D(0, 0), //Velocity.
      maxVel, 
      new Vector2D(0, 0), //Heading or initial direction of the AI.
      _x * _y, 
      maxVel/(_x*_y), //To be verified later, the AI's ability to turn should reflect its mass, e.g. 
      //the bigger it is the slower it will turn.
      maxVel * 0.5 //Not quite sure what to pu here yet, placeholder value.
    );
    addFSM();
}

  void AI(){
    if (active){
      
    } else{
       if (myClock.Cycle()){
         active = true;
         
         if (hunger <= 4)
            action = 2;
          else
            action = 1;
       }
    }
  }
  
  void Instinct(){

    double dist = dist((float) this.pos.x, (float) this.pos.y, mouseX, mouseY);
    
    if (dist < DISTANCE){

       Dispatcher.dispatch(500, this.ID(), this.ID(), UNSAFE); 
    } else {
      action = (int) random(0, 3);
    }
  }
  
  void CalculateTarget(){
    switch (action){
      case 1:
        nextPos.set( (double) random((float) (this.pos.x-DISTANCE), (float) (this.pos.x+DISTANCE)), 
                     (double) random((float) (this.pos.y-DISTANCE), (float) (this.pos.y+DISTANCE))
          );
          
        println(nextPos.x + " " + nextPos.y);
        break;
    }
  }
  
  
  void Start(){
    if (this.velocity.x <= 15)
      this.velocity.add(0.1, 0.5);
  }
 
  
  void Flight(){
    
  }
  
  void Regulate(){
    
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