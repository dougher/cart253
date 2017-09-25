int x = 0;
int y = 0;
float c = 0;
int space = 10;

void setup() {
  size (640, 480);

  background(255);
}

void draw() {
  noStroke();

  println("Boucle ouvre et ferme");

  x = 0;
  while (x < width) {
    c = abs(mouseX - x);
    c = constrain(c, 0, 255);
    
    fill(c);

    rect(x, y, space, height);

    x+=space;
    
  }
}