final int PIXELS_PER_MORPHING = 10000;
//This variable is what calculates how fast the image is morphing. At the beginning
//it is "slow" but I want it to increase in speed and start morphing several images
//at a time. To be implemented...

class WhiteNigger extends Portrait{
  Animation current, temp, origin, trade, resistance, defamation, fission;
  
  boolean morphing = false;
  ArrayList<Boolean> pixelMorphed = new ArrayList<Boolean>();
  //The dynamic array of Boolean. Since not all images have the exact same size,
  // the Booleans are emptied and refilled appropriatedly each time.
  
  int i = 0; // Instead of using the i in a for, it is the same one that is kept and
  //reinitialized whenever the process that uses it ( MorphToImg() ) reaches its end 
  //and reinitializes.

  //We call the super constructor and then initialize our specific attributes: in this
  //case, several animations.
  WhiteNigger(boolean _balance, String _name, String _code){
    super(_balance, _name, _code);
    current = new Animation();
    temp = new Animation();
    //We initiate the current and the temp to be at least declared.
    //Then we load each animation's images.
    origin = new Animation("origin_", 9, 10);
    //println("Origin anim info: " + origin.imageCount + " " + origin.images.length);
    trade = new Animation ("trade_", 14, 10);
    //println("Trade anim info: " + trade.imageCount + " " + trade.images.length);
    resistance = new Animation ("resistance_", 15, 10);
    //println("Resistance anim info: " + resistance.imageCount + " " + resistance.images.length);
    
    current.Clone(origin); //We call the Animation method to Clone the image partly
    //dynamically.
    temp = new Animation(); //Probably obsolete, since the current is now a new object 
    //and not just a reference.
    
    SetBooleans(); //The function that fills pixelMorphed with enough false booleans.
  }
 
  void Idle(){ //When untouched, the image plays continuously.
  //In the near future, current willrandomize pictures from all the animations. 
  //Only when the portait is interacted with, will it become the corresponding 
  //animation.
    current.changeRate(10);
    current.display(width/2, height/2);
  }
  
  //Called whenever the mouse is clicked/released.
  void Contact(boolean stimulus) {
    activated = stimulus;
    
    if (activated){

    } else {
      CheckPrefix(); //??? Not sure why I put this here anymore.
      
      i = 0;
      RemoveBooleans();
    }
  }
  
    //When we are activated, we basically go in and out of the same loop. If we
    //are not morphing, set morphing to true and start the process (until it self
    //deactivates.
  void Active(){
    if (!morphing){
        morphing = true;
        if (pixelMorphed.size() <= 0) //Was pixelMorphed initialized? If not, do it.
          SetBooleans();
        //println("Pixels length: " + );
      } else{
        MorphToImg();
      }
  }
  
  //NOTE: could possibly be in Animation, depends on how the class ends up being used
  //in the other portrait...
  void MorphToImg(){
    //To avoid the process of drawing pixels too long, we use a final variable to set
    //the amount of pixels drawn at every cycle; the loop continues until j becomes big enough,
    //then the image is updated to the screen and we redo the same.
    for (int j = 0; j < PIXELS_PER_MORPHING; j++){
      i = FindFalse(); //Call method that sends back a pixeMorphed[i]that is 
      // currently false. If none are, the i is put one unit higher than the 
      //pixelMorphed.length to throw itself out of the morphing loop.
      if (i > pixelMorphed.size())
        break;
      
      //If we're here, it means there are still pixels to morph. Right now, this might
      //bug a little bit because the images don't seem to completely finish morphing.
      //println("Current pixel: " + i);
      current.images.get(current.currentFrame).loadPixels(); // Get ready!
      current.images.get(current.currentFrame).pixels[i] = (current.images.get((current.currentFrame+1)%current.imageCount).pixels[i]);
      current.images.get(current.currentFrame).updatePixels();
      
      pixelMorphed.set(i, true); //We change the current pixel boolean (i) to true
    }
    
    //Every 1000 pixel morphed, we draw the image.
    imageMode(CENTER);
    image(current.images.get(current.currentFrame), width/2, height/2);
  }
  
  //This method serves to pick a random pixel to morph, which is put in currentPixel.
  //If the image is done morphing, the same variable is used to throw MorphToImg out 
  //of its loop.
  int FindFalse(){
    int currentPixel = 0;
    
     if (!AreAllTrue()){ //If you are not all true, we are still in the process of 
    //morphing to the next image. Get the next false randomized pixel to morph.
      do { //Do...while ensures it happens at least once.
        currentPixel = (int) random(0, pixelMorphed.size());
      } while (pixelMorphed.get(currentPixel)); //the loop continues as long
      //as we get a pixel that has already morphed.
    
      return currentPixel;
     } else{
      
      TurnMorphOff();
      
      int lastPixelMorphed = pixelMorphed.size() + 1;
      return lastPixelMorphed;
    } 
  }
  
  //Once all pixels are morphed, we "turn off" this function and its components 
  //(morphing boolean & i), we manually change the currentFrame and turn to false 
  //the pixelMorphed array.
  void TurnMorphOff(){
      println("The image is done morphing to the next one!");
      
      CheckPrefix();
      current.currentFrame = (current.currentFrame+1) % current.imageCount;
      
      RemoveBooleans();
      morphing = false;
      i = 0;
  }
  
  //Set and Remove Booleans allow to dynamically change the amount of pixelMorphed
  //to fit all images.
  void SetBooleans(){
    boolean k = false;
    for (int j=0; j < current.images.get(0).pixels.length; j++){
      pixelMorphed.add(k);
    }
    
  }
  
  void RemoveBooleans(){
    for (int j = pixelMorphed.size()-1; j >= 0; j--){
      pixelMorphed.remove(j);
    }
  }
  
  //Simple method to verify if all pixels have been morphed.
  boolean AreAllTrue(){
    for (int j=0; j < pixelMorphed.size();j++){
      if (pixelMorphed.get(j) == false)
        return false;
    }
    return true;
  }

   //Change copy of current animation array.
  void ChangeCurrent(int currentNb){
    switch(currentNb){
      case 1:
        current.Clone(origin);
        break;
      case 2:
        current.Clone(trade);
        break;
      case 3:
        current.Clone(resistance);
        break;
      default:
        println("Wow les moteurs.");
        break;
    }
  }
  
  //This method is called when the morph is turning off to replace the image that 
  //has just been modified to its untouched state. I tried changing the parameter
  //to something like (current.currentFrame+1) % current.imageCount but with -1
  //instead but I'm realizing -1/9 wouldn't work too well...
  //The point would be to change frame first and reset the previous frame after 
  //(and maybe get rid of the imageless flash)
  void CheckPrefix(){
    switch (current.prefix){
        case "origin_":
          current.ReplaceFrame(origin.images.get(current.currentFrame));
          break;
        case "trade_":
          current.ReplaceFrame(trade.images.get(current.currentFrame));
          break;
        case "resistance_":
          current.ReplaceFrame(resistance.images.get(current.currentFrame));
          break;
      }
  }
}