import processing.video.*;
PImage thresholdImg;

/**
This is a very simple program that starts what is called
a video mirror aka a photobooth app style. It then pixelates
the live video image. The size of each pixel is determined by 
the number stored in videoScale. It starts to become extremely
abstract when videoScale is above 30. 
*/

// Size of each cell in the grid, ratio of window size to video size
int videoScale = 25;
// Number of columns and rows in our system
int cols, rows;
// Variable to hold onto Capture object
Capture video;

void setup(){
  
  //fullscreen
  size(800, 600);
  background(255);
  
  // Set up columns and rows
  cols = width/videoScale;
  rows = height/videoScale;
  video = new Capture(this, width, height);
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void draw(){
  if (video.available()) {
    video.read();
  }
  
  video.loadPixels();
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i*videoScale;
      int y = j*videoScale;
      // Looking up the appropriate color in the pixel array
      color c = video.pixels[x + y*video.width];
      fill(c);
      stroke(0);
      rect(x,y,videoScale,videoScale);
    }
  }
}
  
void keyPressed(){
  if (key == ' ') {
      saveFrame("screenshot-###.png");
    }
}

