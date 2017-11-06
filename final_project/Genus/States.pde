//All the states of th Sentient object are implemented here.
//The globalState is always responsive and checks the Sentient's need for safety,
//To ensure that need trumps all other ones (so far).
public class GlobalState extends State {
  public void enter (BaseEntity user){
    
  }
  
  public void execute(BaseEntity user, double deltaTime, World world){

  }
  
  public void exit(BaseEntity user) {
    
  }
  
  public boolean onMessage(BaseEntity user, Telegram tgram) {
    Sentient p = (Sentient)user;
    
    switch (tgram.msg){
      case UNSAFE:
        p.FSM().changeState(flightState);
        return true;
      case SAFE:
        p.FSM().changeState(idleState);
        return true;
    }
    return false; 
  }
}
//The IdleState is the main state in which the Sentient is, in which it
//decides its further choices (do I feed myself, do I sleep, do I wander...)
public class IdleState extends State {
  public void enter (BaseEntity user){
    Sentient p = (Sentient)user;
    p.AP().allOff();
  }
  
  public void execute(BaseEntity user, double deltaTime, World world){
    Sentient p = (Sentient)user;
    p.AI();
    
    
  }
  
  public void exit(BaseEntity user) {
    Sentient p = (Sentient)user;
  }
  
  public boolean onMessage(BaseEntity user, Telegram tgram) {
    return false;  
  }
}

public class WanderState extends State {
  public void enter (BaseEntity user){
    Sentient p = (Sentient)user;
    p.AP().wanderOn();
  }
  
  public void execute(BaseEntity user, double deltaTime, World world){
    Sentient p = (Sentient)user;
  }
  
  public void exit(BaseEntity user) {
    Sentient p = (Sentient)user;
    p.AP().wanderOff();
  }
  
  public boolean onMessage(BaseEntity user, Telegram tgram) {
    return false;  
  }
}

public class FlightState extends State {
  public void enter (BaseEntity user){
    Sentient p = (Sentient)user;
    
  }
  
  public void execute(BaseEntity user, double deltaTime, World world){
    Sentient p = (Sentient)user;
  }
  
  public void exit(BaseEntity user) {
    Sentient p = (Sentient)user;
  }
  
  public boolean onMessage(BaseEntity user, Telegram tgram) {
    return false;  
  }
}