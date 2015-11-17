class Force {
  float mass;
  
  Force(float p_mass) 
  {
    this.mass = p_mass;
  }
  
  void applyForce(PVector force, PVector acceleration, int refresh)
  {
    PVector f = force.get();
    f.div(mass*refresh);
    acceleration.add(f);
  }
}
