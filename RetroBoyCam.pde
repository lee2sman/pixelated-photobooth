import processing.video.*;
PImage thresholdImg;

// Size of each cell in the grid, ratio of window size to video size
int videoScale = 2;
// Number of columns and rows in our system
int cols, rows;
// Variable to hold onto Capture object
Capture video;

void setup(){
  
  size(800, 600);
  background(0);
  // Set up columns and rows
  cols = (width/2)/videoScale;
  rows = (height/2)/videoScale;
  video = new Capture(this, width/2, height/2);
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
     //grayscale 8bit
      color c =  int(brightness(video.pixels[x + y*video.width]));

      float threshholdImage = brightness(video.pixels[x + y*video.width]);
      if ((threshholdImage+random(15)) > 200) {
        c = color(240);
      } 
      else if ((threshholdImage+random(15)) > 130) {
        c = color(150); }
      else if ((threshholdImage+random(15)) > 80) {
        c = color(70);}
      else {
        c = color(15);}

      fill(c);
      stroke(0);
      // width/4 and height/4 is so i can center a smaller gameboy size camera image
      rect(width/4+x,height/4+y,videoScale,videoScale);

    }
  }
}
  
void keyPressed(){
  if (key == ' ') {
      saveFrame("screenshot-###.png");
    }
}

