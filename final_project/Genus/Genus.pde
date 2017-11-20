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

final double VELOCITY = 70;
final double SIZE = 30;
final Vector2D EASING = new Vector2D(0.1, 0.1);
final double DISTANCE = 180;

World world;
StopWatch sw;

Sentient pet;
Player player;
Building[] walls;
BuildingPic wallPic;

void setup() {
  size (768, 1024);
  world = new World(width, height);
 
  createWorld();
  createPet();
  CreatePlayer();
  
  sw = new StopWatch();
}

void draw() {
  double elapsedTime = sw.getElapsedTime();
  world.update(elapsedTime);
  background(150);
  player.Update();
  world.draw(elapsedTime);
}

void createPet() {
  pet = new Sentient(
    width/2, 
    height/2, 
    SIZE, //Initial size.
    VELOCITY //Initial velocity.
   );
    
  Domain d = new Domain(0, 0, width, height);
  pet.worldDomain(d, SBF.WRAP);
  pet.viewFactors(100, 0.9f*PApplet.TWO_PI);
  pet.FSM().setGlobalState(globalState);
  pet.FSM().changeState(idleState);
  pet.renderer(new SentientPic(this, 30));
  
  world.add(pet);
}

void CreatePlayer(){
  player = new Player();
  
  world.add(player);
}

void createWorld(){
  walls = Building.makeFromXML(this, "buildings.xml");
  wallPic = new BuildingPic(this, color(50), color(155), 0);
  
    println("Initialize walls creation... " + walls.length);
    
  for (int i = 0; i < walls.length; i++){
    println("Building #" + (i+1) + " created.");
    walls[i].renderer(wallPic);
    world.add(walls[i]);
  }
}

public void keyTyped() {
  int selectedHint = -1;
  switch(key) {
  case '1':
    selectedHint = Hints.HINT_HEADING;
    break;
  case '2':
    selectedHint = Hints.HINT_VELOCITY;
    break;
  case '3':
    selectedHint = Hints.HINT_WANDER;
    break;
  case '4':
    selectedHint = Hints.HINT_VIEW;
    break;
  case '5':
    selectedHint = Hints.HINT_OBS_AVOID;
    break;
  case '0':
    selectedHint = 0;
    break;
  }
  if (selectedHint == 0) { // remove all hints
    pet.renderer().showHints(selectedHint);
  }
  else if (selectedHint > 0) { // toggle hint selected
    boolean hintOn = (pet.renderer().getHints() & selectedHint) == selectedHint;
    if (hintOn) {
      pet.renderer().removeHints(selectedHint);
    }
    else {
      pet.renderer().addHints(selectedHint);
    }
  }
}