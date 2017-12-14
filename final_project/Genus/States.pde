//All the states of th Sentient object are implemented here.
//The globalState is always responsive and makes sure the Pet is in the right
//state depending on its attributes (is it hungry, is it safe, is it moving, etc.)

final int SPEED_FACTOR = 2;

//The Global State: this is where we verify whether the Pet is safe or not. When it
//isn't, its state is changed to Flight regardless of its other needs. Ideally, this
//would take in consideration whether the Pet is sleeping or not and go through waking
//it up before sending it running.
public class GlobalState extends State {
  public void enter (BaseEntity user) {
    //Since its called all the time, it doesn't do anything on enter.
  }

  public void execute(BaseEntity user, double deltaTime, World world) {

    Sentient p = (Sentient)user;
    //Vector2D currPos = p.GetPos();

    //If the Pet is wandering, set avoid wall on.
    if (p.AP().isWanderOn() || p.AP().isFleeOn() || p.IsBreaking()) {
      p.AP().wanderOn().wallAvoidOn();
    }
    p.AP().wallAvoidWeight(100).wallAvoidFactors(4, 16, 2.6, false);
    //We set this method to ensure the Pet always avoids walls regardless of state.

    p.Instinct();

    //p.Regulate();
  }

  public void exit(BaseEntity user) {
    //Since its called all the time, it doesn't do anything on exit.
  }

  public boolean onMessage(BaseEntity user, Telegram tgram) {
    //The GlobalState sends the message to itself and verifies its value to change the
    //Pet's state.
    Sentient p = (Sentient)user;

    switch (tgram.msg) {
    case UNSAFE:
      p.FSM().changeState(flightState);
      return true;
    case SAFE:
      if (p.IsStill())
        p.FSM().changeState(idleState);
      return true;
    case TRANSITING:
      p.FSM().changeState(transitionState);
      return true;
    }
    return false;
  }
}
//The IdleState is the main state in which the Sentient is, in which it
//decides its further choices by checking its internal state.
//If we are here, it means the Pet is safe.
public class IdleState extends State {
  public void enter (BaseEntity user) {
    Sentient p = (Sentient)user;
    p.AP().allOff(); //Make sure the Pet doesn't have any steering behaviour activated
    //on entering Idle.

    //println("Entering idle.");
  }

  public void execute(BaseEntity user, double deltaTime, World world) {
    Sentient p = (Sentient)user;

    p.AI();

    switch(p.action) {
    case 0:
      //Maintain the Idle state.
      break;
    case 1:
      p.FSM().changeState(wanderState);
      break;
    }
  }

  public void exit(BaseEntity user) {
    Sentient p = (Sentient)user;
    //println("Leaving idle.");
  }

  public boolean onMessage(BaseEntity user, Telegram tgram) {
    return false;
  }
}

//This is the State called when the Pet is strolling around and doesn't have any
//dire need to be taken care of.
public class WanderState extends State {
  public void enter (BaseEntity user) {
    Sentient p = (Sentient)user;

    p.AP().wanderOn().wanderFactors(60, 30, 20);
    p.walking = floor(random(1, 6)); //The walking cycles is set when we enter
    //Wander and decides for how long will the Pet be wandering.
    p.myClock.Reset();

    //println("Entering wander.");
  }

  public void execute(BaseEntity user, double deltaTime, World world) {
    Sentient p = (Sentient)user;
    p.TakeOff();

    //The Pet's walking is sent to the Clock's overloaded Cycle method: how long
    //it walks is determined here. Once the Cycle returns true, it means its over
    //and the Pet can go back to its Idle mode.
    if (p.myClock.Cycle(p.walking)) {
      p.active = false;
      p.myClock.Reset();
      println("End of walking cycle.");
      p.FSM().changeState(transitionState);
    }
  }

  public void exit(BaseEntity user) {
    Sentient p = (Sentient)user;

    p.AP().wanderOff();
    p.active = false; //Active is turned false but not moving: the Pet will start
    //breaking.
    p.action = -1;

    //println("Leaving wander.");
  }

  public boolean onMessage(BaseEntity user, Telegram tgram) {
    return false;
  }
}

public class FlightState extends State {
  public void enter (BaseEntity user) {
    Sentient p = (Sentient)user;
    p.maxTurnRate(15);
    p.turnRate(15);
    p.maxSpeed(p.GetMaxSpeed() * SPEED_FACTOR);
    p.AP().fleeOn(player.GetPos());
    p.moving = true;

    //println("Enter flight.");
  }

  public void execute(BaseEntity user, double deltaTime, World world) {
    Sentient p = (Sentient)user;

    p.AP().wallAvoidWeight(100).wallAvoidFactors(4, 16, 2.6, false);
    //if (p.turnRatransitionte() < p.maxTurnRate() && !p.moving) {
    //  p.turnRate(p.turnRate() + (EASING.x*p.maxTurnRate()));
    //  println("Yuppidee!");
    //} else if (!p.moving) {
    //  p.maxSpeed(p.GetMaxSpeed() * SPEED_FACTOR);
    //  p.moving = true;
    //  println("Boodiecan!");
    //}
  }

  public void exit(BaseEntity user) {
    Sentient p = (Sentient)user;

    p.turnRate(0.5);
    p.maxTurnRate(0.5);
    p.maxSpeed(p.GetMaxSpeed() / SPEED_FACTOR);
    p.active = false;

    //println("Leaving flight.");
  }

  public boolean onMessage(BaseEntity user, Telegram tgram) {
    return false;
  }
}

public class TransitionState extends State {
  public void enter (BaseEntity user) {
    Sentient p = (Sentient)user;
    //println("Entering transition.");
  }

  public void execute(BaseEntity user, double deltaTime, World world) {
    Sentient p = (Sentient)user;
    //println("Is active? " + p.active);
    //println("Is moving? " + p.moving);
    p.AP().wanderOff();
  }

  public void exit(BaseEntity user) {
    Sentient p = (Sentient)user;

    p.myClock.SetCycle(Factor.Normal);
    p.myClock.Reset();

    //println("Leaving transition.");
  }

  public boolean onMessage(BaseEntity user, Telegram tgram) {
    return false;
  }
}


//public class GenericState extends State {
//  public void enter (BaseEntity user){
//    Sentient p = (Sentient)user;

//  }

//  public void execute(BaseEntity user, double deltaTime, World world){
//    Sentient p = (Sentient)user;
//  }

//  public void exit(BaseEntity user) {
//    Sentient p = (Sentient)user;
//  }

//  public boolean onMessage(BaseEntity user, Telegram tgram) {
//    return false;  
//  }
//}