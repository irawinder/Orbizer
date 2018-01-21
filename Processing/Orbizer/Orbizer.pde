PImage img;  // Declare variable "img" of type PImage
PGraphics canvas;

boolean enableProjection;
boolean showVertexEdges;
boolean reducedResolution;

controlSlider w45min;
controlSlider weq;
controlSlider w45max;

ArrayList<Agent> particles;

int counter;

void setup() {
  size(1280, 700, P3D);
  background(0);
  //fullScreen(P3D);
  
  img = loadImage("Equirectangular_projection_SW.jpg");  // Load the image into the program  
  //img = loadImage("2000px-BlankMap-World6-Equirectangular.png");  // Load the image into the program  
  //img = loadImage("2000px-BlankMap-World6-Equirectangular_night.png");  // Load the image into the program  
  
  canvas = createGraphics(img.width, img.height, P3D);
  
  w45min = new controlSlider();
  w45min.name = "Lower Hemisphere Control with Z-X";
  w45min.xpos = 50;
  w45min.ypos = 300;
  w45min.len = int(0.15*width);
  w45min.valMin = -90;
  w45min.valMax = 90;
  w45min.value = -45;
  
  weq = new controlSlider();
  weq.name = "Equator Control with A-S";
  weq.xpos = 50;
  weq.ypos = 230;
  weq.len = int(0.15*width);
  weq.valMin = -90;
  weq.valMax = 90;
  
  w45max = new controlSlider();
  w45max.name = "Upper Hemisphere Control with Q-W";
  w45max.xpos = 50;
  w45max.ypos = 160;
  w45max.len = int(0.15*width);
  w45max.valMin = -90;
  w45max.valMax = 90;
  w45max.value = 45;
  
  particles = new ArrayList<Agent>();
  for (int i=0; i<100; i++) {
    Agent a = new Agent(img.width, img.height);
    a.randomInit();
    particles.add(a);
  }
  
  enableProjection = true;;
  showVertexEdges = false;
  reducedResolution = false;
}

void draw() {
  background(0);
  
  canvas.beginDraw();
  canvas.background(0);
  canvas.colorMode(HSB);
  canvas.image(img, 0, 0);
  for (Agent a: particles) {
    a.update();
    a.draw();
  }
  canvas.endDraw();
  
  if (enableProjection) {
    drawProjection(w45min.value,weq.value,w45max.value, 200);
    w45min.drawMe();
    weq.drawMe();
    w45max.drawMe();
  } else {
    image(canvas, 0, 0, width, height);
  }
  
  fill(255,200);
  String projectionHelp = "";
  if (enableProjection) {
    projectionHelp = "Press 'l' to show or hide graphics vertices\nPress 's' to reduce or increase resolution\nPress 'r' to reset callibration\n";
  }
  text("Press 'p' to toggle spherical projection map\n" + projectionHelp +
       "Framerate: " + frameRate, 10, 20);
}


//
void drawProjection(float botWarp, float equatorWarp, float topWarp, int seg) {
  //stroke(0);
  noStroke();
  if (showVertexEdges) {stroke(0);}
  if (reducedResolution) {seg=15;}
  
  pushMatrix();
  translate(width/2, height/2);
  
  drawCircle(0,                               height*(90-topWarp)/360,         0,                  img.height/4,    seg); //center
  drawCircle(height*(90-topWarp)/360,         height*(90-equatorWarp)/360,     img.height/4,       img.height/2,    seg); // north of equator
  drawCircle(height*(90-equatorWarp)/360,     height*(90-botWarp)/360,         img.height/2,       img.height*3/4,  seg); //south of equator
  drawCircle(height*(90-botWarp)/360,         height/2,                        img.height*3/4,     img.height,      seg); //outside edge
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