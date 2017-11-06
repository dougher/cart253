PImage myImage;
int tick = 0;

void setup() {
  size(632,475);
  myImage = loadImage("http://buildingontheword.org/wp-content/uploads/2016/08/cat.jpg");
}
void draw() {
  image(myImage,0,0);
  
  if (tick > 0){
    myImage.loadPixels(); // Get ready!
    for (int i = 0; i < myImage.pixels.length; i++) {
     myImage.pixels[i] += random(-200,800);
    }
    myImage.updatePixels(); // Change!
    tick -= 1;
  }
}

void mousePressed(){
   if (tick <= 0)
     tick = 220;
}