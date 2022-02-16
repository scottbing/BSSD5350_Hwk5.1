// Flocking
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/124-flocking-boids.html
// https://youtu.be/mhjuuHl6qHM
// https://editor.p5js.org/codingtrain/sketches/ry4XZ8OkN

Boid[] flock;
color _strokeCol;

float alignValue = .5;
float cohesionValue = 1;
float seperationValue = 1;

void setup() {
  ColorPalette randomC = new ColorPalette();
  _strokeCol = randomC.getBaseColor();
  int seedVal = int(random(0,200));
  //size(640, 360);
  size(1500, 1300);
  background(0);
  int n = 7;
  flock = new Boid[n];
  flock[n].setColor(_strokeCol);
  for (int i = 0; i < n; i++) {
    flock[i] = new Boid();
    flock[i].setColor(_strokeCol);
  }
}

boolean looping = true;
void mousePressed() {
  if (looping) {
    noLoop();
  } else {
    loop();
  }
  looping = !looping;
}

void draw() {
  //background(51);
  //noStroke();
  beginShape();
  for (Boid boid: flock) {
    boid.edges();
    boid.flock(flock);
    boid.update();
    vertex(boid.position.x, boid.position.y);
    //boid.show();
  }
  stroke(155,20,155);
  noFill();
  endShape(CLOSE);
}
