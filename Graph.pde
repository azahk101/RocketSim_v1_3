class Graph
{
  FloatList data;
  String[] labels;
  PFont std;
  float[] inputs;
  float t,x,y,v_x,v_y,a_x,a_y;
  Graph_Line gLine;
  
  Graph(float t, float x, float y, float v_x, float v_y, float a_x, float a_y) 
  {
    this.t = t;
    this.x = x;
    this.y = y;
    this.v_x = v_x;
    this.v_y = v_y;
    this.a_x = a_x;
    this.a_y = a_y;
    std = createFont("SansSerif", (height/200 + width/200));
    gLine = new Graph_Line(t, y);
    gLine.initialize();
  }
  
  void update(float t, float x, float y, float v_x, float v_y, float a_x, float a_y)
  {
    this.t = t;
    this.x = x;
    this.y = y;
    this.v_x = v_x;
    this.v_y = v_y;
    this.a_x = a_x;
    this.a_y = a_y;
  }
  
  void display(Table table, int check) 
  {
    gLine.display(t,y,check);
    stroke(0);
    strokeWeight(1);
    rectMode(CORNER);
    String[] labels = {"Time", "X-Pos", "Y-Pos", "X-Vel", "Y-Vel", "X-Accel", "Y-Accel"};
    float[] inputs = {t*1.0, x, y, v_x, v_y, a_x, a_y};
    data = new FloatList(inputs);
    for (int i = 0; i < 7; i++) {
      fill(0);
      if (t == 0) {
        table.addColumn(labels[i]);
        textFont(std);
        text(labels[i], 20 + width/32.0 * i, 20);
        text(labels[i], width/4.0 + 20 + width/32.0 * i, 20);
      }
      float nums = float(nfs(data.get(i), 1, 3));
      noFill();
      if (t > 0 && t <= 5.0) {
        if (check == 1) {
        rect(20 + width/32.0 * i, 10 + height/(80.0/3) * t*5.0, width/32.0, height/(160.0/3));
        fill(0);
        textFont(std);
        text(nums, 20 + width/32.0 * i, 10 + height/64.0 + height/(80.0/3) * t*5.0);
        } else {
          float t_temp = float(nfs(t, 1, 1));
          if (t%.1 < .05 && t%.5 != 0) {
            t_temp += .1;
          }
          rect(20 + width/32.0 * i, 10 + height/(80.0/3) * t_temp*5.0, width/32.0, height/(160.0/3));
          fill(0);
          textFont(std);
          text(nums, 20 + width/32.0 * i, 10 + height/64.0 + height/(80.0/3) * t_temp*5.0);
        }
      } else if (t <= 10.0) {
        if (check == 1) {
        rect(width/4.0 + 20 + width/32.0 * i, 10 + height/(80.0/3) * (t - 5)*5.0, width/32.0, height/(160.0/3));
        fill(0);
        textFont(std);
        text(nums, width/4.0 + 20 + width/32.0 * i, 10 + height/64.0 + height/(80.0/3) * (t - 5)*5.0);
        } else {
          float t_temp = float(nfs(t, 1, 1));
          if (t%.1 < .05 && t%.5 != 0) {
            t_temp += .1;
          }
          rect(width/4.0 + 20 + width/32.0 * i, 10 + height/(80.0/3) * (t_temp - 5)*5.0, width/32.0, height/(160.0/3));
          fill(0);
          textFont(std);
          text(nums, width/4.0 + 20 + width/32.0 * i, 10 + height/64.0 + height/(80.0/3) * (t_temp - 5)*5.0);
        }
      } else {
      }
    }
    setData(table.addRow(), labels, inputs);
  }
  
  void setData(TableRow newRow, String[] labels, float[] data) 
  {
    for (int i = 0; i < data.length; i ++) {
      newRow.setFloat(labels[i], data[i]);
    }
  }
}
