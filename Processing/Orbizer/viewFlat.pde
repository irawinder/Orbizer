
void displayFlat() {
  
  image(canvas, 0, 0, width, height);
  
  fill(255,200);
  
  String frameRt = "";

  if (showFrameRate) {
    frameRt = "\n\nFramerate: " + frameRate;
  }
  text("Press ' m ' to toggle display Mode\n" +
       "Press ' f ' to show or hide framerate\n" +
       "Press ' a ' to show or hide agents" +
       frameRt, 37, 110);
  
}