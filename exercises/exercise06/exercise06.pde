// Exercise 06
//
// Using the webcam as input to play with Bouncers.

// Import the video library
import processing.video.*;

// The capture object for reading from the webcam
Capture video;

// An array of bouncers to play with
Bouncer[] bouncers = new Bouncer[10];
//CHANGED: The brightestPixel is now its own class so
//we can easily make manipulations to it such as colision
//detection and gradual color change.
Point Bright = new Point(20);

// setup()
//
// Creates the bouncers and starts the webcam

void setup() {
  size(640, 480);

  // Our old friend the for-loop used to go through the length of an
  // array adding new objects to it (Bouncers in this case)
  for (int i = 0; i < bouncers.length; i++) {
    // Each Bouncer just starts with random values 
    //CHANGED: Now the color is also randomized to be somewhat colorful.
    bouncers[i] = new Bouncer(random(0,width),random(0,height),random(-10,10),random(-10,10),random(20,50), color(random(20, 240), random(20, 420), random(20, 420)));
  }
  
  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();
}

// draw()
//
// Processes the frame of video, draws the video to the screen, updates the Bouncers
// and then just draws an ellipse at the brightest pixel location. You code should
// do something much more interesting in order to actually interact with the Bouncers.

void draw() {
  // A function that processes the current frame of video
  handleVideoInput();

  // Draw the video frame to the screen
  image(video, 0, 0);
  
  // Our old friend the for-loop running through the length of an array to
  // update and display objects, in this case Bouncers.
  // If the brightness (or other video property) is going to interact with all the
  // Bouncers, it will need to happen in here.
  for (int i = 0; i < bouncers.length; i++) {
   bouncers[i].update();
   bouncers[i].display();
   
   //Check if the Point is colliding with one of the bouncers.
   Bright.handleCollision(bouncers[i]);
  }
  
  // CHANGED: We call the Point update to draw it on the screen.
  Bright.display();
}

// handleVideoInput
//
// Checks for available video, reads the frame, and then finds the brightest pixel
// in that frame and stores its location in brightestPixel.

void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }
  
  // If we're here, there IS a frame to look at so read it in
  video.read();

  // Start with a very low "record" for the brightest pixel
  // so that we'll definitely find something better
  float brightnessRecord = 0;

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // Get the brightness of the pixel we're looking at
      float pixelPointness = brightness(pixelColor);
      // Check if this pixel is the brighest we've seen so far
      if (pixelPointness > brightnessRecord) {
        // If it is, change the record value
        brightnessRecord = pixelPointness;
        // Remember where this pixel is in the the grid of pixels
        // (and therefore on the screen) by setting the PVector
        // brightestPixel's x and y properties.
        Bright.position.x = x;
        Bright.position.y = y;
      }
    }
  }
}