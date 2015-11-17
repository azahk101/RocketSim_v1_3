class Graph {
  FloatList data;
  String[] labels;
  float[] inputs;
  float x,y,v_x,v_y,a_x,a_y;
  
  Graph(float x, float y, float v_x, float v_y, float a_x, float a_y) 
  {
    this.x = x;
    this.y = y;
    this.v_x = v_x;
    this.v_y = v_y;
    this.a_x = a_x;
    this.a_y = a_y;
  }
  
  void display(Table table, float t) 
  {
    String[] labels = {"Time", "X-Pos", "Y-Pos", "X-Vel", "Y-Vel", "X-Accel", "Y-Accel"};
    float[] inputs = {t*1.0, x, y, v_x, v_y, a_x, a_y};
    data = new FloatList(inputs);
    for (int i = 0; i < 7; i++) {
      fill(0);
      if (t == 0) {
        table.addColumn(labels[i]);
        text(labels[i], 20 + 50 * i, 20);
        text(labels[i], width/2 + 20 + 50 * i, 20);
      }
      float nums = data.get(i);
      noFill();
      if (t > 0 && t <= 5.0) {
        rect(20 + 50 * i, 10 + 30 * t*5.0, 50, 15);
        fill(0);
        text(nums, 20 + 50 * i, 22.5 + 30 * t*5.0);
      } else {
        rect(width/2 + 20 + 50 * i, 10 + 30 * (t - 5)*5.0, 50, 15);
        fill(0);
        text(nums, width/2 + 20 + 50 * i, 22.5 + 30 * (t - 5)*5.0);
      }
        
    }
    setData(table.addRow(), labels, inputs, t);
  }
  
  void setData(TableRow newRow, String[] labels, float[] data, float t) 
  {
    for (int i = 0; i < data.length; i ++) {
      newRow.setFloat(labels[i], data[i]);
    }
  }
}
