class Gravity extends Force
{
  float G = 6.67408 * pow(10,-11);
  float massE = 5.972 * pow(10,24);
  float radiusE = 6371000;
  Gravity()
  {
  }
  
  void applyGravity(Particle p, int refresh) 
  {
    PVector force = new PVector(0,1);
    float strength = -(G * p.mass * massE) / (pow(radiusE + p.position.y, 2));
    force.mult(strength);
    
    applyForce(p.mass, force, p.acceleration, refresh);
  }
}
