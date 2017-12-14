import processing.sound.*;

SoundFile song;
SoundFile[] tones = new SoundFile[5];

int framesPerBeat = 15;

boolean on = false;

void setup(){
  size(500, 500);
  
  for (int i=0;i<tones.length;i++){
    tones[i] = new SoundFile(this, "tone0" + (i+1) + ".wav");
  }
}

void draw() {
  if (frameCount % framesPerBeat == 0 && on){
    //Pick a random index in the array)
    int randomIndex = floor (random(0, tones.length));
    
    tones[randomIndex].pan(map(mouseX, 0, width, -1, 1));
    
    tones[randomIndex].amp(map(mouseY, 0, height, 1, 0));
    
    tones[randomIndex].play();
  }
 
  float newRate = map(mouseX, 0, width, 0.01, 5);
}

void mouseClicked(){
    if (!on)
      on = true;
    else
      on = false;
}