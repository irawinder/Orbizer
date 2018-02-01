

controlSlider w45min;
controlSlider weq;
controlSlider w45max;

controlSlider translateX;
controlSlider translateY;
controlSlider rotate;
controlSlider zoom;





void setupProjection() {
  
  int xOffset = 50;
  int vOffset = 300;
  
  w45min = new controlSlider();
  w45min.name = "Lower Hemisphere Control";
  //w45min.keyPlus = 'x';
  //w45min.keyMinus = 'z';
  w45min.xpos = xOffset;
  w45min.ypos = vOffset+140;
  w45min.len = int(0.15*width);
  w45min.valMin = -90;
  w45min.valMax = 90;
  w45min.value = -45;
  
  weq = new controlSlider();
  weq.name = "Equator Control";
  //weq.keyPlus = 's';
  //weq.keyMinus = 'a';
  weq.xpos = xOffset;
  weq.ypos = vOffset+70;
  weq.len = int(0.15*width);
  weq.valMin = -90;
  weq.valMax = 90;
  
  w45max = new controlSlider();
  w45max.name = "Upper Hemisphere Control";
  //w45max.keyPlus = 'w';
  //w45max.keyMinus = 'q';
  w45max.xpos = xOffset;
  w45max.ypos = vOffset;
  w45max.len = int(0.15*width);
  w45max.valMin = -90;
  w45max.valMax = 90;
  w45max.value = 45;
  
  translateX = new controlSlider();
  translateX.name = "Translate X";
  //translateX.keyPlus = 'w';
  //translateX.keyMinus = 'q';
  translateX.len = int(0.15*width);
  translateX.xpos = width-xOffset-translateX.len;
  translateX.ypos = vOffset;
  translateX.valMin = -100;
  translateX.valMax = 100;
  translateX.value = 0;
  
  translateY = new controlSlider();
  translateY.name = "Translate Y";
  //translateY.keyPlus = 'w';
  //translateY.keyMinus = 'q';
  translateY.len = int(0.15*width);
  translateY.xpos = width-xOffset-translateY.len;
  translateY.ypos = vOffset+70;
  translateY.valMin = -100;
  translateY.valMax = 100;
  translateY.value = 0;
  
  zoom = new controlSlider();
  zoom.name = "Scale %";
  //zoom.keyPlus = 'w';
  //zoom.keyMinus = 'q';
  zoom.len = int(0.15*width);
  zoom.xpos = width-xOffset-zoom.len;
  zoom.ypos = vOffset+140;
  zoom.valMin = 0;
  zoom.valMax = 150;
  zoom.value = 100;
  
  rotate = new controlSlider();
  rotate.name = "Rotate";
  //rotate.keyPlus = 'w';
  //rotate.keyMinus = 'q';
  rotate.len = int(0.15*width);
  rotate.xpos = width-xOffset-rotate.len;
  rotate.ypos = vOffset+210;
  rotate.valMin = 0;
  rotate.valMax = 360;
  rotate.value = 0;
  

}

void displayProjection(){
  
  fill(255,200);
  
  String frameRt = "";

  if (showFrameRate) {
    frameRt = "\n\nFramerate: " + frameRate;
  }
  text("Press ' m ' to toggle display Mode\n" +
       "Press ' f ' to show or hide framerate\n" + 
       "Press ' l ' to show or hide graphics vertices\n" +
       "Press ' s ' to reduce or increase resolution\n" +
       "Press ' o ' to enable AutoRotation\n" +
       "Press ' r ' to reset callibration\n" +
       "Press ' a ' to show or hide agents" +
       frameRt, 37, 110);


  
  w45min.listen();
  w45min.drawMe();
 
  weq.listen();
  weq.drawMe();
 
  w45max.listen();
  w45max.drawMe();
  
  translateX.listen();
  translateX.drawMe();
  
  translateY.listen();
  translateY.drawMe();
  
  zoom.listen();
  zoom.drawMe();  
  
  rotate.listen();
  rotate.drawMe();
  
  drawProjection(w45min.value,weq.value,w45max.value, 200);
}

void drawProjection(float botWarp, float equatorWarp, float topWarp, int seg) {
  //stroke(0);
  noStroke();
  
  
  //Fun bonus commands to visually explain whats going on
  if (showVertexEdges) {strokeWeight(1); stroke(0);}
  if (showReducedResolution) seg=15;
  
  if (showAutoRotate) {
    rotate.value += 0.1;
    if(rotate.value >= 360) rotate.value = 0;
  }
  
  pushMatrix();
  translate(width/2, height/2);
  translate(translateX.value,-translateY.value);
  rotate(PI*rotate.value/180);
  
  scale(zoom.value/100.0);
  
  
  drawCircle(0,                               height*(90-topWarp)/360,         0,                img.height/4,    seg); //center
  drawCircle(height*(90-topWarp)/360,         height*(90-equatorWarp)/360,     img.height/4,       img.height/2,    seg); // north of equator
  drawCircle(height*(90-equatorWarp)/360,     height*(90-botWarp)/360,         img.height/2,     img.height*3/4,     seg); //south of equator
  drawCircle(height*(90-botWarp)/360,         height/2,                        img.height*3/4,        img.height,    seg); //outside edge
  popMatrix();
}


void drawCircle(float innerR,float outerR,int texTop, int texBot, int segments) {
  
  //This maybe saves some cpu math
  float segmentAngle = 2*PI/segments;
  
  beginShape(TRIANGLE_STRIP);
  texture(canvas);
  for(int i=0; i<=segments;i++) {
    vertex(getX(outerR,  i*segmentAngle), getY(outerR,  i*segmentAngle), 0, i*img.width/segments, texBot);
    vertex(getX(innerR,  i*segmentAngle), getY(innerR,  i*segmentAngle), 0, i*img.width/segments, texTop);
  }
  endShape();
}

float getX(float radius, float theta) {
  float x = sin(theta)*radius;
  return x;
}

float getY(float radius, float theta) {
  float y = cos(theta)*radius;
  return y;
}

void defaultProjection() {
  w45min.value = -45;
  weq.value = 0;
  w45max.value = 45;
  
  translateX.value = 0;
  translateY.value = 0;
  zoom.value = 100;
  rotate.value = 0;
}