//This super class is still very rudimentary but it should implement all the mandatory
//attributes and methods that all future portraits will share. So far there is only
//"White Nigger", the main focus for now.

abstract class Portrait{
  boolean balanced; //Mode of portait: true = balanced, false = cognitive dissonance
  String name;
  String code;
  //Originally supposed to be balanced (top boolean turned to true) through a code
  //learned in a different portrait but I'm unsure about this idea...maybe they'd be
  //self-realizable. To be continued...
  boolean activated = false;
  //Serves to see if the portrait is being touched or not (so far represented with
  //the mouse but ultimately touch screen).
  
  //Simple constructor, we copy the basic information.
  Portrait(boolean _balance, String _name, String _code){
    balanced = _balance;
    name = _name;
    code = _code;
    
  }
}