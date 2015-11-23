class Rocket extends Particle{
  float noseForce, fussForce, finForce, deltoid;
  float finLen, noseLen, fussRad;
  Rocket(float p_mass, PVector position, PVector velocity, PVector acceleration, float finLength, float noseLength, float fussRadius)
  {
    super(p_mass, position, velocity, acceleration);
    noseForce = 2;
  }
  /*
  float noseConePressure(float len, int type) {
    if (type == 1) { //Conic nose cone
      return 2*len/3;
    } else if (type == 2) { //Ogive nose cone
      return .466*len;
    } else { //Parabolic nose cone
      return .5*len;
    }
  }
  
  float fusselagePressure(float fussLen, finLen) {
    return 1 + (fussLen / (fussLen + finLen));
  }
  
  float finPressure(int type) {
    
  }
  
  void calcDeltoid() {
    float normalF = noseConePressure(noseLen,1) + fusselagePressure(fussRad) + 
    deltoid = 
  } */
}
