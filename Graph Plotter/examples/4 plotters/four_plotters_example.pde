// Create 4 plotter objects
GraphPlotter GP1, GP2, GP3, GP4;

float[] Graph1;
float[] Graph2;
float[] Graph3;
float[] Graph4;

void setup() {
  // Setup the size of the window
  size(1900,970);
  
  // Initialize all plotter objects
  // plotter 1
  GP1 = new GraphPlotter();
  GP1.GraphSetup(false, true, "", "");
  GP1.GridSetup(-1, 2, 1, 0, 50, 10);
  GP1.SizeSetup(width/2, height/2);
  
  // plotter 2
  GP2 = new GraphPlotter();
  GP2.GraphSetup(false, false, "", "");
  GP2.GridSetup(0, 110, 10, -10, 10, 1);
  GP2.SizeSetup(width/2, height/2);
  GP2.Offset(0, height/2);
  
  // plotter 3
  GP3 = new GraphPlotter();
  GP3.GraphSetup(false, true, "", "");
  GP3.GridSetup(86, 106, 10, -10, 10, 5);
  GP3.SizeSetup(width/2, height/2);
  GP3.Offset(width/2, 0);
  
  // plotter 4
  GP4 = new GraphPlotter();
  GP4.GraphSetup(false, true, "", "");
  GP4.GridSetup(0, 2500, 500, -50, 50, 25);
  GP4.SizeSetup(width/2, height/2);
  GP4.Offset(width/2, height/2);
  
  // Initialize all data holders
  Graph1 = new float[GP1.totalPoints];
  Graph2 = new float[GP2.totalPoints];
  Graph3 = new float[GP3.totalPoints];
  Graph4 = new float[GP4.totalPoints];
  
  // Fill data
  fillData();
}

void draw() {
  // set background as white
  background(255);
  
  // Draw the graphs
  GP1.DrawGraph(Graph1, color(255, 0, 0));
  GP2.DrawGraph(Graph2, color(0, 0, 255));
  GP3.DrawGraph(Graph3, color(0, 255, 0));
  GP4.DrawGraph(Graph4, color(255, 160, 0));
 
  // Draw the grids
  GP1.DrawGrid();
  GP2.DrawGrid();
  GP3.DrawGrid();
  GP4.DrawGrid();
}

void fillData() {
  // fill graph1 with square wave
  for (int i = 0; i < GP1.totalPoints; i+=5) {
    for (int i2 = 0; i2 < 6; i2++) {
      i++;
      if (i + 5 < GP1.totalPoints) {
        Graph1[i] = 0;
        Graph1[i + 5] = 1;}
    }
  }
  
  // fill graph2 with y = 96-x
  for (int i = 0; i < GP2.totalPoints; i++) {
    Graph2[i] = 96 - GP2.x(i);
  }
  
  // fill graph3 with y = 96-x as well
  for (int i = 0; i < GP3.totalPoints; i++) {
    Graph3[i] = 96 - GP3.x(i);
  }
  
  for (int i = 0; i < GP4.totalPoints; i++) {
    Graph4[i] = GP4.x(i)*GP4.x(i);
  }
}
