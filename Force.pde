class Force
{
  
  Force() 
  {
  }
  
  void applyForce(float mass, PVector force, PVector acceleration, int refresh)
  {
    PVector f = force.get();
    f.div(mass*refresh);
    acceleration.add(f);
  }
}
