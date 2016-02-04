class Graph_Line
{
  
  PShape plot;
  FloatList data;
  float t, y;
  
  Graph_Line(float t, float y)
  {
    this.t = t;
    this.y = y;
    data = new FloatList();
  }
  
  void initialize()
  {
    data.append(width/2.0 + 20 + t);
    data.append(height - 20 - y);
    stroke(0);
    strokeWeight(1.5);
    line(width/2.0 + 20, 20, width/2.0 + 20, height - 20);
    line(width/2.0 + 20, height - 20, width - 20, height - 20);
    strokeWeight(1);
  }
  
  void display(float t_p, float y_p, int check)
  {
    data.append(width/2.0 + 20 + t_p*width/50);
    data.append(height - 20 - y_p*height/200);
    if (check == 0)
    {
      stroke(222, 35, 0);
      strokeWeight(1.2);
      smooth();
      for (int i = 0; i < data.size() - 2; i += 2)
      {
        line(data.get(i), data.get(i+1), data.get(i+2), data.get(i+3));
      }
    }
  }
}
