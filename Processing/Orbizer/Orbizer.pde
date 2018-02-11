String version = "v0.9";

String label = "Orbizer | Spherical Projection Mapping, " + version + "\n" +
               "Mike and Ira Winder\noncue.design"; 

PImage img;
PGraphics canvas;

String displayMode;

boolean showVertexEdges;
boolean showReducedResolution;
boolean showFrameRate;
boolean showAutoRotate;
boolean showAgents;

boolean showFlightTable2016;

float rotationFloat;

int counter;

void setup() {
  size(1280, 800, P3D);
  //fullScreen(P3D);
  
  // Load the image into the program 
  //
  //img = loadImage("Equirectangular_projection_crop.png");  
  //img = loadImage("2000px-BlankMap-World6-Equirectangular.png");
  //img = loadImage("2000px-BlankMap-World6-Equirectangular_night.png"); 
  //img = loadImage("Earth_night_homemade.jpg");   
  img = loadImage("world.topo.bathy.200407.3x5400x2700.jpg");  
  
  canvas = createGraphics(img.width, img.height, P3D);
  
  showAutoRotate = true;
  displayMode = "flat";
  showAgents = true;
  
  //setupParticles();
  setupFlights();
  openFlightTable();
  
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
  
  //updateParticles();
  updateFlights();
  
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
  
  canvas.stroke(255,255,255);
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
  
  hint(DISABLE_DEPTH_TEST);
  text(label,37,50);
  hint(ENABLE_DEPTH_TEST);
       
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

void mousePressed() {
  if(displayMode == "projection") {
    w45min.listenClick();
    weq.listenClick();
    w45max.listenClick();

    translateX.listenClick();
    translateY.listenClick();
    rotate.listenClick();
    zoom.listenClick();
  }
  else if(displayMode == "sphere") {
    pitch3d.listenClick();
    rotate3d.listenClick();
    zoom3d.listenClick();
  }
  else if(displayMode == "flat") {
    PVector latlon = new PVector();
    latlon = windowXYtolatlon(mouseX, mouseY);
    spawnFlight(42.3, -71, latlon.x, latlon.y, 180, 255);
  }
}

void mouseReleased() {
  w45min.isDragged = false;
  weq.isDragged = false;
  w45max.isDragged = false;

  translateX.isDragged = false;
  translateY.isDragged = false;
  rotate.isDragged = false;
  zoom.isDragged = false;
  
  pitch3d.isDragged = false;
  rotate3d.isDragged = false;
  zoom3d.isDragged = false;
}

void restoreDefaults(){
  defaultProjection();
  defaultSphere();
  rotationFloat = 0;
  showVertexEdges = false;
  showReducedResolution = false;
}