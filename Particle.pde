class Particle {
  PVector position, velocity, acceleration, stoAcceleration;
  float mass = .75;
  
  Particle(PVector position, PVector velocity, PVector acceleration)
  {
    this.position = position;
    this.velocity = velocity;
    this.acceleration = acceleration;
    this.stoAcceleration = acceleration;
  }
  
  void move() 
  {
    velocity.add(acceleration);
    position.add(velocity);
    stoAcceleration = acceleration.get();
    stoAcceleration.mult(refresh);
    acceleration.mult(0);
  }
}
