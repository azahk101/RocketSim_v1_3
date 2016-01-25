class Fuselage extends Particle
{
  float fusRad;
  
  Fuselage(float mass, PVector position, PVector velocity, PVector acceleration, float fusRadius)
  {
    super(mass, position, velocity, acceleration);
    fusRad = fusRadius;
  }
  
  /*float fusselagePressure(float fussLen, finLen)
  {
    return 1 + (fussLen / (fussLen + finLen));
  }*/
}
