class Force {
  float mass;
  float mag;
  Force(float p_mass) {
    this.mass = p_mass;
  }
  
  PVector getAcceleration(PVector dir) {
    PVector a = dir.get();
    a.normalize();
    a.mult(mag);
    return a;
  }
}
