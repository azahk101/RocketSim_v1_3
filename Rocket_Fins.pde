class Fins extends Particle
{
  float finLen;
  int finNum;
  
  Fins(float mass, PVector position, PVector velocity, PVector acceleration, float finLength, float numberFins)
  {
    super(mass, position, velocity, acceleration);
    finLen = finLength;
    finNum = int(numberFins);
  }
  
  void display(float x, float y, float fusLen, float fusRad)
  {
    fill(255,0,0);
    triangle(x-fusRad, y+fusLen/2, x-fusRad-(finLen*width/600), y+fusLen/2, x-fusRad, y+fusLen/2-(finLen*width/600));
    triangle(x+fusRad, y+fusLen/2, x+fusRad+(finLen*width/600), y+fusLen/2, x+fusRad, y+fusLen/2-(finLen*width/600));
  }
  
  float centroid(float fusLen, float nosLen) //simplified
  {
    float finCent = (fusLen + nosLen - finLen/3);
    return finCent;
  }
  
  float normalForce(float fusRad)
  {
    float interference = 1.0 + fusRad/(finLen + fusRad);
    float chordLen = finLen * pow(5.0/4.0, 1/2);
    float normForce = interference * 4.0*finNum*pow(finLen/(fusRad*2.0), 2)/(1+pow(1+pow(chordLen*2.0/finLen,2), 1/2));
    return normForce;
  }
}


  
