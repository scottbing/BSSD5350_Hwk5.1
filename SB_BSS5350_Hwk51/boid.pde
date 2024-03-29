// Flocking
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/124-flocking-boids.html
// https://youtu.be/mhjuuHl6qHM
// https://editor.p5js.org/codingtrain/sketches/ry4XZ8OkN

class Boid {
  PVector position;
  PVector velocity;
  PVector acceleration;
  int maxForce;
  int maxSpeed;
  color strokeCol;
  
  Boid() {
    this.position = new PVector(random(width), random(height));
    //this.position = new PVector(random(width/4), random(height*3/4, height));
    this.velocity = PVector.random2D();
    this.velocity.setMag(random(2, 4));
    this.acceleration = new PVector();
    this.maxForce = 1;
    this.maxSpeed = 40;
  }
  
  // Getter
  public color getColor() {
    return strokeCol;
  }
  
  // Setter
  public void setColor(color strokeCol) {
    this.strokeCol = strokeCol;
  }
  
  // Getter
  public PVector getPosition() {
    return position;
  }
  
  // Setter
  public void setPosition(PVector pos) {
    this.position = position;
  }


  void edges() {
    if (this.position.x > width) {
      this.position.x = 0;
    } else if (this.position.x < 0) {
      this.position.x = width;
    }
    if (this.position.y > height) {
      this.position.y = 0;
    } else if (this.position.y < 0) {
      this.position.y = height;
    }
  }

  PVector align(Boid[] boids) {
    int perceptionRadius = 50;
    PVector steering = new PVector();
    int total = 0;
    for (Boid other: boids) {
      float d = dist(this.position.x, this.position.y, other.position.x, other.position.y);
      if (other != this && d < perceptionRadius) {
        steering.add(other.velocity);
        total++;
      }
    }
    if (total > 0) {
      steering.div(total);
      steering.setMag(this.maxSpeed);
      steering.sub(this.velocity);
      steering.limit(this.maxForce);
    }
    return steering;
  }

  PVector separation(Boid[] boids) {
    int perceptionRadius = 50;
    PVector steering = new PVector();
    int total = 0;
    for (Boid other: boids) {
      float d = dist(this.position.x, this.position.y, other.position.x, other.position.y);
      if (other != this && d < perceptionRadius) {
        PVector diff = PVector.sub(this.position, other.position);
        diff.div(d * d);
        steering.add(diff);
        total++;
      }
    }
    if (total > 0) {
      steering.div(total);
      steering.setMag(this.maxSpeed);
      steering.sub(this.velocity);
      steering.limit(this.maxForce);
    }
    return steering;
  }

  PVector cohesion(Boid[] boids) {
    int perceptionRadius = 100;
    PVector steering = new PVector();
    int total = 0;
    for (Boid other: boids) {
      float d = dist(this.position.x, this.position.y, other.position.x, other.position.y);
      if (other != this && d < perceptionRadius) {
        steering.add(other.position);
        total++;
      }
    }
    if (total > 0) {
      steering.div(total);
      steering.sub(this.position);
      steering.setMag(this.maxSpeed);
      steering.sub(this.velocity);
      steering.limit(this.maxForce);
    }
    return steering;
  }

  void flock(Boid[] boids) {
    PVector alignment = this.align(boids);
    //PVector alignment = new PVector();;
    PVector cohesion = this.cohesion(boids);
    //PVector cohesion = new PVector();
    PVector separation = this.separation(boids);
    //PVector separation = new PVector();

    alignment.mult(alignValue);
    cohesion.mult(cohesionValue);
    separation.mult(seperationValue);

    this.acceleration.add(alignment);
    this.acceleration.add(cohesion);
    this.acceleration.add(separation);
  }

  void update() {
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
    this.velocity.limit(this.maxSpeed);
    this.acceleration.mult(0);
  }

  void show() {
    strokeWeight(2);
    stroke(strokeCol);
    point(this.position.x, this.position.y);
  }
}
