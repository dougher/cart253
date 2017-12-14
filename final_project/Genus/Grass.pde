class Grass extends BaseEntity{
  Sprite img = new Sprite(sketch, "grass.png", 0, true);
  double x = 0;
  double y = 0;
  
  Grass(int id, double _x, double _y){
    super("grass" + id, new game2dai.maths.Vector2D(_x, _y), 60);
    x = _x;
    y = _y;
    
    img.setDomain(x, y,x + 60, y + 60, Sprite.HALT);
  }
}