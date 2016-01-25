class Fins extends Particle
{
  float finLen, crossA, coDrag;
  
  Fins(float mass, PVector position, PVector velocity, PVector acceleration, float crossArea, float coefficientDrag, float finLength)
  {
    super(mass, position, velocity, acceleration);
    finLen = finLength;
    crossA = crossArea;
    coDrag = coefficientDrag;
  }
  
  /*float finPressure(int type) {
    
  }*/
}
  
