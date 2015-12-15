ArrayList<Graph> graph;
FloatList inputArray;
Particle particle;
Gravity grav;
Thrust thrust;
Drag drag;
Nosecone nose1;
Nosecone nose2;
Nosecone nose3;
Table table;
int time;
int refresh;
int state;
PVector x_i, v_i, a_i;

import controlP5.*;
ControlP5 cp5;
String textValue = "";

void setup() {
  size(800, 800);
  time = 0;
  state = 0;
  x_i = new PVector(0, 0);
  v_i = new PVector(0, 0);
  a_i = new PVector(0, 0);
  
  nose1 = new Nosecone(width/4, height/4, 20, #747373, 1);
  nose2 = new Nosecone(width/2, height/4, 23.5, #747373, 2);
  nose3 = new Nosecone(width*3/4, height/4, 27, #747373, 3);

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
  if (state <= 4)
  {
    background(0);
    fill(255);
    if (state == 0)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter mass of nose cone and parachute (kg):");
    } else if (state == 1)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter mass of whole rocket (kg):");
    } else if (state == 2)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter diameter of fuselage (m):");
    } else if (state == 3)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter nose cone type (choose 1, 2, or 3):");
      nose1.display();
      nose2.display();
      nose3.display();
    } else if (state == 4)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter parachute diameter (m):");
    }
  } else
  {
    float noseDrag = 0;
    if (inputArray.get(3) == 1) 
    {
      noseDrag = .32;
    } else if (inputArray.get(3) == 2)
    {
      noseDrag = .30;
    } else
    {
      noseDrag = .40;
    }
    cp5.get(Textfield.class, "input").remove();
    Table thrustTable = loadTable("data/thrust.csv", "header");
    particle = new Particle(inputArray.get(1) + .024, x_i, v_i, a_i);
    grav = new Gravity();
    thrust = new Thrust(thrustTable);
    drag = new Drag(1.2, (pow(inputArray.get(2)/2, 2) * PI), noseDrag);
    graph = new ArrayList<Graph>();
    table = new Table();
    refresh = 100;
    background(255);

    while (time <= 10 * refresh || particle.position.y != 0) {
      if (particle.position.y >= 0.0 || time <= refresh) {
        if (time % (refresh/10) == 0) {
          Graph g = new Graph(particle.position.x/refresh, particle.position.y/refresh, particle.velocity.x, particle.velocity.y, particle.stoAcceleration.x, particle.stoAcceleration.y);
          graph.add(g);    
          g.display(table, time/(refresh*1.0), 1);
        }
        if (thrust.stageChange == true)
        {
          particle.mass = inputArray.get(0);
        }
        println(particle.mass);
        grav.applyGravity(particle.mass, particle.acceleration, particle.position.y, refresh);
        thrust.applyThrust(particle.mass, particle.acceleration, particle.velocity, refresh, time);
        drag.applyDrag(particle.mass, particle.acceleration, particle.velocity, refresh);
        particle.move();
        particle.mass = thrust.burnMass(particle.mass, refresh);
        time ++;
      } else {
        Graph g = new Graph(particle.position.x/refresh, 0, particle.velocity.x, particle.velocity.y, particle.stoAcceleration.x, particle.stoAcceleration.y);
        graph.add(g); 
        g.display(table, time/(refresh*1.0), 0);
        textAlign(CENTER);
        text("Rocket landed at time " + time/(refresh*1.0) + " seconds", width/2, height);
        particle.position.y = 0;
      }
    }
    saveTable(table, "data/data.csv");
    noLoop();
  }
}

public void input(String theText) {
  inputArray.append(float(theText));
  state++;
}

