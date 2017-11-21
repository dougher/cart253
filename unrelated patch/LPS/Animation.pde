//Augmented Animation class to accomodate current manipulations.

class Animation {
  // An array of PImages to store the separate frames
  ArrayList<PImage> images = new ArrayList<PImage>();
  // The images are now an ArrayList instead for a normal array to allow them to be
  //resized dynamically.
  int imageCount;
  // The current frame being displayed
  int currentFrame;
  // The number of frames of the program per frame of animation
  int rate;
  //The rate at which the animation plays.
  String prefix;
  //A string to keep in memory the prefix given as a parameter to the constructor.

  // Simple Animation constructor to initiate an empty animation.
  Animation(){
    imageCount = 0;
    currentFrame = 0;
    rate = 0;
  }
  
  // Loads the separate images into the dynamic PImage array
  // Sets the rate to display
  Animation(String _prefix, int count, int tempRate) {
    prefix = _prefix;
 
    imageCount = count;

    // Save the rate
    rate = tempRate;
    
    LoadImages();
  }

  //To deeply copy the object, implement of method that allows to do that thanks to
  //dynamic allocation.
  void Clone(Animation toClone){
    DeleteImages();
    
    prefix = toClone.prefix;
    imageCount = toClone.imageCount;
    rate = toClone.rate;
    currentFrame = 0;
    
    LoadImages();
  }
  
  void LoadImages(){
    //load that image into the array
    
    for (int i = 0; i < imageCount; i++) {
      PImage currentImage;
      String filename = prefix + (i+1) + ".png";
      println("Current filename: " + filename);
      currentImage = loadImage("sprites/" + filename);
      images.add(currentImage);
    }
  }
  
  void DeleteImages(){
    for (int i = images.size() - 1; i >= 0; i--){
      images.remove(i);
    }
    
    println("Images deleted. Array length: " + images.size());
  }
  
  //This method is called when we are finished with morphing an image. To avoid 
  //having duplicates of images (and ending up with 2-3 of the original dozen 
  //images) this function replaces the current frame right before it is changed
  //To give it back its original appearance.
  void ReplaceFrame(PImage imgToReset){
    images.set(, imgToReset);
    println("Frame has been replaced.");
  }

//Change rate of the animation. Probably obsolete since the portait takes
//care itself of having a different rate when it os active. Those functionalities 
//would make sense here actually... xox 
void changeRate(int newRate){
  rate = newRate;
}

  // display(x,y)
  //
  // Should be called every frame.
  // Displays the appropriate frame of animation
  void display(float xpos, float ypos){
     if (frameCount % rate == 0) {
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % imageCount;
    }
    // Draw the image corresponding to this frame
    imageMode(CENTER);
    image(images.get(currentFrame), xpos, ypos);
  }
}