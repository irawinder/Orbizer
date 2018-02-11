class Agent {
  PVector location, velocity, alatlon;
  int w, h;
  float hue;
  
  float bearing, speed, duration;
  boolean willEnd;
  
  Agent(int w, int h) {
    this.w = w;
    this.h = h;
    location = new PVector(0,0);
    velocity = new PVector(0,0);
    alatlon = new PVector(0,0);
    bearing = 90;
    speed = 0;
    hue = 0;
    duration = 0; //Duration will be measured in frames, with a possible timescale option later
    willEnd = false;
  }
  
  void randomInit() {
    //old agents
    float randomX = random(0, w);
    float randomY = random(0, h);
    location = new PVector(randomX, randomY);
    float randomSpeed = random(-2, 2);
    velocity = new PVector(randomSpeed, 0);
    
    //sphere agents
    float randomLat = random(-90, 90);
    float randomLon = random(-180, 180);
    alatlon = new PVector(randomLat, randomLon);
    bearing = random(0,360); //Azimuth in degrees as a compass
    speed = random(0.1,0.5); //speed in degrees per second

    willEnd = false;
    hue = random(0, 255);
    
    location = latlontoCanvasXY(alatlon);
  }
  
  void flightInit(float lat1, float lon1, float lat2, float lon2, float flightTime, int fhue) {
    alatlon = new PVector(lat1, lon1);
    bearing = calcBearing(lat1, lon1, lat2, lon2);
    speed = calcAngDist(lat1, lon1, lat2, lon2)/flightTime;
    duration = flightTime;

    willEnd = true;
    hue = fhue;
    
    location = latlontoCanvasXY(alatlon);
  }
  
  void update() {
    location.add(velocity);
    if (location.x > w) location.x = 0;
    if (location.x < 0) location.x = w;
    if (location.y > h) location.y = 0;
    if (location.y < 0) location.y = h;
  }
  
  void update3d() {
    PVector templatlon = new PVector(0,0);
    
    float c = PI/180;
    float newBearing = 0;
    
    float lat1, lon1, lat2, lon2;
    
    lat1 = alatlon.x*c;
    lon1 = alatlon.y*c;
    lat2 = asin( sin(lat1)*cos(speed*c) + cos(lat1)*sin(speed*c)*cos(bearing*c) );
    lon2 = lon1 + atan2( sin(bearing*c)*sin(speed*c)*cos(lat1), cos(speed*c)-sin(lat1)*sin(lat2) );
    
    newBearing = atan2( sin(lon1-lon2) * cos(lat1),  cos(lat2)*sin(lat1) - sin(lat2)*cos(lat1)*cos(lon1-lon2))/c;
    
    bearing = (newBearing + 180.0) % 360.0;
    
    alatlon.x = lat2/c;
    alatlon.y = lon2/c;
    
    if(alatlon.y > 180.0) alatlon.y -= 360;
    else if(alatlon.y < -180.0) alatlon.y += 360;
    
    if(willEnd) {
      duration--;
    }

    location = latlontoCanvasXY(alatlon);
  }
  
  void draw() {
    canvas.fill(hue, 255, 255);
    canvas.noStroke();
    for (int i=0; i<10; i++) {
      canvas.fill(hue, 255, 255, 255*(9-i)/9.0);
      canvas.stroke(hue, 255, 255, 255*(9-i)/9.0);
      canvas.ellipse(location.x - 1.5*i*velocity.x, location.y - i*velocity.y, 5, 5);
    }
  }
  
  void drawSimple() {
     canvas.fill(hue, 255, 255);
     canvas.noStroke();
     canvas.ellipse(location.x, location.y, 5, 5);
  }
  
  void drawMode() {
    canvas.fill(hue, 255, 255);
    canvas.noStroke();
    int diameter = 5;
    switch(displayMode) {
      case "projection":
        //canvas.ellipse(location.x, location.y, 25*(tan((1-location.y/canvas.height)*PI/2)+1), 25);
        canvas.ellipse(location.x, location.y, diameter, diameter);
        break;
      case "sphere":
        canvas.ellipse(location.x, location.y, diameter*sqrt(tan((location.y/canvas.height-0.5)*PI)*tan((location.y/canvas.height-0.5)*PI)+1), diameter);
        break;
      case "flat":
        canvas.ellipse(location.x, location.y, diameter, diameter);
        //canvas.ellipse(location.x, location.y, 10*sqrt(tan((location.y/canvas.height-0.5)*PI)*tan((location.y/canvas.height-0.5)*PI)+1), 10);
        break;
  }
  }
}