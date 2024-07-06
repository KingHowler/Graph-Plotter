import processing.serial.*;

// Graph size
int Ymin = -100;
int Ymax = 100;
float Ystep = 2.5;
int Xmin = -100;
int Xmax = 100;
float Xstep = 1;
String XTitle = "Time(s)";
String YTitle = "Data";


// Constant Variables

int TotalPoints = Xmax - Xmin; // Total number of Data Points
float[] Graph1 = new float[TotalPoints];   // Array to store Graph1
float[] Graph2 = new float[TotalPoints];   // Array to store Graph2
float[] Graph3 = new float[TotalPoints];   // Array to store Graph3
float[] Graph4 = new float[TotalPoints];   // Array to store Graph4

void setup() {
  size(1900, 970);    // Window size
  frameRate(10);  // Set frame rate to 10 frames per second (100ms interval)
  for (int i = 0; i < TotalPoints; i++ ) {
    float x = map(i, 0 , TotalPoints, Xmin, Xmax);
    Graph1[i] = (x*x) - 60;
    Graph2[i] = x;
    Graph3[i] = -x;
    Graph4[i] = -((x*x) - 60);
  }
}

void draw() {
  background(255);    // White background
  
  DrawGrid();
  // Label the axes
  fill(0);
  textAlign(CENTER);
  text(XTitle, width / 2, height - 10);
  textAlign(RIGHT);
  text(YTitle, 30, height / 2);

  // Draw the Graph1 as a graph
  stroke(255, 0, 0);  // Red color
  strokeWeight(2);    // Thickness of 2 pixels
  for (int i = 0; i < Graph1.length - 1; i++) {
    float x = map(i, 0 , TotalPoints, Xmin, Xmax);
    int x1 = int(map(x, Xmin, Xmax, 100, width));
    int y1 = int(map(Graph1[i], Ymin, Ymax, height - 50, 0));
    int x2 = int(map(x + 1, Xmin, Xmax, 100, width));
    int y2 = int(map(Graph1[i + 1], Ymin, Ymax, height - 50, 0));
    line(x1, y1, x2, y2);
  }
  // Draw the Graph2 as a graph
  stroke(0, 0, 255);  // Blue color
  strokeWeight(2);    // Thickness of 2 pixels
  for (int i = 0; i < Graph2.length - 1; i++) {
    float x = map(i, 0 , TotalPoints, Xmin, Xmax);
    int x1 = int(map(x, Xmin, Xmax, 100, width));
    int y1 = int(map(Graph2[i], Ymin, Ymax, height - 50, 0));
    int x2 = int(map(x + 1, Xmin, Xmax, 100, width));
    int y2 = int(map(Graph2[i + 1], Ymin, Ymax, height - 50, 0));
    line(x1, y1, x2, y2);
  }
  // Draw the Graph3 as a graph
  stroke(0, 255, 0);  // Green color
  strokeWeight(2);    // Thickness of 2 pixels
  for (int i = 0; i < Graph3.length - 1; i++) {
    float x = map(i, 0 , TotalPoints, Xmin, Xmax);
    int x1 = int(map(x, Xmin, Xmax, 100, width));
    int y1 = int(map(Graph3[i], Ymin, Ymax, height - 50, 0));
    int x2 = int(map(x + 1, Xmin, Xmax, 100, width));
    int y2 = int(map(Graph3[i + 1], Ymin, Ymax, height - 50, 0));
    line(x1, y1, x2, y2);
  }
  // Draw the Graph4 as a graph
  stroke(255, 150, 0);  // Orange color
  strokeWeight(2);    // Thickness of 2 pixels
  for (int i = 0; i < Graph4.length - 1; i++) {
    float x = map(i, 0 , TotalPoints, Xmin, Xmax);
    int x1 = int(map(x, Xmin, Xmax, 100, width));
    int y1 = int(map(Graph4[i], Ymin, Ymax, height - 50, 0));
    int x2 = int(map(x + 1, Xmin, Xmax, 100, width));
    int y2 = int(map(Graph4[i + 1], Ymin, Ymax, height - 50, 0));
    line(x1, y1, x2, y2);
  }
}

void DrawGrid() {
  // Y grid
  for (float i = Xmin; i < Xmax; i+= Xstep) {
      int x = int(map(i, Xmin, Xmax, 100, width));
      strokeWeight(0.5);
      stroke(200);  // Light gray color for grid
      line(x, height - 50, x, 0);
  }
  for (float i = Xmin; i < Xmax; i+= Xstep*10) {
      int x = int(map(i, Xmin, Xmax, 100, width));
      strokeWeight(1.5);
      stroke(200);  // Light gray color for grid
      line(x, height - 50, x, 0);
      textAlign(CENTER);
      fill(0);
      if (i != 0 ) {
      text(String.valueOf(i), x, height - 30);}
  }
  
  // X grid
  for (float i = Ymin; i < Ymax + 1; i+= Ystep) {
      int y = int(map(i, Ymin, Ymax, height - 50, 0));
      strokeWeight(0.5);
      stroke(200);  // Light gray color for grid
      line(100, y, width, y);
  }
  for (float i = Ymin; i < Ymax + 1; i+= Ystep*10) {
      int y = int(map(i, Ymin, Ymax, height - 50, 0));
      strokeWeight(1.5);
      stroke(200);  // Light gray color for grid
      line(100, y, width, y);
      textAlign(RIGHT);
      fill(0);
      if (i != 0 ) {
      text(String.valueOf(i), 90, y);}
  }
      // Drawing the axes
      int x = int(map(0, Xmin, Xmax, 100, width));
      int y = int(map(0, Ymin, Ymax, height - 50, 0));
      stroke(0); 
      strokeWeight(2); 
      textAlign(CENTER);
      fill(0);
      text(String.valueOf(0), x, height - 30);
      textAlign(RIGHT);
      text(String.valueOf(0), 90, y);
      line(x, height - 50, x, 0);
      line(100, y, width, y);
}
