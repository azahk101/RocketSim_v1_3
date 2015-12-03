class Thrust extends Force {
  
  Table thrustTable;
  int row = 0;
  
  Thrust(float p_mass, Table thrustTable) 
  {
    super(p_mass);
    this.thrustTable = thrustTable;
  }
  
 void applyThrust(PVector acceleration, PVector velocity, int refresh, float time) 
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
    } else {
      row++;
      mag = thrustTable.getFloat(row, "Thrust");
    }
    
    thrust.mult(mag);
    applyForce(thrust, acceleration, refresh);
  }
}
