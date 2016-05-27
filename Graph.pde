class Graph
{
  FloatList data;
  String[] labels = {"Time", "X-Pos", "Y-Pos", "X-Vel", "Y-Vel", "X-Accel", "Y-Accel"};
  PFont std;
  float[] inputs;
  float t,x,y,v_x,v_y,a_x,a_y;
  
  Graph(float t, float x, float y, float v_x, float v_y, float a_x, float a_y) 
  {
    this.t = t;
    this.x = x;
    this.y = y;
    this.v_x = v_x;
    this.v_y = v_y;
    this.a_x = a_x;
    this.a_y = a_y;
    std = createFont("Microsoft Sans Serif Bold", (height/160 + width/180));
  }
  
  void update(float t, float x, float y, float v_x, float v_y, float a_x, float a_y, Table table)
  {
    this.t = t;
    this.x = x;
    this.y = y;
    this.v_x = v_x;
    this.v_y = v_y;
    this.a_x = a_x;
    this.a_y = a_y;
    float[] inputs = {t*1.0, x, y, v_x, v_y, a_x, a_y};
    if (t == 0) {
      for (int i = 0; i < 7; i++)
      {
        table.addColumn(labels[i]);
      }
    }
    setData(table.addRow(), labels, inputs);
  }
  
  void display(int check, int count, float time, Table table) 
  {
    data = new FloatList();
    stroke(0);
    strokeWeight(1);
    rectMode(CORNER);
    for (int i = 0; i < 7; i++)
    {
      fill(0);
      data.append(table.getFloat(count, i));
      if (time == 0) {
        textFont(std);
        text(labels[i], 10 + width/30.0 * i, 10);
        text(labels[i], width/4.0 + 10 + width/30.0 * i, 10);
      }
      fill(255);
      float nums = float(nfs(data.get(i), 1, 3));
      if (time > 0 && time <= 5.0)
      {
        if (check == 1)
        {
        rect(10 + width/30.0 * i, height/26.0 * time*5.0, width/30.0, height/52.0);
        fill(0);
        textFont(std);
        text(nums, 10 + width/30.0 * i, height/64.0 + height/26.0 * time*5.0);
        } else
        {
          float t_temp = float(nfs(time, 1, 1));
          if (time%.1 < .05 && time%.5 != 0)
          {
            t_temp += .1;
          }
          rect(10 + width/30.0 * i, height/26.0 * t_temp*5.0, width/30.0, height/52.0);
          fill(0);
          textFont(std);
          text(nums, 10 + width/30.0 * i, height/64.0 + height/26.0 * t_temp*5.0);
        }
      } else if (time <= 10.0)
      {
        if (check == 1)
        {
        rect(width/4.0 + 10 + width/30.0 * i, height/26.0 * (time - 5)*5.0, width/30.0, height/52.0);
        fill(0);
        textFont(std);
        text(nums, width/4.0 + 10 + width/30.0 * i, height/64.0 + height/26.0 * (time - 5)*5.0);
        } else
        {
          float t_temp = float(nfs(time, 1, 1));
          if (time%.1 < .05 && time%.5 != 0)
          {
            t_temp += .1;
          }
          rect(width/4.0 + 10 + width/30.0 * i, height/26.0 * (t_temp - 5)*5.0, width/30.0, height/52.0);
          fill(0);
          textFont(std);
          text(nums, width/4.0 + 10 + width/30.0 * i, height/64.0 + height/26.0 * (t_temp - 5)*5.0);
        }
      } else
      {
      }
    }
  }
  
  void setData(TableRow newRow, String[] labels, float[] data) 
  {
    for (int i = 0; i < data.length; i ++) {
      newRow.setFloat(labels[i], data[i]);
    }
  }
}
