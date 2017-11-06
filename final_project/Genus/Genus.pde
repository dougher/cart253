import game2dai.*;
import game2dai.entities.*;
import game2dai.entityshapes.*;
import game2dai.entityshapes.ps.*;
import game2dai.fsm.*;
import game2dai.graph.*;
import game2dai.maths.*;
import game2dai.steering.*;
import game2dai.utils.*;

GlobalState globalState = new GlobalState();
IdleState idleState = new IdleState();
WanderState wanderState = new WanderState();
FlightState flightState = new FlightState();

final double VELOCITY = 15;
final double DISTANCE = 90;

World world;
StopWatch sw;

Sentient Pet;
ArrowPic view = new ArrowPic(this);

void setup() {
  size (500, 500);
  world = new World(width, height);
  
  createPet();
  
  sw = new StopWatch();
}

void draw() {
  double elapsedTime = sw.getElapsedTime();
  world.update(elapsedTime);
  background(150);
  world.draw(elapsedTime);
}

void createPet() {
  Pet = new Sentient(
    width/2, 
    height/2, 
    VELOCITY, 
    VELOCITY, 
    30, 
    30
   );
    
  view.showHints(Hints.HINT_WANDER);
  Pet.renderer(view);

  Domain d = new Domain(0, 0, width, height);
  Pet.worldDomain(d, SBF.WRAP);

  Pet.FSM().setGlobalState(globalState);
  Pet.FSM().changeState(idleState);
  Pet.renderer(new SentientPic(this, 30));
  
  world.add(Pet);
}