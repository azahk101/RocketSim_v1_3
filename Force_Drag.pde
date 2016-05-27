class Drag extends Force
{
  float airDens;
  
  Drag(float p_airDens)
  {
    this.airDens = p_airDens;
  }
  
  void applyDrag(Rocket roc, int refresh)
  {
    float speed = roc.velocity.mag();
    float dragMagNos = .5 * roc.nos.coDrag * roc.nos.crossA * airDens * pow(speed,2);
    
    PVector nosDrag = roc.velocity.get();
    nosDrag.normalize();
    nosDrag.mult(-1);
    nosDrag.mult(dragMagNos);
    /*PVector test = nosDrag.get();
    test.div(roc.mass);
    println("Drag: ", test);*/
    
    applyForce(roc.mass, nosDrag, roc.acceleration, refresh);
  }
}
