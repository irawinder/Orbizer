class controlSlider {
  String name;
  int xpos;
  int ypos;
  int len;
  int diameter;
  
  char keyMinus;
  char keyPlus;
  
  int valMin;
  int valMax;
  
  float value;
  
  controlSlider() {
    xpos = 0;
    ypos = 0;
    len = 200;
    diameter = 25;
    keyMinus = '-';
    keyPlus = '+';
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
    //if(Math.pow((mouseX-(xpos+len*(value-valMin)/(valMax-valMin))),2.0)+Math.pow((mouseY-ypos),2) < 255) {
    if((mouseY > (ypos-diameter/2)) && (mouseY < (ypos+diameter/2)) && (mouseX > (xpos-diameter/2)) && (mouseX < (xpos+len+diameter/2))) {
      value = (mouseX-xpos)*(valMax-valMin)/len+valMin;
    }
  }
  
  if(value < valMin) value = valMin;
  if(value > valMax) value = valMax;
  }
  
  void drawMe() {
    strokeWeight(1);
    fill(255);
    text(int(value),xpos+diameter+len,ypos+5);
    text(name,xpos-0.5*diameter,ypos-diameter);
    
    stroke(100);
    fill(255,100);
    rect(xpos-0.5*diameter,ypos-0.5*diameter,len+diameter,diameter,diameter);
    
    stroke(150);
    fill(150);
    ellipse(xpos+len*(value-valMin)/(valMax-valMin),ypos,diameter,diameter);
  }
}