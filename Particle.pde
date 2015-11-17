class Particle {
  PVector position, velocity, acceleration, stoAcceleration;
  float mass = .75;
  float G = 6.67408 * pow(10,-11);
  float massE = 5.972 * pow(10,24);
  float radiusE = 6371000;
  
  Particle(PVector position, PVector velocity, PVector acceleration) {
    this.position = position;
    this.velocity = velocity;
    this.acceleration = acceleration;
    this.stoAcceleration = acceleration;
  }
  
  void move(int refresh, int t) {
    applyForce(forceGravity(), refresh);
    applyForce(forceThrust(t, refresh), refresh);
    applyForce(forceAirResistance(.5, .15, 1), refresh);
    //println(forceGravity());
    //println(forceThrust(t, refresh));
    println(forceAirResistance(.5, .15, 1));
    println(t/refresh);
    velocity.add(acceleration);
    position.add(velocity);
    stoAcceleration = acceleration.get();
    stoAcceleration.mult(refresh);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force, int refresh) {
    PVector f = force.get();
    f.div(mass*refresh);
    acceleration.add(f);
}
  
  PVector forceGravity() {
    PVector force = new PVector(0,1);
    float strength = -(G * mass * massE) / (pow(radiusE + position.y, 2));
    force.mult(strength);
    
    return force;
  }
  
  PVector forceAirResistance(float c, float area, float dens) {
    float speed = velocity.mag();
    float dragMag = .5 * c * area * dens * pow(speed,2);
    PVector drag = velocity.get();
    drag.normalize();
    drag.mult(-1);
    drag.mult(dragMag);
    
    return drag;
  }
  
  PVector forceThrust(int time, int refresh) {
    float mag = 20;
    PVector thrust = velocity.get();
    if (thrust.y == 0) {
      thrust.y = 1;
    }
    thrust.normalize();
    thrust.mult(mag);
    
    if (time/refresh < 5.0) {
      return thrust;
    } else  {
      return new PVector(0,0);
    }
  }
}
