PImage img;  // Declare variable "a" of type PImage
PGraphics canvas;

String displayMode;

boolean showVertexEdges;
boolean showReducedResolution;
boolean showFrameRate;
boolean showAutoRotate;
boolean showAgents;

float rotationFloat;

ArrayList<Agent> particles;

int counter;

void setup() {
  size(1280, 800, P3D);
  //fullScreen(P3D);
  //img = loadImage("Equirectangular_projection_crop.png");  // Load the image into the program  
  //img = loadImage("2000px-BlankMap-World6-Equirectangular.png");  // Load the image into the program  
  //img = loadImage("2000px-BlankMap-World6-Equirectangular_night.png");  // Load the image into the program  
  //img = loadImage("Earth_night_homemade.jpg");  // Load the image into the program  
  img = loadImage("world.topo.bathy.200407.3x5400x2700.jpg");  // Load the image into the program   
  
  canvas = createGraphics(img.width, img.height, P3D);
  
  showAutoRotate = true;
  displayMode = "sphere";
  showAgents = true;
  
  particles = new ArrayList<Agent>();
  for (int i=0; i<200; i++) {
    Agent a = new Agent(img.width, img.height);
    a.randomInit();
    particles.add(a);
  }
  
  setupProjection();
  setupSphere();
}

void draw() {
  background(0);

  fill(255);
  
  canvas.beginDraw();
  canvas.background(0);
  canvas.colorMode(HSB);
  canvas.image(img, 0, 0);
  
  if(showAgents){
    for (Agent a: particles) {
      a.update3d();
      a.drawMode();
    }
  }
  //Draw on canvas here
  canvas.stroke(0,0,0,255);
  canvas.strokeWeight(2);

  drawLine(42.3, -71, 43.6, 1.4, 10); //Boston to Toulouse
  /*
  drawLine(35.7,139.7, 34.1, -118.0, 10); //Tokyo to LA
  drawLine(47.6, -122.3, 55.8, 37.1, 30); //Seattle to Moscow
  drawLine(28.7, 77.1, -33.9, 18.4, 20); //Dehli to Cape Town
  //drawLine(-51.8, -59.5,-33.9, 151.2,  20); //Falkland Islands to Sydney
  drawLine(-33.9, 151.2,-51.8, -59.5,  20); //Sydney to Falkland Islands
  */
  if(displayMode == "flat") {
    drawLine(42.3, -71,(float(height-mouseY)/height*180-90), (float(mouseX)/width*360-180),  40); //Boston to Mouse Position
  }
  
  canvas.text("Can you read this?",canvas.width/2,canvas.height/2);
  

  
  stroke(0,0,0,255);
  canvas.endDraw();
  
  switch(displayMode) {
      case "projection":
        displayProjection();
        break;
      case "sphere":
        displaySphere();
        break;
      case "flat":
        displayFlat();
        break;
  }
  
  text("Orbizer | Spherical Projection Mapping\n" +
       "Mike and Ira Winder\noncue.design",37,50);
       
  //displayProjection();
  counter++;
  if (counter > 3600) counter = 0;
  
  // Commands to help you draw 2D UI graphics over 3D objects
  // These are computationally intense so use sparingly!
  //hint(ENABLE_DEPTH_TEST);
  //hint(DISABLE_DEPTH_TEST);
}

void keyPressed() {
    switch(key) {
    case 'l':
      showVertexEdges = !showVertexEdges;
      break;
    case 's':
      showReducedResolution = !showReducedResolution;
      break;
    case 'a':
      showAgents = !showAgents;
      break;
    case 'r':
      restoreDefaults();
      break;
    case 't':
      saveConfig();
      break;
    case 'y':
      loadConfig();
      break;
    case 'f':
      showFrameRate = !showFrameRate;
      break;
    case 'o':
      showAutoRotate = !showAutoRotate;
      break;
    case 'm':  //display mode toggles Projection -> Sphere -> Flat
      if(displayMode == "projection") {displayMode = "sphere"; break;}
      if(displayMode == "sphere") {displayMode = "flat"; break;}
      if(displayMode == "flat") {displayMode = "projection"; break;}
  }
}

void restoreDefaults(){
  defaultProjection();
  defaultSphere();
  rotationFloat = 0;
  showVertexEdges = false;
  showReducedResolution = false;
}