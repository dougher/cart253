enum Factor{
  Slower, Slow, Normal, Fast, Faster;
};

final int CLOCK = 120;
final int NB_OF_FRUITS = 8;

Ball myBall;
Fruit[] Fruits;


void setup() {
  size (500, 500);
  background(0);

  fill(255);
  
  myBall = new Ball(width, height);
  Fruits = new Fruit[NB_OF_FRUITS];
  
  for(int i = 0; i < NB_OF_FRUITS; i++){
     Fruits[i] = new Fruit();
  }
}

void draw() {
  background(0);

  myBall.AI();
  
  for (int i = 0; i < NB_OF_FRUITS; i++){
    if (Fruits[i].placed){
      Fruits[i].Grow();
    }
  }
}

void mousePressed(){
  for (int i = 0; i < NB_OF_FRUITS; i++){
    if (!Fruits[i].placed){
        Fruits[i].Place(mouseX, mouseY);
        i = NB_OF_FRUITS;
    }
  }
}