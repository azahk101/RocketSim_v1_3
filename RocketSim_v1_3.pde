Graph graph;
FloatList inputArray;
String[] inputLabels;
String[] textfieldID;
Gravity grav;
Thrust thrust;
Drag drag;
R_Nosecone nose1;
R_Nosecone nose2;
R_Nosecone nose3;
Rocket roc;
Table dataTable;
Table thrustTable;
boolean clearPlot;
float stability;
int time;
int refresh;
int state;
int count;
PVector x_i, v_i, a_i;

import controlP5.*;
ControlP5 cp5;

import http.requests.*;
PostRequest post;

void setup()
{
  size(1300, 650);
  time = 0;
  refresh = 100;
  state = 0;
  count = 0;
  x_i = new PVector(0, 0);
  v_i = new PVector(0, 0);
  a_i = new PVector(0, 0);
  
  nose1 = new R_Nosecone(2*width/5, height/10 + 4*height/5, 20, #747373, 1);
  nose2 = new R_Nosecone(2*width/5 + width/10, height/10 + 4*height/5, 23.5, #747373, 2);
  nose3 = new R_Nosecone(2*width/5 + width/5, height/10 + 4*height/5, 27, #747373, 3);

  cp5 = new ControlP5(this);
  inputArray = new FloatList();
  inputLabels = new String[] {"Enter mass of fuselage (g):", "Enter mass of fins (g):", "Enter mass of nose cone + payload (g):", "Enter radius of fuselage (cm):", "Enter length of fuselage (cm):",
    "Enter length of fins (cm):", "Enter number of fins:", "Enter length of nose cone (cm):", "Enter nose cone type (choose 1, 2, or 3):", "Enter parachute diameter (cm):"};
  for (int i = 0; i < 10; i++)
  {
    cp5.addTextfield(inputLabels[i])
         .setPosition(width/6 + (i%2)*width/2, height/20 + floor(i/2)*(height/5))
           .setSize(width/6, height/10)
             .setFont(createFont("Microsoft Sans Serif", (height/40 + width/75)))
             .setColor(color(255, 0, 0))
               .getCaptionLabel().align(LEFT, LEFT).setFont(createFont("Microsoft Sans Serif", (height/200 + width/200)))
                 ;
  }
  
  cp5.addBang("bang")
       .setPosition(width/2-width/24, height/2-height/40)
         .setSize(width/12, height/20)
           .setLabel("Done")
             .getCaptionLabel().align(CENTER, CENTER).setFont(createFont("Microsoft Sans Serif", (height/200 + width/200)))
               ;
  cp5.addToggle("toggle")
       .setPosition(width/2-width/24, height/2-height/5)
         .setSize(width/12, height/20)
           .setValue(false)
             .setMode(ControlP5.SWITCH)
               .setCaptionLabel("Clear plot (Y/N)")
                 ;
}

void draw()
{
  if (inputArray.size() <= 10 && state <= 1)
  {
    if (state == 1)
    {
      for (int i = 0; i < 10; i++)
      {
        inputArray.append(float(cp5.get(Textfield.class, inputLabels[i]).getText()));
      }
    }
    background(0);
    fill(255);
    nose1.display();
    nose2.display();
    nose3.display();
  }
  if (state == 1)
  {
    cp5.get(Bang.class, "bang").setPosition(width/2, 10).setLabel("Pause");
    cp5.get(Toggle.class, "toggle").remove();
    for (int i = 0; i < 10; i++)
    {
      String outputLabel;
      if (i == 2)
      {
        outputLabel = " mass of nc + payload (kg):";
      } else
      {
        outputLabel = inputLabels[i].substring(5);
      }
      if (i == 8)
      {
        cp5.get(Textfield.class, inputLabels[i]).remove();
      } else
      {
        if (i == 9)
        {
          cp5.get(Textfield.class, inputLabels[i]).setPosition(width/2 + (width/36 + ((i-1)%3)*width/6), height/2 + (height/4 + floor((i-1)/3)*(height/14)))
            .setSize(width/9, height/12).setLabel(outputLabel);
        } else
        {
          cp5.get(Textfield.class, inputLabels[i]).setPosition(width/2 + (width/36 + (i%3)*width/6), height/2 + (height/4 + floor(i/3)*(height/14)))
            .setSize(width/9, height/12).setLabel(outputLabel);
        }
      }
    }
    
    background(255);
    
    roc = new Rocket(.024 + .001*inputArray.get(0) + .001*inputArray.get(1) + .001*inputArray.get(2), x_i, v_i, a_i, .024, .001*inputArray.get(0), .001*inputArray.get(1), .001*inputArray.get(2),
      inputArray.get(3), inputArray.get(4), inputArray.get(5), inputArray.get(6), inputArray.get(7), int(inputArray.get(8)), PI*pow(.01*inputArray.get(3), 2), inputArray.get(9));
    
    thrustTable = loadTable("data/thrust.csv", "header");
    grav = new Gravity();
    thrust = new Thrust(thrustTable);
    drag = new Drag(1.2);
    graph = new Graph(time/(refresh*1.0), roc.position.x/refresh, roc.position.y/refresh, roc.velocity.x, roc.velocity.y, roc.stoAcceleration.x, roc.stoAcceleration.y);
    dataTable = new Table();
    state++;
  } else if (state == 2)
  {
    if (time == 0)
    {
      stability = roc.calcStability();
    }
    while (time <= refresh/10 || roc.position.y != 0)
    {
      if (roc.position.y >= 0.0)
      {
        graph.update(time/(refresh*1.0), roc.position.x/refresh, roc.position.y/refresh, roc.velocity.x, roc.velocity.y, roc.stoAcceleration.x, roc.stoAcceleration.y, dataTable);
        grav.applyGravity(roc, refresh);
        thrust.applyThrust(roc, refresh, time);
        drag.applyDrag(roc, refresh);
        roc.move(refresh);
        roc.update(thrust, refresh);
        time ++;
      } else
      {
        roc.position.y = 0;
      }
    }
    graph.update(time/(refresh*1.0), roc.position.x/refresh, 0, roc.velocity.x, roc.velocity.y, roc.stoAcceleration.x, roc.stoAcceleration.y, dataTable);
    saveTable(dataTable, "data/data.csv");
    
    time = 0;
    state++;
  } else if (state == 3)
  {
    if (time < dataTable.getRowCount() - 1)
    {
      fill(255);
      rectMode(RADIUS);
      stroke(255);
      rect(roc.position.x, roc.position.y, (roc.fus.fusRad+roc.fin.finLen + 10)*width/400, (roc.fus.fusLen + roc.nos.nosLen + 10)*width/400);
      rect(roc.position.x+roc.fus.fusRad*width/400, roc.position.y-roc.fus.fusLen*width/800-roc.nos.nosLen*width/200, (roc.fus.fusRad+roc.fin.finLen + width/150)*width/200, (roc.fus.fusLen + roc.nos.nosLen + 1)*width/400);
      fill(#0FD83F);
      stroke(#0FD83F);
      rectMode(CORNER);
      rect(width/4+10+width/5+width/30+10, 2*height/3+roc.fus.fusLen*width/1200, width-(width/4+10+width/5+width/30+10), height-(2*height/3+roc.fus.fusLen*width/1200));
      stroke(0);
      roc.display(dataTable, thrustTable, time, refresh);
      if (time % (refresh/10) == 0)
        {
          graph.display(1, time, time/(refresh*1.0), dataTable);
        }
      time++;
    } else if (time == dataTable.getRowCount() - 1)
    {
      cp5.get(Bang.class, "bang").remove();
      fill(255);
      rectMode(CORNER);
      stroke(255);
      rect(width/2, 10, width/12, height/20);
      rectMode(RADIUS);
      rect(roc.position.x, roc.position.y, (roc.fus.fusRad+roc.fin.finLen + 1)*width/400, (roc.fus.fusLen + roc.nos.nosLen + 1)*width/400);
      rect(roc.position.x+roc.fus.fusRad*width/400, roc.position.y-roc.fus.fusLen*width/800-roc.nos.nosLen*width/200, (roc.fus.fusRad+roc.fin.finLen + width/150)*width/200, (roc.fus.fusLen + roc.nos.nosLen + 1)*width/400);
      fill(#0FD83F);
      stroke(#0FD83F);
      rectMode(CORNER);
      rect(width/4+10+width/5+width/30+10, 2*height/3+roc.fus.fusLen*width/1200, width-(width/4+10+width/5+width/30+10), height-(2*height/3+roc.fus.fusLen*width/1200));
      roc.display(dataTable, thrustTable, time, refresh);
      graph.display(0, time, time/(refresh*1.0), dataTable);
      time++;
    } else
    {
    textAlign(CENTER);
    stroke(0);
    fill(0);
    textFont(createFont("Microsoft Sans Serif", 18));
    text("Maximum height: " + roc.maxH + " m", width*3/4, height/2 - 22);
    text("Rocket landed at time " + (time-1)/(refresh*1.0) + " seconds", width*3/4, height/2 - 42);
    text("Terminal velocity: " + abs(roc.velocity.y) + " m/s", width*3/4, height/2 - 62);
    
    String flightReport;
    if (stability > 3.0)
    {
      flightReport = "very stable flight";
    } else if (stability > 1.5)
    {
      flightReport = "stable flight";
    } else if (stability > 1.0)
    {
      flightReport = "slightly unstable flight";
    } else
    {
        flightReport = "unstable flight";
      }
      text("Static margin of stability: " + stability + " - " + flightReport, width*3/4, height/2 - 82);
    
    
      String xVal = "";
      String yVal = "";
      for (int i = 0; i < dataTable.getRowCount(); i++)
      {
        if (i < dataTable.getRowCount() - 1)
        {
          xVal += (""+dataTable.getFloat(i, "Time") + ",");
          yVal += (""+dataTable.getFloat(i, "Y-Pos") + ",");
        } else
        {
         xVal += (""+dataTable.getFloat(i, "Time"));
         yVal += (""+dataTable.getFloat(i, "Y-Pos")); 
        }
      }
      PostRequest post = new PostRequest("https://plot.ly/clientresp");
      post.addData("un","azahk101");
      post.addData("key", "qkqrue6kqj");
      post.addData("origin", "plot");
      post.addData("platform", "processing");
      post.addData("args", "[[" + xVal + "],[" + yVal + "]]");
      if (clearPlot == true)
      {
        post.addData("kwargs", "{\"filename\": \"plot from api\", \"fileopt\": \"overwrite\",\"layout\": {\"title\": \"Processing Rocket Simulation\", \"xaxis\": {\"title\": \"Time (s)\"}, \"yaxis\": {\"title\": \"Y-Position (m)\"}}}");
      } else
      {
        post.addData("kwargs", "{\"filename\": \"plot from api\", \"fileopt\": \"append\",\"layout\": {\"title\": \"Processing Rocket Simulation\", \"xaxis\": {\"title\": \"Time (s)\"}, \"yaxis\": {\"title\": \"Y-Position (m)\"}}}");
      }
      post.send();
      println("Response:" + post.getContent());
      String response = post.getContent().substring(9, post.getContent().indexOf("message") - 4);
      open("start " + response);
      noLoop();
    }
  } else if (state == 4)
  {
    
  }
}

public void bang()
{
  state++;
  cp5.get(Bang.class, "bang").setLabel("Play");
  if (state == 5)
  {
    state = 3;
    cp5.get(Bang.class, "bang").setLabel("Pause");
  }
}

void toggle(boolean theFlag)
{
  if (theFlag == true)
  {
    clearPlot = true;
  } else
  {
    clearPlot = false;
  }
}
