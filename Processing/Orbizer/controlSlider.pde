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
  int diameter;
  
  boolean listening = false;
  
  controlSlider() {
    xpos = 0;
    ypos = 0;
    len = 200;
    keyMinus = 'q';
    keyPlus = 'w';
    valMin = 0;
    valMax = 0;
    value = 0;
    diameter = 25;
  }
  
  boolean listenCheck() {
    if(Math.pow((mouseX-(xpos+len*(value-valMin)/(valMax-valMin))),2.0)+Math.pow((mouseY-ypos),2) < 255) {
      listening = true;
    }
    return listening;
  }
  
  void listenKey(int nudgeValue) {
    //Keyboard Controls
    value += nudgeValue;
    limitCheck();
  }
  
  void listenMouse() {
    //Math sucks to keep the range and scale of the slider arbitrary
    if (listening) value = (mouseX-xpos)*(valMax-valMin)/len+valMin;
    limitCheck();
  }
  
  void limitCheck() {
    if(value < valMin) value = valMin;
    if(value > valMax) value = valMax;
  }
  
  void drawMe() {
    fill(255);
    text(value,xpos+diameter+len,ypos+5);
    text(name,xpos,ypos-diameter);
    
    stroke(100);
    fill(255,100);
    rect(xpos-0.5*diameter,ypos-0.5*diameter,len+diameter,diameter,diameter);
    
    stroke(150);
    fill(150);
    ellipse(xpos+len*(value-valMin)/(valMax-valMin),ypos,diameter,diameter);
  }
}

// Activates once when mouse first clicks
void mousePressed() {
  if (w45min.listenCheck()) selectedSlider = "w45min";
  if (   weq.listenCheck()) selectedSlider = "weq";
  if (w45max.listenCheck()) selectedSlider = "w45max";
}

// Activates continuously while mouse is dragging
void mouseDragged() {
  w45min.listenMouse();
  weq.listenMouse();
  w45max.listenMouse();
}

// Activates once when mouse is released
void mouseReleased() {
  w45min.listening = false;
  weq.listening = false;
  w45max.listening = false;
}

void keyPressed() {
  switch(key) {
    case 'q':
      w45min.listenKey(-1);
      break;
    case 'w':
      w45min.listenKey(+1);
      break;
    case 'a':
      weq.listenKey(-1);
      break;
    case 's':
      weq.listenKey(+1);
      break;
    case 'z':
      w45max.listenKey(-1);
      break;
    case 'x':
      w45max.listenKey(+1);
      break;
  }
}