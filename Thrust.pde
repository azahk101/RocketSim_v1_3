class Thrust extends Force {
  
  Table thrustTable;
  int row = 0;
  boolean stageChange = false;
  
  Thrust(Table thrustTable) 
  {
    this.thrustTable = thrustTable;
  }
  
 void applyThrust(float mass, PVector acceleration, PVector velocity, int refresh, float time) 
 {
    PVector thrust = velocity.get();
    if (thrust.y <= 0) {
      thrust.y = 1;
    }
    thrust.normalize();
    
    float thrustT = thrustTable.getFloat(row, "Time");
    float mag = 0;
    if (thrustT >= time/refresh) {
      mag = thrustTable.getFloat(row, "Thrust");
    } else if (row == thrustTable.getRowCount() - 1) {
      stageChange = true;
    } else {
      row++;
      mag = thrustTable.getFloat(row, "Thrust");
    }
    
    thrust.mult(mag);
    applyForce(mass, thrust, acceleration, refresh);
  }
  
  float burnMass(float mass, int refresh)
  {
    if (row < thrustTable.getRowCount() - 2)
    {
      mass = mass - ((.0108/thrustTable.getFloat(thrustTable.getRowCount() - 2, "Time"))/refresh);
    }
    return mass;
  }
}
