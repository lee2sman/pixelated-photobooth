import processing.video.*;
PImage thresholdImg;

int videoScale = 600;
// Number of columns and rows in our system
int cols, rows;
// Variable to hold onto Capture object
Capture video;

void setup(){
  
  //fullscreen
  size(800, 600);
  
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
      background(c);
    
    }
  }
}
  
void keyPressed(){
  if (key == ' ') {
      saveFrame("screenshot-###.png");
    }
}

