final int UNSAFE = 100;
final int SAFE = 101;

class Sentient extends Vehicle{
  Vehicle body;
  BaseEntity target;
  boolean safe = true;
  boolean moving = false;
  
  color c = color(255, 255, 255);

  
  Sentient(double _x, double _y, double _vx, double _vy, double initSize, double initMaxSpeed){
    super(
      new Vector2D(_x, _y), //Position on screen. 
      initSize, 
      new Vector2D(_vx, _vy), //Velocity.
      initMaxSpeed, 
      new Vector2D(0, 0), //Heading or initial direction of the AI.
      _x * _y, 
      initMaxSpeed/(_x*_y), //To be verified later, the AI's ability to turn should reflect its mass, e.g. 
      //the bigger it is the slower it will turn.
      initMaxSpeed * 0.5 //Not quite sure what to pu here yet, placeholder value.
    );
    addFSM();
}
  
  void AI(){

    double dist = dist((float) this.pos.x, (float) this.pos.y, mouseX, mouseY);
    
    if (dist < DISTANCE){
       Dispatcher.dispatch(500, this.ID(), this.ID(), UNSAFE); 
    }
  }
  
  void Instinct(){
    
  }
  
  void Flight(){
    
  }
  
  void Regulate(){
    this.pos.x = constrain((int)this.pos.x, 0, width);
    this.pos.y = constrain((int)this.pos.y, 0, height);
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