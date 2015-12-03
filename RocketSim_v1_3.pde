ArrayList<Graph> graph;
FloatList inputArray;
Particle particle;
Gravity grav;
Thrust thrust;
Drag drag;
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
  if (state <= 3)
  {
    background(0);
    fill(255);
    if (state == 0)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter mass of rocket (kg):");
    } else if (state == 1)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter average engine thrust (newtons):");
    } else if (state == 2)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter engine thrust time (seconds):");
    } else if (state == 3)
    {
      cp5.get(Textfield.class, "input").setLabel("Enter cross-area of nose cone (meters):");
    }
  } else
  {
    cp5.get(Textfield.class, "input").remove();
    particle = new Particle(inputArray.get(0), x_i, v_i, a_i);
    grav = new Gravity(particle.mass);
    thrust = new Thrust(particle.mass, inputArray.get(1), inputArray.get(2));
    drag = new Drag(particle.mass, 1, inputArray.get(3), .47);
    graph = new ArrayList<Graph>();
    table = new Table();
    refresh = 60;
    background(255);

    while (time <= 10 * refresh) {
      if (particle.position.y >= 0 || time == 0) {
        if (time % (refresh/10) == 0) {
          Graph g = new Graph(particle.position.x/refresh, particle.position.y/refresh, particle.velocity.x, particle.velocity.y, particle.stoAcceleration.x, particle.stoAcceleration.y);
          graph.add(g);    
          g.display(table, time/(refresh*1.0));
        }
        grav.applyGravity(particle.acceleration, particle.position.y, refresh);
        thrust.applyThrust(particle.acceleration, particle.velocity, refresh, time);
        drag.applyDrag(particle.acceleration, particle.velocity, refresh);
        particle.move();
        time ++;
      } else {
        Graph g = new Graph(particle.position.x/refresh, 0, particle.velocity.x, particle.velocity.y, particle.stoAcceleration.x, particle.stoAcceleration.y);
        graph.add(g);    
        g.display(table, time/(refresh*1.0));
        textAlign(CENTER);
        text("Rocket landed at time " + time/(refresh*1.0) + " seconds", width/2, height);
        time = 10 * refresh + 1;
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

