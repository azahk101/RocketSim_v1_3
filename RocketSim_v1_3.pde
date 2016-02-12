Graph graph;
FloatList inputArray;
Gravity grav;
Thrust thrust;
Drag drag;
R_Nosecone nose1;
R_Nosecone nose2;
R_Nosecone nose3;
Rocket roc;
Table dataTable;
int time;
int refresh;
int state;
PVector x_i, v_i, a_i;

import controlP5.*;
ControlP5 cp5;
String textValue = "";

void setup()
{
  size(1300, 700);
  time = 0;
  refresh = 100;
  state = 0;
  x_i = new PVector(0, 0);
  v_i = new PVector(0, 0);
  a_i = new PVector(0, 0);
  
  nose1 = new R_Nosecone(width/4, height/4, 20, #747373, 1);
  nose2 = new R_Nosecone(width/2, height/4, 23.5, #747373, 2);
  nose3 = new R_Nosecone(width*3/4, height/4, 27, #747373, 3);

  cp5 = new ControlP5(this);
  PFont font = createFont("arial", 30);
  inputArray = new FloatList();
  cp5.addTextfield("input")
    .setPosition(width/2 - 100, height/2 - 30)
      .setSize(200, 60)
        .setFont(font)
          .setFocus(true)
            .setColor(color(255, 0, 0))
              .getCaptionLabel().align(LEFT, LEFT)
                ;
}

void draw()
{
  if (state <= 8)
  {
    background(0);
    fill(255);
    if (state == 0)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter mass of engine (kg):");
    } else if (state == 1)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter mass of fins (kg):");
    } else if (state == 2)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter mass of fuselage (kg):");
    } else if (state == 3)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter mass of nose cone + payload (kg):");
    } else if (state == 4)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter length of fins (m):");
    } else if (state == 5)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter radius of fuselage (m):");
    } else if (state == 6)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter length of nose cone (m):");
    } else if (state == 7)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter nose cone type (choose 1, 2, or 3):");
      nose1.display();
      nose2.display();
      nose3.display();
    } else if (state == 8)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter parachute diameter (m):");
    }
  } else
  {
    float noseDrag = 0;
    if (inputArray.get(7) == 1) 
    {
      noseDrag = .32;
    } else if (inputArray.get(7) == 2)
    {
      noseDrag = .30;
    } else
    {
      noseDrag = .40;
    }
    cp5.get(Textfield.class, "input").remove();
    background(255);
    
    roc = new Rocket(inputArray.get(0) + inputArray.get(1) + inputArray.get(2) + inputArray.get(3), x_i, v_i, a_i, inputArray.get(0), inputArray.get(1), inputArray.get(2), inputArray.get(3),
      inputArray.get(4), inputArray.get(5), inputArray.get(6), inputArray.get(8), 0/*Temp*/, PI*pow(inputArray.get(5), 2), 0/*Temp*/, noseDrag);
    
    Table thrustTable = loadTable("data/thrust.csv", "header");
    grav = new Gravity();
    thrust = new Thrust(thrustTable);
    drag = new Drag(1.2);
    graph = new Graph(time/(refresh*1.0), roc.position.x/refresh, roc.position.y/refresh, roc.velocity.x, roc.velocity.y, roc.stoAcceleration.x, roc.stoAcceleration.y);
    dataTable = new Table();

    while (time <= refresh/10 || roc.position.y != 0)
    {
      if (roc.position.y >= 0.0)
      {
        if (time % (refresh/10) == 0)
        {
          graph.update(time/(refresh*1.0), roc.position.x/refresh, roc.position.y/refresh, roc.velocity.x, roc.velocity.y, roc.stoAcceleration.x, roc.stoAcceleration.y);
          graph.display(dataTable, 1);
        }
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
    
    graph.update(time/(refresh*1.0), roc.position.x/refresh, 0, roc.velocity.x, roc.velocity.y, roc.stoAcceleration.x, roc.stoAcceleration.y);
    graph.display(dataTable, 0);
    
    textAlign(CENTER);
    textFont(createFont("Ariel", 18));
    text("Rocket landed at time " + time/(refresh*1.0) + " seconds", width*3/4, height - 2);
    text("Terminal velocity: " + abs(roc.velocity.y) + " m/s", width*3/4, height - 22);
    
    saveTable(dataTable, "data/data.csv");
    open("E:/Senior Engineering Project/RocketSim_v1_3/data/data.csv");
    noLoop();
  }
}

public void input(String theText)
{
  inputArray.append(float(theText));
  state++;
}

