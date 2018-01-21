class Agent {
  PVector location, velocity;
  int w, h;
  float hue;
  
  Agent(int w, int h) {
    this.w = w;
    this.h = h;
    location = new PVector(0,0);
    velocity = new PVector(0,0);
    hue = 0;
  }
  
  void randomInit() {
    float randomX = random(0, w);
    float randomY = random(0, h);
    location = new PVector(randomX, randomY);
    float randomSpeed = random(-0.5, 0.5);
    velocity = new PVector(randomSpeed, 0);
    hue = random(0, 255);
  }
  
  void update() {
    location.add(velocity);
    if (location.x > w) location.x = 0;
    if (location.x < 0) location.x = w;
    if (location.y > h) location.y = 0;
    if (location.y < 0) location.y = h;
  }
  
  void draw() {
    canvas.fill(hue, 255, 255);
    canvas.noStroke();
    for (int i=0; i<10; i++) {
      fill(hue, 255, 255, 255*(9-i)/100.0);
      canvas.ellipse(location.x - 4*i*velocity.x, location.y - i*velocity.y, 10-i, 10-i);
    }
  }
}