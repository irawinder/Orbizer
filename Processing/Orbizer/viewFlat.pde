void displayFlat() {
  
  image(canvas, 0, 0, width, height);
  
  if (!hide) {
  
    String frameRt = "";
    if (showFrameRate) frameRt = "\n\nFramerate: " + frameRate;
  
    fill(255); textAlign(LEFT, TOP);
    
    text("Press ' m ' to toggle display Mode\n" +
         "Press ' f ' to show or hide framerate\n" +
         "Press ' a ' to show or hide agents\n" +
         "Press ' t ' to save configuration\n" +
         "Press ' y ' to load last saved configuration\n" +
         "Press ' h ' to hide controls" +
         "\nFlightTime " + ftime +
         frameRt, 37, 110);
  }
}