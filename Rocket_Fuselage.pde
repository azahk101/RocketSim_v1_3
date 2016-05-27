class Fuselage extends Particle
{
  float fusRad, fusLen;
  
  Fuselage(float mass, PVector position, PVector velocity, PVector acceleration, float fusRadius, float fusLength)
  {
    super(mass, position, velocity, acceleration);
    fusRad = fusRadius;
    fusLen = fusLength;
  }
  
  void display(float x, float y)
  {
    fill(125,255);
    rectMode(RADIUS);
    rect(x, y, fusRad*width/600, fusLen*width/1200);
  }
}
