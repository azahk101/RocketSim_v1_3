class Thrust extends Force {
  
  float avMag;
  
  Thrust(float p_mass, float p_avMag) 
  {
    super(p_mass);
    this.avMag = p_avMag;
  }
  
 void applyThrust(PVector acceleration, PVector velocity, int refresh, float time) 
 {
    PVector thrust = velocity.get();
    if (thrust.y == 0) {
      thrust.y = 1;
    }
    thrust.normalize();
    thrust.mult(avMag);
    
    if (time/refresh < 5.0) {
      applyForce(thrust, acceleration, refresh);
    }
  }
}
