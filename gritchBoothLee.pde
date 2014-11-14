//gritchbooth by Geraldine Juárez.
// originally captures frame from video and print to polaroid images on Your Images folder
// see shell script for communicating with the printer.
// NOTE: I have this above part commented out
// 
// this version minimally modified by Lee Tusman
// requires minim library (built-in to Processing)
// and the third party library glitchP5
// downloadable at http://dl.dropboxusercontent.com/u/1358257/glitchp5/web/index.html
// unzip, stick the glitchp5 in your Processing >> libraries folder

import processing.video.*;
import ddf.minim.*;
import glitchP5.*; 
import processing.opengl.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.serial.*;

Minim minim;
AudioInput lineIn;
int level;

Capture video;
GlitchP5 glitchP5; 
FFT fft;
//Serial myPort; 



void setup() {
size(400,500, OPENGL);
// instatiate a Minim object
minim = new Minim(this);
lineIn = minim.getLineIn(Minim.STEREO, 512);
glitchP5 = new GlitchP5(this); // initiate the glitchP5 instance;

// video 
video = new Capture(this,400,500,0);
video.updatePixels();

//serial (button) remove if not using button to print image.
//println(Serial.list());
//myPort = new Serial(this, Serial.list()[0], 9600);

}

void draw() {

// Check to see if a new frame is available
if (video.available()) {
  // Read the image from the camera.
  video.read();
  // Expand array size to the number of bytes you expect (button)
  byte[] inBuffer = new byte[7];
 // while (myPort.available() > 0) {
 //   inBuffer = myPort.readBytes();
 //   myPort.readBytes(inBuffer);
 //   if (inBuffer != null) {
//      String myString = new String(inBuffer);
//save("your_path"+(frameCount+".jpg"));
   //}
     //}
}

// Read audio
float numbers;     
numbers =  abs(lineIn.mix.get(1)) * 100;
int numbersInt = int(numbers);
println(numbersInt);

// Display the video image. (flip)
image(video,0,0);
// flip
pushMatrix();
      scale(-1,1);
      translate(-video.width, 0);
      image(video, 0, 0); 
popMatrix();
video.start();
//filter stuff
  int halfVideo = width/70*height/50;
  loadPixels();
for (int i = 0; i < (numbersInt*numbersInt*20)-numbersInt*2; i++) {
  pixels[i+halfVideo] = pixels[i];
}
updatePixels();
//run glitch library
glitchP5.run(); 

// trigger a glitch: glitchP5.glitch(  
//          posX,      
//          posY,       // position on screen(int)
//          posJitterX,    ' // 
//          posJitterY,     // max. position offset(int)
//          sizeX,       // 
//          sizeY,       // size (int)
//          numberOfGlitches,   // number of individual glitches (int)
//          randomness,     // this is a jitter for size (float)
//          attack,     // max time (in frames) until indiv. glitch appears (int)
//          sustain      // max time until it dies off after appearing (int)
//              );

glitchP5.glitch(0, 0, 800, 1000, 120-numbersInt*5+10, 2-numbersInt*5+10, 50-numbersInt*+5, numbersInt*5, numbersInt-1000, numbersInt*5);

}

//capture image
void keyPressed(){
  //save(frameCount+".png");
save("screenshot-"+(frameCount+".png"));
  } 
