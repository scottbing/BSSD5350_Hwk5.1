// Flocking
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/124-flocking-boids.html
// https://youtu.be/mhjuuHl6qHM
// https://editor.p5js.org/codingtrain/sketches/ry4XZ8OkN
import java.util.Arrays;

HelperFunctions hf = new HelperFunctions();

Boid[] flock;
color _strokeCol;
int seedVal;

float alignValue = .5;
float cohesionValue = 1;
float seperationValue = 1;

void setup() {
  size(840, 560);
  addFlock();
}

public void addFlock() {
  ColorPalette randomC = new ColorPalette();
  _strokeCol = randomC.getBaseColor();
  seedVal = int(random(0,200));
  print(_strokeCol);
  //size(1500, 1300);
  background(0);
  int n = 7;
  flock = new Boid[n];
  for (int i = 0; i < n; i++) {
    flock[i] = new Boid();
  }
  
}

void mousePressed() {
  // add a single Boid
  flock = Arrays.copyOf(flock, flock.length + 1);
  flock[flock.length-1] = new Boid();
  flock[flock.length-1].setPosition(new PVector(mouseX, mouseY));
  }
 
boolean looping = true;
void keyPressed() {
  if (key==' ') {
    if (looping) {
      //hf.save("img", "["+String.valueOf(seedVal)+"]");
      saveImage();
      noLoop();
    } else {
      loop();
    }
    looping = !looping;
  }
}

void saveImage() {

  save("name"+"-"+ seedVal +"-.png");
  hf.save("img", "["+String.valueOf(seedVal)+"]");
  println("Saved");
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
  stroke(_strokeCol);
  noFill();
  endShape(CLOSE);
}
