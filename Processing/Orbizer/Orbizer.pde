PImage img;  // Declare variable "a" of type PImage

controlSlider w45min;
controlSlider weq;
controlSlider w45max;


int counter;

void setup() {
  //size(1000, 600, P3D);
  fullScreen(P3D);
  //img = loadImage("Equirectangular_projection_SW.jpg");  // Load the image into the program  
  //img = loadImage("2000px-BlankMap-World6-Equirectangular.png");  // Load the image into the program  
  img = loadImage("2000px-BlankMap-World6-Equirectangular_night.png");  // Load the image into the program  
  
  
  background(0);
  
  w45min = new controlSlider();
  w45min.name = "Lower Hemisphere Control with Z-X";
  w45min.keyPlus = 'x';
  w45min.keyMinus = 'z';
  w45min.xpos = 50;
  w45min.ypos = 210;
  w45min.len = 300;
  w45min.valMin = -90;
  w45min.valMax = 90;
  w45min.value = -45;
  
  weq = new controlSlider();
  weq.name = "Equator Control with A-S";
  weq.keyPlus = 's';
  weq.keyMinus = 'a';
  weq.xpos = 50;
  weq.ypos = 140;
  weq.len = 300;
  weq.valMin = -90;
  weq.valMax = 90;
  
  w45max = new controlSlider();
  w45max.name = "Upper Hemisphere Control with Q-W";
  w45max.keyPlus = 'w';
  w45max.keyMinus = 'q';
  w45max.xpos = 50;
  w45max.ypos = 70;
  w45max.len = 300;
  w45max.valMin = -90;
  w45max.valMax = 90;
  w45max.value = 45;
  
}

void draw() {
  background(0);

  fill(255);
  text(frameRate,10,20);
  
 // controlSlider(10, 50, 200, 'q', 'w', w45min);
 w45min.listen();
 w45min.drawMe();
 
 weq.listen();
 weq.drawMe();
 
 w45max.listen();
 w45max.drawMe();
  
  drawProjection(w45min.value,weq.value,w45max.value, 200);
}


//
void drawProjection(float botWarp, float equatorWarp, float topWarp, int seg) {
  //stroke(0);
  noStroke();
  if ((keyPressed == true) && (key == 'l')) {stroke(0);}
  if ((keyPressed == true) && (key == 'p')) {seg=15;}
  
  
  translate(width/2, height/2);
  
  drawCircle(0,                               height*(90-topWarp)/360,         0,                img.height/4,    seg); //center
  drawCircle(height*(90-topWarp)/360,         height*(90-equatorWarp)/360,     img.height/4,       img.height/2,    seg); // north of equator
  drawCircle(height*(90-equatorWarp)/360,     height*(90-botWarp)/360,         img.height/2,     img.height*3/4,     seg); //south of equator
  drawCircle(height*(90-botWarp)/360,         height/2,                        img.height*3/4,        img.height,    seg); //outside edge
}


void drawCircle(float innerR,float outerR,int texTop, int texBot, int segments) {
  
  //This maybe saves some cpu math
  float segmentAngle = 2*PI/segments;
  
  beginShape(TRIANGLE_STRIP);
  texture(img);
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