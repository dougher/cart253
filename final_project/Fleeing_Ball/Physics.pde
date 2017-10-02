class Physics{
  
  enum CollFrom{
    Null, Left, Top, Right, Down;
  };
  
  float x;
  float y;
  float w;
  float h;
  float minX; //sides
  float minY;
  float maxX;
  float maxY;
  float mass; //really just square area because magic 2D land.
  
  CollFrom hitFrom;
  
  float[][] grid;
  
  Physics(int posX, int posY, int objW, int objH){
    x = posX;
    y = posY;
    w = objW;
    h = objH;
    
    minX = x - w/2;
    minY = y - h/2;
    maxX = x + w/2;
    maxY = y + h/2;
    
    hitFrom = CollFrom.Null;
    
    mass = x * y;
  }
  
  void SetGrid(){
    int i = 0;
    int j = 0;
    
    while (i < w){
      while (j < h){
      
      }
    }
  }
  
  boolean CheckLimits(Physics collider){
     if 
     if (collider.maxX >= minX && collider.w <= w){
      

      return false;
  }
  
  void Collide(Physics collider){
    if (CheckLimits())
    
    else
  }
  
  float GetMass(){
    return mass;
  }
  
  float DistWith(Physics target){
    float d;
    d = dist(target.x, target.y, x, y);
    return d;
  }
}