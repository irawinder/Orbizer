class controlSlider {
  String name;
  int xpos;
  int ypos;
  int len;
  
  char keyMinus;
  char keyPlus;
  
  int valMin;
  int valMax;
  
  int value;
  
  controlSlider() {
    xpos = 0;
    ypos = 0;
    len = 200;
    keyMinus = 'q';
    keyPlus = 'w';
    valMin = 0;
    valMax = 0;
    value = 0;
  }
  
  void listen() {
      //Keyboard Controls
  if ((keyPressed == true) && (key == keyMinus)) {value--;}
  if ((keyPressed == true) && (key == keyPlus)) {value++;}
  
  //Math sucks to keep the range and scale of the slider arbitrary
  if (mousePressed) {
    if(Math.pow((mouseX-(xpos+len*(value-valMin)/(valMax-valMin))),2.0)+Math.pow((mouseY-ypos),2) < 255) {
      value = (mouseX-xpos)*(valMax-valMin)/len+valMin;
    }
  }
  
  if(value < valMin) value = valMin;
  if(value > valMax) value = valMax;
  }
  
  void drawMe() {
    fill(255);
    text(value,xpos+15+len,ypos+5);
    text(name,xpos,ypos-25);
    
    stroke(100);
    line(xpos,ypos,xpos+len,ypos);
    
    stroke(150);
    fill(150);
    ellipse(xpos+len*(value-valMin)/(valMax-valMin),ypos,25,25);
  }
}