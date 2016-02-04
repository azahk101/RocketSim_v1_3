class Thrust extends Force
{
  Table thrustTable;
  int row = 0;
  boolean stageChange = false;
  
  Thrust(Table thrustTable) 
  {
    this.thrustTable = thrustTable;
  }
  
 void applyThrust(Particle p, int refresh, float time) 
 {
    PVector thrust = p.velocity.get();
    if (thrust.y <= 0) {
      thrust.y = 1;
    }
    thrust.normalize();
    
    float thrustT = thrustTable.getFloat(row, "Time");
    float mag = 0;
    if (thrustT >= time/float(refresh))
    {
      mag = thrustTable.getFloat(row, "Thrust");
    } else if (row == thrustTable.getRowCount() - 1)
    {
      stageChange = true;
    } else
    {
      row++;
      mag = thrustTable.getFloat(row, "Thrust");
    }
    
    thrust.mult(mag);
    /*PVector test = thrust.get();
    test.div(p.mass);
    println("Thrust: ", test);*/
    applyForce(p.mass, thrust, p.acceleration, refresh);
  }
}
