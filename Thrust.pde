class Thrust extends Force {
  
  float avMag, thrustT;
  
  Thrust(float p_mass, float p_avMag, float p_thrustT) 
  {
    super(p_mass);
    this.avMag = p_avMag;
    this.thrustT = p_thrustT;
  }
  
 void applyThrust(PVector acceleration, PVector velocity, int refresh, float time) 
 {
    PVector thrust = velocity.get();
    if (thrust.y == 0) {
      thrust.y = 1;
    }
    thrust.normalize();
    thrust.mult(avMag);
    
    if (time/refresh < thrustT) {
      applyForce(thrust, acceleration, refresh);
    }
  }
}
