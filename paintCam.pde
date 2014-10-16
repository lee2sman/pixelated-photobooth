import processing.video.*;
PImage thresholdImg;

// Size of each cell in the grid, ratio of window size to video size

// good abstraction size for videoScale is 40
// RetroBoy videoScale size is 2
// 8bit cam videoscale size is 5


int videoScale = 12;
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
      //background(c);
      fill(c);
      stroke(10,0);
      ellipse(x+random(-5,5),y+random(-5,5),videoScale+random(1,25),videoScale+random(1,25));
    }
  }
}
  
void keyPressed(){
  if (key == ' ') {
      saveFrame("screenshot-###.png");
    }
}

