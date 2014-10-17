import processing.video.*;

int videoScale = 10; // Size of each cell in the grid, ratio of window size to video size
int cols = width/videoScale; // Number of columns and rows in our system
int rows = height/videoScale;
Capture video; // Variable to hold onto Capture object
PFont f;
int threshNumber = 80;

void setup(){
  size(800, 600);
  frameRate(10);
  
  cols = width/videoScale;
  rows = height/videoScale;
  video = new Capture(this, width, height);
  video.start();
  f = createFont("Menlo", 12);
  textFont(f);
}

void captureEvent(Capture video) {
  video.read();
}

void draw(){
  background(0);
  if (video.available()) {
    video.read();
  }
  
  video.loadPixels();
  
  int charcount = 0;
   for (int j = 0; j < rows; j++) { 
    for (int i = 0; i < cols; i++) {   
      // Where are we within the pixels?
      int x = i*videoScale;
      int y = j*videoScale;
     
      // Looking up the appropriate color in the pixel array
      color c =  video.pixels[x + y*video.width];
      
      float threshholdImage = brightness(video.pixels[x + y*video.width]);
      if (threshholdImage > threshNumber) {
        c = color(255);
        fill(c);
        

   
      } 
      else {
        c = color(0,230,0); 
        fill(c);
        
        byte temp_n = byte(random(2000));
      char temp_c = char(temp_n);
      
       text(temp_c,x,y);
  
      }
  
    }
  }
}
  

void keyPressed(){
  if (key == ' ') {
      saveFrame("screenshot-###.jpg");}
  if (key == CODED) {
    if (keyCode == UP) {
      threshNumber = threshNumber + 15;
    } else if (keyCode == DOWN) {
      threshNumber = threshNumber - 15;}
}
}
