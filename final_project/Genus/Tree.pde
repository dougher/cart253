class Tree extends Obstacle{
  Sprite img;
  Clock myClock;
  int growth = 0;
  int nbOfTree;
  
  Tree(int id, double _x, double _y){
    super("tree" + id, new game2dai.maths.Vector2D(_x, _y), 148);
    
    img = new Sprite(sketch, "tree_growth.png", 4, 1, 1, true);
    myClock = new Clock(Factor.Slower);
    
    img.setDomain(_x - (128/2), _y - (148/2),_x + 128, _y + 148, Sprite.HALT);
  }
  
  void Grow(){
    if (myClock.Cycle() && growth < 3){
       growth++;
       myClock.Reset();
    }
    
    Update();
  }
  
  void Update(){
    switch (growth){
        case 0:
          img.setFrame(0);
          break;
        case 1:
          img.setFrame(1);
          break;
        case 2:
          img.setFrame(2);
          break;
        case 3:
          img.setFrame(3);
          break;
       }
  }
}