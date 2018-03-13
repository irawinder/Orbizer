boolean initialized;

// setup() executes once when application begins (this is a default Processing method)
// 
void setup() {
  //size(1280, 800, P3D);
  fullScreen(P3D);
  
  initialized = false;
  loadingBG = loadImage("loading.jpg");
  
  loadScreen(loadingBG, 0, 1, "Initializing");
}

// draw() repeats on infinite loop after setup (this is a default Processing method)
// 
void draw() {
  if (!initialized) {
    
    // A_Init.pde - runs until initialized = true
    // 
    initialize();
    
    
  } else {
    
    // Run reoccuring computation and draw functions
    // 
    run();
  }
}

void run() {
  background(0);

  fill(255);
  
  canvas.beginDraw();
  canvas.background(0);
  canvas.image(img, 0, 0);
  //canvas.image(staticLayer.get(),0,0);
  drawCitiesCanvas();
  //drawRoutesCanvas();
  
  //Draw on canvas here
  canvas.stroke(255);
  canvas.strokeWeight(1);
  canvas.fill(255);

  /*
  drawLine(42.3, -71, 43.6, 1.4, 10);           // Boston to Toulouse
  drawLine( 35.7,  139.7,  34.1, -118.0, 10);   // Tokyo to LA
  drawLine( 47.6, -122.3,  55.8,   37.1, 30);   // Seattle to Moscow
  drawLine( 28.7,   77.1, -33.9,   18.4, 20);   // Dehli to Cape Town
  drawLine(-51.8,  -59.5, -33.9,  151.2, 20);   // Falkland Islands to Sydney
  drawLine(-33.9,  151.2, -51.8,  -59.5, 20);   // Sydney to Falkland Islands
  */
  
  /*
  if(displayMode == "flat") {
    drawLine(42.3, -71,(float(height-mouseY)/height*180-90), (float(mouseX)/width*360-180),  40); //Boston to Mouse Position
  }
  */
  
  //updateParticles();
  updateFlights();
  
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
  fill(255); textAlign(LEFT, TOP);
  if (!hide) text(label,37,37);
  hint(ENABLE_DEPTH_TEST);
       
  //displayProjection();
  counter++;
  if (counter > 3600) counter = 0;
}