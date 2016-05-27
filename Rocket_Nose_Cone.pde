class Nosecone extends Particle
{
  float nosLen, coDrag, crossA, paraDi;
  int nosType;
  
  Nosecone(float mass, PVector position, PVector velocity, PVector acceleration, float noseLength, int noseType, float crossArea, float paraDiameter)
  {
    super(mass, position, velocity, acceleration);
    nosLen = noseLength;
    nosType = noseType;
    crossA = crossArea;
    paraDi = paraDiameter;
  }
  
  void display(float x, float y, float fusLen, float fusRad)
  {
    pushMatrix();
    scale(fusRad/20);
    translate(-x/(fusRad/20)*(fusRad/20-1), (fusLen/2-y)/(fusRad/20)*(fusRad/20-1));
    if (nosType == 1)
    {
      fill(0);
    rectMode(CENTER);
    rect(x, y-fusLen/2+7.5, 30, 15);
    beginShape();
    vertex(x-20, y-fusLen/2);
    bezierVertex(x-20, y-fusLen/2-20/1.5, x-20, y-fusLen/2-3*20/1.5, x, y-fusLen/2-80);
    bezierVertex(x+20, y-fusLen/2-3*20/1.5, x+20, y-fusLen/2-20/1.5, x+20, y-fusLen/2);
    endShape();
    } else if (nosType == 2)
    {
      fill(0);
    rectMode(CENTER);
    rect(x, y-fusLen/2+7.5, 30, 15);
    beginShape();
    vertex(x-20, y-fusLen/2);
    bezierVertex(x-23.5, y-fusLen/2-23.5/1.5, x-23.5, y-fusLen/2-3*23.5/1.5, x, y-fusLen/2-80);
    bezierVertex(x+23.5, y-fusLen/2-3*23.5/1.5, x+23.5, y-fusLen/2-23.5/1.5, x+20, y-fusLen/2);
    endShape();
    } else
    {
      fill(0);
    rectMode(CENTER);
    rect(x, y-fusLen/2+7.5, 30, 15);
    beginShape();
    vertex(x-20, y-fusLen/2);
    bezierVertex(x-27, y-fusLen/2-27/1.5, x-27, y-fusLen/2-3*27/1.5, x, y-fusLen/2-80);
    bezierVertex(x+27, y-fusLen/2-3*27/1.5, x+27, y-fusLen/2-27/1.5, x+20, y-fusLen/2);
    endShape();
    }
    popMatrix();
  }
  
  void setCoDrag()
  {
    if (nosType == 1) 
    {
      coDrag = .32;
    } else if (nosType == 2)
    {
      coDrag = .30;
    } else
    {
      coDrag = .40;
    }
  }
  
  void deployPara(float newDragC)
  {
      coDrag = newDragC;
      crossA = PI*pow(.01*paraDi/3, 2); //Parachute is not completely flat when deployed, so cross area is not exactly PI*R^2
  }
  
  float centroid()
  {
    if (nosType == 1)
    {
      return 2.0*nosLen/3.0;
    } else if (nosType == 2)
    {
      return .5*nosLen;
    } else
    {
      return nosLen/3.0;
    }
  }
  
  float normalForce()
  {
    return 2.0;
  }
}
