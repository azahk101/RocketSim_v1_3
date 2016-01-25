class Engine extends Particle
{
  
  Engine(float mass, PVector position, PVector velocity, PVector acceleration)
  {
    super(mass, position, velocity, acceleration);
  }
  
  void burnMass(Thrust t, int refresh)
  {
    if (t.row < t.thrustTable.getRowCount() - 2)
    {
      mass = mass - ((.0108/t.thrustTable.getFloat(t.thrustTable.getRowCount() - 2, "Time"))/refresh);
    }
  }
  
  
  
}
