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
  
  void Turn(){
    ticks++;
    if (ticks >= customClock)
      ticks = customClock;
  }
  
  void Reset(){
    ticks = 0;
  }
  
}