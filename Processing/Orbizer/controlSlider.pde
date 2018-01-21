class controlSlider {
  String name;
  int xpos;
  int ypos;
  int len;
  
  int valMin;
  int valMax;
  
  int value;
  int diameter;
  
  boolean listening = false;
  
  controlSlider() {
    xpos = 0;
    ypos = 0;
    len = 200;
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
    fill(150);
    text(value,xpos+diameter+len,ypos+5);
    text(name,xpos-0.5*diameter,ypos-diameter);
    
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
  if (enableProjection) {
    w45min.listenCheck();
    weq.listenCheck();
    w45max.listenCheck();
  }
}

// Activates continuously while mouse is dragging
void mouseDragged() {
  if (enableProjection) {
    w45min.listenMouse();
    weq.listenMouse();
    w45max.listenMouse();
  }
}

// Activates once when mouse is released
void mouseReleased() {
  if (enableProjection) {
    w45min.listening = false;
    weq.listening = false;
    w45max.listening = false;
  }
}

void keyPressed() {
  if (enableProjection) {
    switch(key) {
      case 'q':
        w45max.listenKey(-1);
        break;
      case 'w':
        w45max.listenKey(+1);
        break;
      case 'a':
        weq.listenKey(-1);
        break;
      case 's':
        weq.listenKey(+1);
        break;
      case 'z':
        w45min.listenKey(-1);
        break;
      case 'x':
        w45min.listenKey(+1);
        break;
    }
  }
  
  switch(key) {
    case 'p':
      enableProjection = !enableProjection;
      break;
    case 'l':
      showVertexEdges = !showVertexEdges;
      break;
    case 's':
      reducedResolution = !reducedResolution;
      break;
    case 'r':
      resetMapping();
      break;
  }
}

void resetMapping() {
  w45min.value = -45;
  weq.value    = 0;
  w45max.value = 45;
}