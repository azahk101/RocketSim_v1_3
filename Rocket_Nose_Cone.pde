class Nosecone extends Particle
{
  float noseLen, coDrag, crossA, paraDi;
  
  Nosecone(float mass, PVector position, PVector velocity, PVector acceleration, float noseLength, float crossArea, float coefficientDrag, float paraDiameter)
  {
    super(mass, position, velocity, acceleration);
    noseLen = noseLength;
    paraDi = paraDiameter;
    crossA = crossArea;
    coDrag = coefficientDrag;
  }
  
  void deployPara(float newDragC)
  {
      coDrag = newDragC;
      crossA = PI*pow(paraDi/3, 2); //Parachute is not completely flat when deployed, so cross area is not exactly PI*R^2
  }
  
  /*float noseConePressure(float len, int type) {
    if (type == 1) { //Conic nose cone
      return 2*len/3;
    } else if (type == 2) { //Ogive nose cone
      return .466*len;
    } else { //Parabolic nose cone
      return .5*len;
    }
  }*/
}
