/*  ORBIZER
 *  Ira Winder, ira@mit.edu, 2018
 *
 *  Init Functions
 *
 *  MIT LICENSE:  Copyright 2018 Ira Winder
 *
 *               Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 *               and associated documentation files (the "Software"), to deal in the Software without restriction, 
 *               including without limitation the rights to use, copy, modify, merge, publish, distribute, 
 *               sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
 *               furnished to do so, subject to the following conditions:
 *
 *               The above copyright notice and this permission notice shall be included in all copies or 
 *               substantial portions of the Software.
 *
 *               THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 *               NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 *               NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
 *               DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 *               OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
 
String version = "v0.9.2";

String label = "Orbizer | Spherical Projection Mapping, " + version + "\n" +
               "Mike and Ira Winder\noncue.design"; 

PImage img;
PGraphics canvas;
PGraphics staticLayer;

String displayMode;

boolean showVertexEdges;
boolean showReducedResolution;
boolean showFrameRate;
boolean showAutoRotate;
boolean showAgents;
boolean showFlightTable2016;
boolean flip;

float rotationFloat;

int counter;
boolean hide = false;
 
int phaseCounter = 0;
String[] phase = {
  "Initializing Canvas",
  "Loading Flight Data",
  "Setting up map projections"
};
int numPhases = phase.length;
int DELAY = 500; 

void initialize() {
  
  if (phaseCounter == 0) {
    
    // Load the image into the program 
    //
    //img = loadImage("Equirectangular_projection_crop.png");
    //img = loadImage("2000px-BlankMap-World6-Equirectangular.png"); //Not accurate!
    //img = loadImage("2000px-BlankMap-World6-Equirectangular_night.png"); //Not accurate!
    //img = loadImage("Earth_night_homemade.jpg");
    img = loadImage("world.topo.bathy.200407.3x5400x2700.jpg");
    //img.filter(GRAY);
    
    canvas = createGraphics(img.width, img.height, P3D);
  
  } else if (phaseCounter == 1) {
  
    showAutoRotate = true;
    displayMode    = "flat";
    showAgents     = true;
    
    processAirportData();
    // processRouteData();
    // createStaticLayer(); //must be called AFTER data is processed
    
    //setupParticles();
    setupFlights();
    openFlightTable();
    
  } else if (phaseCounter == 2) {
  
    setupProjection();
    setupSphere();
    
    initialized = true;
  
  }
  
  loadScreen(loadingBG, phaseCounter+1, numPhases, phase[phaseCounter]);
  phaseCounter++;
  delay(DELAY);
}
 
void restoreDefaults(){
  defaultProjection();
  defaultSphere();
  rotationFloat = 0;
  showVertexEdges = false;
  showReducedResolution = false;
  flip = false;
}