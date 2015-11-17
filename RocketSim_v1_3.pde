ArrayList<Graph> graph;
Particle particle;
Table table;
int time;
int refresh;
PVector x_i, v_i, a_i;

void setup() {
  size(800, 800);
  time = 0;
  x_i = new PVector(0,0);
  v_i = new PVector(0,0);
  a_i = new PVector(0,0);
  particle = new Particle(x_i,v_i,a_i);
  graph = new ArrayList<Graph>();
  table = new Table();
  refresh = 60;
  noLoop();
}

void draw() {
  background(255);
  while(time <= 10 * refresh) {
    if (particle.position.y >= 0 || time == 0) {
      if (time % (refresh/10) == 0) {
        Graph g = new Graph(particle.position.x/refresh, particle.position.y/refresh, particle.velocity.x, particle.velocity.y, particle.stoAcceleration.x, particle.stoAcceleration.y);
        graph.add(g);    
        g.display(table, time/(refresh*1.0));
      }
      particle.move(refresh, time);
      time ++;
    } else {
      textAlign(CENTER);
      text("Rocket landed at time " + time/(refresh*1.0) + " seconds", width/2, height);
      time = 10 * refresh + 1;
    }
  }
  saveTable(table, "data/data.csv");
}
