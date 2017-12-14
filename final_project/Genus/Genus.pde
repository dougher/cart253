import game2dai.*;
import game2dai.entities.*;
import game2dai.entityshapes.*;
import game2dai.entityshapes.ps.*;
import game2dai.fsm.*;
import game2dai.graph.*;
import game2dai.maths.*;
import game2dai.steering.*;
import game2dai.utils.*;

import sprites.*;
import sprites.maths.*;
import sprites.utils.*;

PApplet sketch = this;

GlobalState globalState = new GlobalState();
IdleState idleState = new IdleState();
WanderState wanderState = new WanderState();
FlightState flightState = new FlightState();
TransitionState transitionState = new TransitionState();

final double VELOCITY = 70;
final double SIZE = 30;
final game2dai.maths.Vector2D EASING = new game2dai.maths.Vector2D(0.1, 0.1);
final double DISTANCE = 180;

World world;
game2dai.utils.StopWatch sw;

Sentient pet;
Player player;
Building[] walls;
BuildingPic wallPic;
ArrayList<Grass> pasture = new ArrayList<Grass>();
ArrayList<Tree> flaura = new ArrayList<Tree>();

void setup() {
  size (768, 1024);
  world = new World(width, height);
 
  createWorld();
  createPet();
  CreatePlayer();
  
  //registerMethod("pre", this);
  sw = new game2dai.utils.StopWatch();
}

void draw() {
  double elapsedTime = sw.getElapsedTime();

  world.update(elapsedTime);
  S4P.updateSprites(elapsedTime);
  player.Update();
  UpdateFlaura();
  
  background(150);
  S4P.drawSprites();
  world.draw(elapsedTime);
}

//public void pre() {
//  // Calculate time difference since last call
//  float elapsedTime = (float) sw.getElapsedTime();
//  //processCollisions();
//  //if (nbr_dead == NBR_GHOSTS)
//  //  initGhosts();
//  S4P.updateSprites(elapsedTime);
//}

void CreatePlayer(){
  player = new Player();
  
  world.add(player);
}

void createWorld(){
  int nbGrassW = (width - 196) / (60 - 8);
  int nbGrassH = (height - 224) / (60 - 7);
  
  for (int i = 0; i < nbGrassH; i++){
    for(int j = 0; j < nbGrassW; j++){
      Grass curr = new Grass(pasture.size(), (98 - 4) + ((60 - 8)* j), (112 - 4) + ((60 - 7) * i));

      pasture.add(curr);
      world.add(pasture.get(pasture.size()-1));
    }
  }
  
  println("Pasture size: " + pasture.size());
    //println("Element #1 of pasture: " + pasture.get(10).toString());
  
  walls = Building.makeFromXML(this, "buildings.xml");
  wallPic = new BuildingPic(this, color(50), color(155), 0);
  
  println("Initialize walls creation... " + walls.length);
    
  for (int k = 0; k < walls.length; k++){
    println("Building #" + (k+1) + " created.");
    walls[k].renderer(wallPic);
    world.add(walls[k]);
  } 
}

void createPet() {
  pet = new Sentient(
    width/2, 
    height/2, 
    SIZE, //Initial size.
    VELOCITY //Initial velocity.
   );
    
  game2dai.Domain d = new game2dai.Domain(0, 0, width, height);
  pet.worldDomain(d, SBF.WRAP);
  pet.viewFactors(100, 0.9f*PApplet.TWO_PI);
  pet.FSM().setGlobalState(globalState);
  pet.FSM().changeState(idleState);
  pet.renderer(new SentientPic(pet));
  pet.AP().obstacleAvoidDetectBoxLength(45);
  
  world.add(pet);
}

void UpdateFlaura(){
  for (int i = 0; i < flaura.size(); i++){
    flaura.get(i).Grow(); 
  }
}

void mousePressed(){
  int x = mouseX;
  int y = mouseY;
  Tree current;
  boolean freeSpace = true;
  
 
  for (int i = 0; i < flaura.size(); i++){
    Tree temp = flaura.get(i);
    game2dai.maths.Vector2D tempV2D = temp.pos();
    double[] tempPos = tempV2D.toArray();
    //We get a copy of the current tree (i) to check in the list,
    //as well as its temp position and turn the position to an array
    //For easy access.
    
    println();
    
    boolean collLeft =  x + (128/2) > tempPos[0] - (128/2);
    boolean collRight = x - (128/2)  < tempPos[1] + (128/2);
    boolean collUp = y + (148/2) > tempPos[1] - (148/2);
    boolean collDown = y - (148/2) < tempPos[1] + (148/2);
    
     if (collLeft && collRight && collUp && collDown){
       println("There is already a tree here!");
       freeSpace = false;
     }
  }
  
  if (freeSpace){
    current = new Tree(flaura.size(), x, y);
    flaura.add(current);
    world.birth(flaura.get(flaura.size()-1), 0);
    println("Planted tree #" + (flaura.size()));
  } 
}

//void keyTyped() {
//  int selectedHint = -1;
//  switch(key) {
//  case '1':
//    selectedHint = Hints.HINT_HEADING;
//    break;
//  case '2':
//    selectedHint = Hints.HINT_VELOCITY;
//    break;
//  case '3':
//    selectedHint = Hints.HINT_WANDER;
//    break;
//  case '4':
//    selectedHint = Hints.HINT_VIEW;
//    break;
//  case '5':
//    selectedHint = Hints.HINT_OBS_AVOID;
//    break;
//  case '0':
//    selectedHint = 0;
//    break;
//  }
//  if (selectedHint == 0) { // remove all hints
//    pet.renderer().showHints(selectedHint);
//  }
//  else if (selectedHint > 0) { // toggle hint selected
//    boolean hintOn = (pet.renderer().getHints() & selectedHint) == selectedHint;
//    if (hintOn) {
//      pet.renderer().removeHints(selectedHint);
//    }
//    else {
//      pet.renderer().addHints(selectedHint);
//    }
//  }
//}