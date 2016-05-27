class Rocket extends Particle
{
  Engine eng;
  Fins fin;
  Fuselage fus;
  Nosecone nos;
  float maxH;
  PImage[] images;
  int imageCount;
  
  Rocket(float mass, PVector position, PVector velocity, PVector acceleration, float i_engM, float i_fusM, float i_finM, float i_nosM, float i_fusRad, float i_fusLen,
    float i_finLen, float i_finNum, float i_nosLen, int i_nosType, float n_crossA, float i_paraDi)
  {
    super(mass, position, velocity, acceleration);
    eng = new Engine(i_engM, position, velocity, acceleration);
    fin = new Fins(i_finM, position, velocity, acceleration, i_finLen, i_finNum);
    fus = new Fuselage(i_fusM, position, velocity, acceleration, i_fusRad, i_fusLen);
    nos = new Nosecone(i_nosM, position, velocity, acceleration, i_nosLen, i_nosType, n_crossA, i_paraDi);
    nos.setCoDrag();
    maxH = 0;
    images = new PImage[17];
    imageCount = 0;
    for (int i = 0; i < 17; i++) {
      String filename = "explode" + i + ".gif";
      images[i] = loadImage(filename);
    }
  }
  
  void display(Table table, Table tableT, int count, int refresh)
  {
    position.x = 3*width/5+count*3*width/10/(table.getRowCount()-1);
    position.y = 2*height/3-((2*height/3-roc.fus.fusLen*width/800-roc.nos.nosLen*width/200-height/12)/maxH)*table.getFloat(count, "Y-Pos");
    if (count <= tableT.getFloat(tableT.getRowCount()-2, "Time")*refresh)
    {
      pushMatrix();
      translate(position.x, position.y);
      if (pow((position.x-3*width/5)/(width/15), 3) < 1.75)
      {
        rotate((PI/2)*pow((position.x-3*width/5)/(width/15), 3));
      } else
      {
        rotate(PI*1.75/2);
      }
      fin.display(0, 0, fus.fusLen*width/600, fus.fusRad*width/600);
      nos.display(0, 0, fus.fusLen*width/600, fus.fusRad*width/600);
      fus.display(0, 0);
      stroke(#FA341E);
      fill(#FF9900);
      beginShape();
      vertex(fus.fusRad*width/600, fus.fusLen*width/1200);
      vertex(fus.fusRad*width/600, fus.fusLen*3*width/2400);
      vertex(fus.fusRad*width/1200, fus.fusLen*width/600);
      vertex(0, fus.fusLen*3*width/2400);
      vertex(-fus.fusRad*width/1200, fus.fusLen*width/600);
      vertex(-fus.fusRad*width/600, fus.fusLen*3*width/2400);
      vertex(-fus.fusRad*width/600, fus.fusLen*width/1200);
      endShape(CLOSE);
      popMatrix();
    } else if (count >= tableT.getFloat(tableT.getRowCount()-2, "Time")*refresh && count + 25 <= tableT.getFloat(tableT.getRowCount()-1, "Time")*refresh)
    {
      pushMatrix();
      translate(position.x, position.y);
      if (pow((position.x-3*width/5)/(width/15), 3) < 1.75)
      {
        rotate((PI/2)*pow((position.x-3*width/5)/(width/15), 3));
      } else
      {
        rotate(PI*1.75/2);
      }
      fin.display(0, 0, fus.fusLen*width/600, fus.fusRad*width/600);
      nos.display(0, 0, fus.fusLen*width/600, fus.fusRad*width/600);
      fus.display(0, 0);
      popMatrix();
    } else if (tableT.getFloat(tableT.getRowCount()-1, "Time")*refresh > count - 25 && tableT.getFloat(tableT.getRowCount()-1, "Time")*refresh <= count + 25)
    {
      imageMode(CENTER);
      image(images[imageCount], position.x, position.y);
      if (count % 4 == 0)
      {
        imageCount++;
      }
    } else
    {
      nos.display(position.x, position.y+fus.fusLen*width/600, fus.fusLen*width/600, fus.fusRad*width/600);
      stroke(0);
      noFill();
      beginShape();
      vertex(position.x, position.y+fus.fusLen*width/1200-nos.nosLen*width/800);
      vertex(position.x+fus.fusRad*width/200, position.y-fus.fusLen*width/1200);
      vertex(position.x-fus.fusRad*width/200, position.y-fus.fusLen*width/1200);
      endShape(CLOSE);
      fill(125);
      noStroke();
      arc(position.x, position.y-fus.fusLen*width/1200, fus.fusRad*width/100, fus.fusLen*width/600, PI, 2*PI);
    }
    fill(0);
    stroke(0);
    text("Time: "+table.getFloat(count, "Time"), position.x+fus.fusRad*width/600, position.y-fus.fusLen*width/1200-nos.nosLen*width/300-18);
    text("Height: "+table.getFloat(count, "Y-Pos"), position.x+fus.fusRad*width/600, position.y-fus.fusLen*width/1200-nos.nosLen*width/300);
  }
  
  void getMaxHeight(float y)
  {
    if (y > maxH)
    {
      maxH = y;
    }
  }
  
  void update(Thrust t, int refresh)
  {
    eng.acceleration = acceleration;
    fin.acceleration = acceleration;
    fus.acceleration = acceleration;
    nos.acceleration = acceleration;
    eng.velocity = velocity;
    fin.velocity = velocity;
    fus.velocity = velocity;
    nos.velocity = velocity;
    eng.position = position;
    fin.position = position;
    fus.position = position;
    nos.position = position;
    getMaxHeight(position.y/refresh);
    eng.burnMass(t, refresh);
    
    if (t.stageChange)
    {
      mass = nos.mass;
      nos.deployPara(1.35);
    } else 
    {
      mass = eng.mass + fin.mass + fus.mass + nos.mass;
    }
  }
  
  float centerPressure()
  {
    float CP = (nos.normalForce()*nos.centroid() + fin.normalForce(fus.fusRad)*fin.centroid(fus.fusLen, nos.nosLen))/(nos.normalForce() + fin.normalForce(fus.fusRad));
    return CP;
  }
  
  float centerGravity()
  {
    float CG = (eng.mass*(nos.nosLen+fus.fusLen-3.5) + fin.mass*fin.centroid(fus.fusLen, nos.nosLen) + fus.mass*(nos.nosLen+fus.fusLen/2) + nos.mass*nos.centroid())/mass;
    return CG;
  }

  float calcStability()
  {
    float statMarg = (centerPressure() - centerGravity())/fus.fusRad;
    return statMarg;
  }
}
