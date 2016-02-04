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
    data.append(t);
    data.append(y);
    stroke(0);
    strokeWeight(1.5);
    line(width/2.0 + 20, 20, width/2.0 + 20, height - 20);
    line(width/2.0 + 20, height - 20, width - 20, height - 20);
    strokeWeight(1);
  }
  
  void display(float t_p, float y_p, int check)
  {
    data.append(t_p);
    data.append(y_p);
    if (check == 0)
    {
      stroke(222, 50, 5);
      strokeWeight(1.2);
      smooth();
      float maxH = 0.0;
      for (int i = 1; i < data.size() - 2; i += 2)
      {
        if (data.get(i) > maxH)
        {
          maxH = data.get(i);
        }
      }
      maxH += 10;
      for (int i = 0; i < data.size() - 2; i += 2)
      {
        line(width/2.0 + 20 + data.get(i)*(width/2.0 - 40)/data.get(data.size()-2), height - 20 - data.get(i+1)*(height - 40)/maxH, width/2.0 + 20 + data.get(i+2)*(width/2.0 - 40)/data.get(data.size()-2), height - 20 - data.get(i+3)*(height - 40)/maxH);
      }
    }
  }
}
