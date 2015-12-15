class Nosecone {
  
  PShape s;
  float x, y, curve;
  int num;
  color c;
  
  Nosecone(float x_t, float y_t, float curve_t, color c_t, int num_t) {
    x = x_t;
    y = y_t;
    curve = curve_t;
    c = c_t;
    num = num_t;
  }
  
  void display() {
    fill(c);
    stroke(0);
    strokeWeight(.5);
    rectMode(CENTER);
    rect(x, y, 30, 15);
    beginShape();
    vertex(x-20, y-7.5);
    bezierVertex(x-curve, y-curve/1.5, x-curve, y-3*curve/1.5, x, y-80);
    bezierVertex(x+curve, y-3*curve/1.5, x+curve, y-curve/1.5, x+20, y-7.5);
    endShape();
    text(num, x - 5, y + 30);
  }
}
