class Gravity extends Force {
  
  float G = 6.67408 * pow(10,-11);
  float massE = 5.972 * pow(10,24);
  float radiusE = 6371000;
  Gravity()
  {
  }
  
  void applyGravity(float mass, PVector acceleration, float posY, int refresh) 
  {
    PVector force = new PVector(0,1);
    float strength = -(G * mass * massE) / (pow(radiusE + posY, 2));
    force.mult(strength);
    
    applyForce(mass, force, acceleration, refresh);
  }
}
