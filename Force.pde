class Force {
  
  Force() 
  {
  }
  
  void applyForce(float mass, PVector force, PVector acceleration, int refresh)
  {
    PVector f = force.get();
    f.div(mass*refresh);
    println(f);
    acceleration.add(f);
  }
}
