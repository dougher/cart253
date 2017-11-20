class Player extends MovingEntity{
  Player(){
    super(
      new Vector2D(0, 0), //Position on screen. 
      SIZE/2, 
      new Vector2D(0, 0), //Velocity.
      0, 
      new Vector2D(1, 1), //Heading or initial direction of the AI.
      1, 
      0.5, //To be verified later, the AI's ability to turn should reflect its mass, e.g. 
      //the bigger it is the slower it will turn.
      2000 //Not quite sure what to put here yet, placeholder value.
    );
  }
  
  void Update(){
    pos.set(mouseX, mouseY);
    velocity.set(mouseX - pmouseX, mouseY - pmouseY);
  }
  
  Vector2D GetPos(){
    return pos;
  }
  
}