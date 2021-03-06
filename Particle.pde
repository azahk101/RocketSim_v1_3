class Particle {
  PVector position, velocity, acceleration, stoAcceleration;
  float mass;
  
  Particle(float p_mass, PVector position, PVector velocity, PVector acceleration)
  {
    this.mass = p_mass;
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
