class Drag extends Force {
  
  float crossArea, coDrag;
  Drag(float p_mass, float p_crossArea, float p_coDrag) {
    super(p_mass);
    this.crossArea = p_crossArea;
    this.coDrag = p_coDrag;
  }
  
  void calcDrag(PVector velocity) {
  }
}
