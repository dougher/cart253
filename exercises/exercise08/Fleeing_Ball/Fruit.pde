final float FRUIT_MAX_SIZE = 15;

class Fruit{
  Clock myClock;
  
  float h;
  float w;
  int r;
  int g;
  int b;
  
  float x;
  float y;
  
  int growth; // 0 = grain, 1 = unripe, 2 = ripe, 3 = rotten.
  
  boolean placed;
  
  Fruit(){
    myClock = new Clock(Factor.Slower);
    
    Reset();
  }
  
  void Place(int posX, int posY){
    x = posX;
    y = posY;
    placed = true;
  }
  
  void Grow(){
    if(myClock.Cycle() && growth < 4){
      growth++; 
      myClock.Reset();
    } else
      println(myClock.ticks);
    
    Update();
    Display();
  }
  
  boolean IsEdible(){
    if (growth == 2)
      return true;
    else
       return false;
  }
  
  void Update(){
    switch (growth){
      case 0:
      
        break;
      case 1:
        if (h < FRUIT_MAX_SIZE && w < FRUIT_MAX_SIZE){
          h += 0.1;
          w += 0.1;
        }
        if (r > 175)
          r--;   
        break;
      case 2:
        if (g > 30)
          g--;
        if (b > 30)
          b--;
        break;
      case 3:
        if (r > 105)
          r--;   
        if (g < 60)
          g++;
        if (b < 40)
          b++;
        break;
      case 4:
        if (h > 0)
          h-=0.1;
        else
          Reset();
        break;
    }
    
    fill (r, g, b);
  }
  
  void Display(){
    ellipse(x, y, w, h);
  }
  
  void Reset(){
    x = -5;
    y = -5;
    h = 5;
    w = 5;
    r = 225;
    g = 205;
    b = 100;
    
    growth = 0;
    placed = false;
  }
}