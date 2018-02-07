ArrayList<Agent> particles;
ArrayList<Agent> flights;



void setupFlights() {
  flights = new ArrayList<Agent>();
}

void spawnFlight(float lat1, float lon1, float lat2, float lon2, float flightTime) {
  Agent f = new Agent(0,0);
  f.flightInit(lat1, lon1, lat2, lon2, flightTime);
  flights.add(f);
  print("Flight Spawned!\n");
}

void updateFlights() {
  if(showAgents){
    for (int i = flights.size() - 1; i >= 0; i--) {
      Agent f = flights.get(i);
      f.update3d();
      f.drawMode();
      if(f.duration <= 0.0) flights.remove(i);
    }
  }
}

void setupParticles() {
  particles = new ArrayList<Agent>();
  for (int i=0; i<200; i++) {
    Agent a = new Agent(img.width, img.height);
    a.randomInit();
    particles.add(a);
  }
}

void updateParticles() {
  if(showAgents){
    for (Agent a: particles) {
      a.update3d();
      a.drawMode();
    }
  }
}