class Rocket extends Particle
{
  Engine eng;
  Fins fin;
  Fuselage fus;
  Nosecone nos;
  
  Rocket(float mass, PVector position, PVector velocity, PVector acceleration, float i_engM, float i_finM, float i_fusM, float i_nosM,
    float i_finLen, float i_fusRad, float i_nosLen, float i_paraDi, float f_crossA, float n_crossA, float f_coDrag, float n_coDrag)
  {
    super(mass, position, velocity, acceleration);
    eng = new Engine(i_engM, position, velocity, acceleration);
    fin = new Fins(i_finM, position, velocity, acceleration, i_finLen, f_crossA, f_coDrag);
    fus = new Fuselage(i_fusM, position, velocity, acceleration, i_fusRad);
    nos = new Nosecone(i_nosM, position, velocity, acceleration, i_nosLen, n_crossA, n_coDrag, i_paraDi);
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
}
