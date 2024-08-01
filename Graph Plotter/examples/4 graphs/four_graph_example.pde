// Declare GP as a GraphPlotter
GraphPlotter GP;

// Declare Data Holders as arrays of floats
float[] Graph1;
float[] Graph2;
float[] Graph3;
float[] Graph4;

void setup() {
  // Setup Window Size
  size(1900, 970);
  
  // Create GP Object
  GP = new GraphPlotter();
  
  // Setup GP 3 of 3
  GP.GraphSetup(true, true, "X Axis", "Y Axis");
  GP.GridSetup(-100, 200, 30, -87, 87, 10);
  GP.SizeSetup(width, height);
  
  // Initialize Data Holders
  Graph1 = new float[GP.totalPoints];
  Graph2 = new float[GP.totalPoints];
  Graph3 = new float[GP.totalPoints];
  Graph4 = new float[GP.totalPoints];
  
  // Fill with Data
  fillData();
}

void fillData() {
  for (int i = 0; i < GP.totalPoints; i+=17) {
    for (int i2 = 0; i2 < 18; i2++) {
      i++;
      if (i + 17 < GP.totalPoints) {
        Graph1[i] = -80;
        Graph1[i + 17] = 80;}
    }
  }
  for (int i = 0; i < GP.totalPoints; i++) {
    float x = GP.x(i);
    Graph2[i] = 4*(x) - 29;
    Graph3[i] = -x;
    Graph4[i] = -((x*x) - 60);
  }
}

void draw() {
  // Set Background as White
  background(255);
  // Draw the Graphs
  GP.DrawGraph(Graph1, color(255,0,0));
  GP.DrawGraph(Graph2, color(0,0,255));
  GP.DrawGraph(Graph3, color(0,255,0));
  GP.DrawGraph(Graph4, color(255,160,0));
  
  // Draw the Grid
  GP.DrawGrid();
}
