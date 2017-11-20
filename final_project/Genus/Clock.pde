final int CLOCK = 120;

enum Factor{
  Slower, Slow, Normal, Fast, Faster;
};

class Clock{
  int ticks;
  int customClock;
  
  Clock(Factor myFactor){
    ticks = 0;
    
    switch (myFactor){
      case Slower:
        customClock = CLOCK * 5;
        break;
      case Slow:
        customClock = CLOCK * 2;
        break;
      case Normal:
        customClock = CLOCK;
        break;
      case Fast:
        customClock = CLOCK / 2;
        break;
      case Faster:
        customClock = CLOCK / 5;
        break;
    }
  }
  
  boolean Cycle(){
    Turn();
    
    if (ticks >= customClock)
      return true;
    else
      return false;
  }
  
  boolean Cycle(int nbOfCycles){
    switch (nbOfCycles){
      case 1:
        customClock = CLOCK * 5;
        break;
      case 2:
        customClock = CLOCK * 2;
        break;
      case 3:
        customClock = CLOCK;
        break;
      case 4:
        customClock = floor(CLOCK / 1.5);
        break;
      case 5:
        customClock = CLOCK / 2;
        break;
    }
    //println("Walk cycle: "  + nbOfCycles);
    
    Turn();
    
    if (ticks >= customClock)
      return true;
    else
      return false;
  }
  
  void Turn(){
    ticks++;
    if (ticks >= customClock)
      ticks = customClock;
  }
  
  void Reset(){
    ticks = 0;
  }
  
}