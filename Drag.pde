class Drag extends Force {
  
  float crossArea, coDrag, airDens;
  
  Drag(float p_mass, float p_airDens, float p_crossArea, float p_coDrag)
  {
    super(p_mass);
    this.airDens = p_airDens;
    this.crossArea = p_crossArea;
    this.coDrag = p_coDrag;
  }
  
  void applyDrag(PVector acceleration, PVector velocity, int refresh)
  {
    float speed = velocity.mag();
    float dragMag = .5 * coDrag * crossArea * airDens * pow(speed,2);
    PVector drag = velocity.get();
    drag.normalize();
    drag.mult(-1);
    drag.mult(dragMag);
    
    applyForce(drag, acceleration, refresh);
  }
}
